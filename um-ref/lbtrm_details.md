---
name: lbtrm-details
description: LBT-RM protocol internals — NAK suppression algorithm, timer interactions, NCF behavior, rate limiting. Read when designing or tuning LBT-RM configuration. For per-option defaults, use config-data.xml; for actionable rules, see configuration_best_practices.md §2.
metadata:
  type: reference
---

# LBT-RM Protocol Details

LBT-RM is UM's reliable multicast transport — UDP multicast for data
delivery, with a NAK/retransmission mechanism for loss recovery. It is
deliberately different from PGM in several ways; see §4.

Source: `doc/Design/index.m4` §transportlbtrm, §naksuppression,
§comparinglbtrmndpgm.

---

## 1. Session ID

Each LBT-RM source generates a unique random 32-bit non-zero Session ID
per transport session. The Session ID is included in Topic Resolution
advertisements (TIRs). Receivers use it to distinguish sessions and
detect source restarts.

---

## 2. NAK Suppression — overview

The central design goal of LBT-RM is to recover occasional loss quickly
while preventing a "crybaby receiver" from triggering a NAK storm that
overwhelms healthy receivers. The mechanism is called **NAK Suppression**
and involves five timers across source and receiver. Their interactions
are the main tuning surface.

---

## 3. Timer-by-timer walkthrough

### 3.1 `transport_lbtrm_nak_initial_backoff_interval` (receiver, default 50 ms)

When a receiver detects a gap (missing sequence number), it does **not**
NAK immediately. It backs off for a random time in the range
[0.5×, 1.5×] of this value (i.e. 25–75 ms at defaults) before sending
the first NAK.

**Why:** Multiple receivers typically see the same loss at nearly the
same time. Randomized backoff staggers their NAKs so the fastest one
fires first. When the retransmission arrives, slower receivers see the
missing sequence number and cancel their pending NAKs without ever
sending them — suppressing a flood of redundant NAKs from the start.

### 3.2 `transport_lbtrm_ignore_interval` (source, default 500 ms)

After the source sends a retransmission for a sequence number, it starts
this timer. For the duration of the interval, any subsequent NAK for
that sequence number is **rejected** — the source does not retransmit
again. Instead, it sends an NCF (NAK Confirmation Frame) with reason
"ignored" to the receiver that sent the duplicate NAK.

As of UM 6.10: only the *first* rejected NAK within an ignore interval
triggers an NCF. Further NAKs in the same ignore interval are silently
discarded. This reduces NCF traffic under heavy loss.

**Why:** Without this, a burst of NAKs from many receivers for the same
sequence number would cause the source to retransmit many times,
consuming retransmit rate budget and flooding the network.

### 3.3 `transport_lbtrm_nak_backoff_interval` (receiver, default 200 ms)

After sending a NAK, the receiver waits a random time in the range
[0.5×, 1.5×] of this value before sending a **retry NAK** (if the
missing data has still not arrived). At defaults: 100–300 ms.

This timer governs all retry NAKs after the first one, unless a NAK
suppress interval is running (see §3.4).

### 3.4 `transport_lbtrm_nak_suppress_interval` (receiver, default 1000 ms)

When the receiver receives an NCF from the source (reason "ignored"),
it adds this value to the outstanding retry timer for that sequence
number. The receiver will not send another NAK until this extended
timer expires.

**Why:** The NCF tells the receiver "I know about your loss but I'm not
retransmitting right now." Suppressing the receiver's NAK for a full
second prevents it from hammering the source while it's busy or rate-
limited.

### 3.5 `transport_lbtrm_nak_generation_interval` (receiver, default 10000 ms)

The total time a receiver will continue attempting to recover a lost
sequence number before declaring it **unrecoverable loss** and notifying
the application. The clock starts when loss is first detected.

---

## 4. The critical ignore/backoff interaction

The ignore interval (source) and NAK backoff interval (receiver) must be
coordinated or recovery is unnecessarily delayed.

**The failure scenario** (defaults illustrate the problem):

1. Receiver detects gap → waits initial backoff (~50 ms) → sends NAK.
2. Source retransmits, starts `ignore_interval` (500 ms).
3. Retransmission is lost. Receiver never sees it.
4. After ~backoff interval (100–300 ms), receiver sends retry NAK.
5. Source's ignore_interval is still running (expires at 500 ms). The
   retry NAK arrives inside the ignore window → source sends NCF instead
   of retransmitting.
