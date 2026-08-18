# lbmstrm — Send Loop Behavior and EWOULDBLOCK Handling

This file documents findings from source analysis of
`$LBM_REPO/src/example/lbmstrm.c`. Read when asked about lbmstrm's
message generation behavior, rate accuracy, or what happens when sends
are blocked or delayed.

## Purpose

`lbmstrm` sends messages to N topics at a specified rate (default
10,000 msg/sec across 100 sources, 1 thread). It is a throughput test
tool, not a production pattern.

## The timing algorithm

The send loop (`sending_thread_main`) uses an **absolute schedule**:

```c
next_msg_usec = (msg_num * 1000000) / thrd_msgs_per_sec;
```

`msg_num` increments monotonically from zero. `cur_usec` is
microseconds since the sending start timestamp. The loop waits until
`cur_usec >= next_msg_usec`, sends, increments `msg_num`, and repeats.

**Key property:** the schedule is fixed and does not slide forward
when a send is late. If `lbm_src_send()` returns slowly, or if the
wait mechanism oversleeps, the next `next_msg_usec` is already in the
past when the loop re-evaluates — the loop sends immediately without
waiting.

**Result: catch-up bursts.** Any delay longer than one inter-message
interval causes back-to-back sends until the schedule is caught up.
The long-term average rate is preserved; the instantaneous rate is
not.

## Two wait modes

Controlled by `-t` (tight loop):

**Non-tight (default):** sleeps in 20 ms chunks:
```c
SLEEP_MSEC(20);
```
At the default 10,000 msg/sec (100 µs inter-message interval), the
loop wakes after 20 ms and finds ~200 messages overdue, sending all
200 back-to-back. This produces a **structural burst-then-sleep
pattern** regardless of any `lbm_src_send()` delay. The bursts are
a property of the sleep granularity, not of UM behavior.

**Tight loop (`-t`):** busy-polls `cur_usec_ofs()`. No forced
granularity. Delays in `lbm_src_send()` cause proportional catch-up
bursts but the baseline spacing between sends is as fine as the
clock resolution allows.

## EWOULDBLOCK handling

`lbmstrm` uses `LBM_SRC_NONBLOCK` on every send. When the rate
limiter or flight size would block, `lbm_src_send()` returns
`LBM_FAILURE` with `lbm_errnum() == LBM_EWOULDBLOCK`.

```c
if (rc == LBM_FAILURE) {
    if (lbm_errnum() == LBM_EWOULDBLOCK) {
        block_cntr++;
        if (block_cntr % 1000 == 0) {
            printf("LBM send blocked 1000 times\n");
        }
    } else {
        fprintf(stderr, "lbm_src_send: %s\n", lbm_errmsg());
        exit(1);
    }
}
++ msg_num;   /* unconditional */
```

**The message is silently discarded.** `msg_num` and the send
schedule advance unconditionally whether the send succeeded or not.
The app moves on to the next scheduled message on the next source.

`block_cntr` is a pure diagnostic counter — it prints a warning every
1000 blocks and has no other effect. It is never reset, never
influences send behavior, and never feeds into stats.

## UM sequence number behavior on EWOULDBLOCK

Although lbmstrm discards the message at the application level,
**the UM transport sequence number does not advance** on
`EWOULDBLOCK`. Source: `lbmsrc.c:4085–4088`:

```c
res = lbm_src_send_buff_data(src, buff, flags, exinfo);
if (res != -1) {
    src->seqnum++;
}
```

All `EWOULDBLOCK` paths return `-1` before reaching `seqnum++`. The
transport stream therefore has **no sequence gap** from a blocked
send — the next successful send gets the next contiguous sequence
number. Any gap a receiver sees from lbmstrm is caused by network
loss, not by blocked sends.

## Source rotation

With N sources and T threads, thread index `thrdidx` sends to sources
`thrdidx`, `thrdidx + T`, `thrdidx + 2T`, ... Each thread cycles
through its subset of sources round-robin per message. `count`
increments when the thread wraps back to its first source — so
`count` is the number of full rotations completed by that thread.

## What lbmstrm is and is not

- **Is:** a transport-layer throughput generator. Useful for verifying
  network capacity, NAK recovery, and receiver behavior under load.
- **Is not:** a production send pattern. Silent discard on
  `EWOULDBLOCK`, no retry, no message durability, no flow control
  feedback to the application. The burst-then-sleep pattern from the
  20 ms sleep granularity makes it unsuitable for latency measurement.