6. Receiver gets NCF → starts `nak_suppress_interval` (1000 ms). Will
   not retry for another second.
7. At ~1000–1300 ms, suppress expires, receiver finally sends another
   NAK and the source retransmits.

The retry NAK at step 4 was **guaranteed to be wasted** because backoff
(200 ms, range 100–300 ms) overlaps with ignore (500 ms). It did not
recover the data; it only armed the suppress timer and delayed recovery
by ~1 s.

**The rule** (stated in `config-data.xml` long-desc for ignore_interval):

```
ignore_interval ≤ 0.5 × nak_backoff_interval
```

Because receiver randomizes to [0.5×, 1.5×] of backoff, the *shortest
possible* retry arrives at 0.5 × backoff. The ignore interval must
close before that earliest possible retry — i.e. ignore < 0.5 × backoff.
The `≤` in the doc is effectively `<` in practice.

The shipped defaults violate this: 500 ms ignore vs 0.5 × 200 ms = 100 ms.

**Example conforming values:** ignore_interval 50 ms, nak_backoff_interval
200 ms. Or if you want faster recovery: ignore 20 ms, backoff 100 ms.

**Warning from the UM doc:** Setting retransmit rate too high or NAK
backoff too low reduces protective characteristics and risks
NAK/retransmission storms. Always validate the full timer set together.

---

## 5. Full timeline — retransmission lost, conforming config

Assumptions: initial_backoff 50 ms, ignore 50 ms, backoff 200 ms,
suppress 1000 ms. All random values shown at midpoint.

```
t=0       Receiver detects gap.
t=50 ms   First NAK sent (after initial backoff).
t=50 ms   Source retransmits, starts ignore (expires t=100 ms).
          Retransmission lost.
t=100 ms  Source's ignore_interval expires.
t=200 ms  Receiver's backoff fires. Retry NAK sent.
          Source is no longer ignoring → retransmits again.
          Recovery complete.
```

Worst-case (retry arrives at 1.5× backoff = 300 ms): still well clear
of the ignore window.

---

## 6. Rate limiting and NCFs

Two rate limits gate retransmissions:

- **`transport_lbtrm_data_rate_limit`** (context, default 10 Mbps) —
  aggregate cap on original data + retransmissions combined for all
  LBT-RM sessions on this context.
- **`transport_lbtrm_retransmit_rate_limit`** (context, default 5 Mbps)
  — separate cap on retransmissions only. Should be ≤ data_rate_limit.

When either cap is hit, the source **sends an NCF** instead of
retransmitting. This arms the receiver's suppress timer (1 s at default)
— potentially delaying recovery substantially under heavy loss.

Size retransmit_rate_limit to cover a burst recovery scenario: at
10 Mbps data rate, a 1-second outage creates 10 Mbps of retransmit
demand. A 5 Mbps retransmit limit can't keep up — recovery falls behind
until the nak_generation_interval expires and the data becomes
unrecoverable.

---

## 7. Differences from PGM

LBT-RM shares PGM's NAK/NCF vocabulary but differs in key ways:

| Aspect | PGM | LBT-RM |
|---|---|---|
| NCF on every NAK | Yes — source always NCFs before retransmitting | **No** — source retransmits immediately on first NAK; NCF only when rejecting |
| Session advertisements (SPMs) | Continuous | Only when data stops flowing (exponential backoff to configurable max) |
| Topic multiplexing | No | Yes — multiple topics share one LBT-RM session; separate per-topic sequence numbers |
| Rate control | Not specified | Configurable data + retransmit rate limiters |
| Recovery time bound | Not specified | `nak_generation_interval` — configurable max recovery window |
| Delivery ordering | In-order only | Per-topic choice: in-order or arrival-order |

The key practical consequence: in PGM, a receiver always waits for an
NCF before it knows a retransmission is coming. In LBT-RM, the
retransmission itself is the confirmation — no round-trip NCF on the
normal path. This is the source of LBT-RM's lower recovery latency.

---

## 8. Session-level vs source/receiver-level option behavior

Several LBT-RM options affect the *transport session* rather than the
individual source or receiver object. The session takes the value from
the **first** source (or receiver) created on that session and ignores
subsequent objects' configuration for that option. This means option
values on second, third, etc. sources sharing a session are silently
ignored for these options.

Affected options include `ignore_interval`, `nak_backoff_interval`,
`nak_suppress_interval`, `nak_generation_interval`. In practice: ensure
all sources or receivers that share a transport session agree on these
values, or set them at the template level so there is only one value
in play.
