# XSP (Transport Services Provider) — threading for application writers

Companion to SKILL.md §7 (Threading). Read this when an application
uses, or is considering, XSPs, or when reviewing code whose
correctness depends on callbacks being serialized on one context thread.
Describes UM 6.17.1.

XSP does not change the API surface of callbacks. It changes **which
thread calls them**, and therefore which callbacks can run concurrently.
Code that is correct with a single context thread can become racy,
without a compile error or a config warning, once a transport mapping
callback is installed.

## 1. What an XSP is

- An XSP is a receive-side "reduced-function sub-context" owned by a
  parent context. Created with `lbm_xsp_create()` (Java/.NET: `LBMXSP`).
- By default each XSP spawns its own thread (the "XSP thread"). With
  XSP `operational_mode` = `sequential`, the application supplies the
  thread and calls `lbm_xsp_process_events()` in a loop. It must stop
  that loop with `lbm_xsp_unblock()` before deleting the XSP.
- Creating an XSP does nothing by itself. The context option
  `transport_mapping_function` installs an application callback that UM
  calls each time the context is about to join a subscribed **transport
  session**. The callback returns the XSP to use, or NULL for "stay on
  the context thread".
- Only LBT-RM, LBT-RU and TCP receive transport sessions can be mapped.
  IPC, SMX and DBL cannot. XSP is incompatible with HF, ULB and
  receive-side batching.
- XSP is purely receive-side. Sources are never on an XSP.

## 2. Which thread runs which callback

| Callback / event | Thread with XSP in use |
| --- | --- |
| Receiver callback (data, requests, and other `lbm_msg_t` types) for a transport session mapped to an XSP | That XSP's thread (or the app thread pumping a sequential XSP) |
| Receiver callback for a transport session not mapped (mapping returned NULL) | Context thread |
| Receiver callback for MIM/UIM messages sent to the topic | Context thread |
| `lbm_schedule_timer()` timers on the context | Context thread |
| Responses to `lbm_send_request()` (arrive on the context's UIM/request port) | Context thread |
| Topic resolution callbacks (e.g. `resolver_source_notification_function`) | Context thread |
| `transport_mapping_function` callback | Context thread |
| XSP `zero_transports_function` callback | Context thread |
| Source events | Context thread, except that source flight-size "UNDER" notifications may come from "the context (or XSP) thread" (lbm.h), while "OVER" comes from the thread calling send |
| Anything associated with an event queue | That event queue's dispatch thread |

There is no XSP timer API. Application timers always belong to the
context.

## 3. Serialization rules the customer must re-check

1. **Receiver callbacks are no longer serialized with timers.** This is
   the most common break. Any design of the form "timer callback cleans
   up state that the receiver callback uses" (message timeouts,
   heartbeats, stale-data detection) is racy once the transport session
   is on an XSP.
2. **Receiver callbacks are no longer serialized with other receivers.**
   Two transport sessions on different XSPs deliver concurrently,
   including to the same receiver object and the same callback.
3. **One topic can be delivered by two threads.** XSPs map transport
   sessions, not topics. Topic X from publisher A and topic X from
   publisher B are usually on different transport sessions. If those
   sessions map to different XSPs, the receiver callback for X runs
   concurrently on two threads. The only ways to keep a topic
   single-threaded are to map all its sessions to one XSP, or to
   control how publishers map topics to transport sessions. The mapping
   callback's `lbm_new_transport_info_t` has the source address and
   source string but **no topic**. Correlating sessions to topics needs
   the resolver source notification callback.
4. **Even with a single XSP, the receiver callback can run on two
   threads.** It runs on the XSP thread for source traffic, and on the
   context thread for UIM/MIM sent to the same topic. That includes
   `lbm_unicast_immediate_request()` / multicast immediate requests to
   the topic. UM's guidance is to have each topic sent by only one kind
   of sender (source, UIM, or MIM).
5. **Multicast group:port sharing.** If a context has already joined a
   transport session on a given multicast group and destination port,
   joining another session on the same group:port does **not** call the
   mapping callback again. Both use the same socket, and so the same
   thread. A mapping policy keyed on source address cannot separate
   them.
6. **`clientd` state is now shared memory.** Anything reachable from a
   receiver's `clientd` that is also touched by timers, other
   receivers, or main needs real synchronization (mutex or atomics with
   correct memory ordering). This is no longer "the context thread
   serializes it for me".

## 4. API restrictions on XSP threads

XSP-thread callbacks carry the same restrictions as context-thread
callbacks:

- Return quickly. Never block. Blocking an XSP thread starves every
  transport session mapped to it, and can trigger spurious EOS via
  activity timeouts (SKILL.md §7).
- Sends and responses must use `LBM_SRC_NONBLOCK` and handle
  `LBM_EWOULDBLOCK`.
- Do not create or delete sources or receivers.
- Scheduling UM timers is allowed.
- Do not call `lbm_xsp_create()` from a receiver callback. It *is*
  allowed inside the mapping callback, which runs on the context thread.
- Do not call `lbm_xsp_delete()` from a context or XSP callback. The one
  exception is the XSP's own `zero_transports_function` callback.
- `lbm_xsp_register_fd()` is "not recommended" from an XSP-thread
  callback.
- Sequential-mode XSP: `lbm_xsp_process_events()` must not be called
  from a context-thread callback.

## 5. Deletion and races

- **Order:** cancel timers → delete requests → delete sources/receivers
  (and cancel registered fds) → **delete XSPs** → delete contexts →
  delete event queues. UM recommends keeping all XSPs until the parent
  context is about to be deleted, because receivers (and DRO hot-links)
  can hold non-obvious references to an XSP that no longer has active
  transport sessions.
- **`lbm_rcv_delete()` is the synchronization point for XSP callbacks.**
  Without an event queue, once `lbm_rcv_delete()` returns, the XSP will
  make no more callbacks for that receiver. With an event queue, use
  `lbm_rcv_delete_ex()` or event sync. While the delete is in progress,
  the XSP may still deliver messages, so the callback's resources must
  stay valid until the delete returns.
- **Event sync does not cover XSP threads.** The "zero-duration timer"
  event-sync technique runs on the context thread (or the timer's event
  queue). It proves that callbacks on *that* thread or queue are
  finished. It proves nothing about an XSP thread. Use it for evq and
  timer cleanup, not as a barrier against XSP delivery.
- **Timer cancel cannot tell you "already fired".** In 6.17.1,
  `lbm_cancel_timer()` returns 0 for a timer that has already fired or
  is executing (it returns -1 only for invalid arguments). A receiver
  callback on an XSP thread that cancels and re-arms a timeout timer
  cannot use the return value to detect that the timer callback is
  running concurrently. Keep an application state flag under a lock
  (for example "timed out, do not re-arm") and check it in both
  callbacks.

### Pattern: message-timeout timer with an XSP receiver

`lbm_rcv_delete()` must not be called from a context-thread callback,
and a timer callback is one, so the timer cannot delete the receiver
itself. A shape that respects that rule:

1. Receiver callback (XSP thread): lock; if `state != ACTIVE`, unlock
   and return; record the message; cancel and re-schedule the timeout
   timer (scheduling is allowed from callbacks); unlock.
2. Timer callback (context thread): lock; if a message arrived since
   arming, unlock and return; set `state = TIMED_OUT`; unlock; signal
   an application thread.
3. Application thread: `lbm_rcv_delete()`. When it returns, no more XSP
   callbacks for that receiver. Then free the receiver's state.

The `state` flag, not the cancel return value, is what closes the
timer-vs-message race.

## 6. Ways to get serialization back

- **Map everything to one XSP.** This separates message processing from
  UM housekeeping (TR, timers) for latency, and keeps all
  transport-session delivery on one thread. It still does not serialize
  receivers with timers or with UIM/MIM (rules 1 and 4).
- **Event queue.** Receivers on XSP-mapped sessions may use an event
  queue. If receivers, timers and the other callbacks that must be
  serialized all use the *same* event queue, the dispatch thread
  serializes them again, at the usual evq cost (kernel call per
  enqueue/dequeue, extra latency). This trades away much of what XSP was
  adopted for. Check that before recommending it.
- **Don't use XSP.** The guidance in configuration_best_practices.md
  stands: adopt XSP only after profiling shows that receive-side
  serialization (for example data waiting behind TR or a timer
  callback) causes the latency outliers.

## 7. Operational notes that affect threading-sensitive code

- Each XSP has its own unicast listener (request) port. Widen
  `request_tcp_port_low` / `request_tcp_port_high` to cover the context
  plus every XSP, or XSP creation can fail.
- An XSP inherits the parent context's configuration. A context
  attribute object passed to `lbm_xsp_create()` can override it, but
  this is rarely needed.
- Persistent receivers on an XSP require
  `ume_proactive_keepalive_interval` to be enabled.
- The mapping callback runs on the context thread for every new
  transport session. It must not block, or it delays everything else
  the context does, including TR.

## 8. Review checklist (XSP in use)

- [ ] Is any state shared between a receiver callback and a timer
      callback? If so, it is now concurrent: lock it, and never rely on
      `lbm_cancel_timer()`'s return value.
- [ ] Can one receiver's transport sessions be mapped to more than one
      XSP? If so, the callback must be reentrant for that receiver.
- [ ] Is the topic also reachable via UIM/MIM (including
      immediate requests)? If so, the callback runs on the context
      thread as well.
- [ ] Do any XSP-thread callbacks block, send without
      `LBM_SRC_NONBLOCK`, or create/delete UM objects?
- [ ] Are receivers deleted (from an application thread) before their
      resources are freed, and XSPs deleted only after all receivers?
- [ ] Is event sync being relied on to prove XSP callbacks are done?
      It doesn't.
- [ ] Is the request-port range wide enough for the context plus all
      XSPs?

## Source notes

Sources: the Concepts Guide (sections "Transport Services Provider
(XSP)", "XSP Threading Considerations", "XSP Usage", "Other XSP
Operations", "XSP Restrictions", "Sequential Mode", "Deleting UM
Objects", "Callback After Delete", "Event Sync", "Message Reception"),
`lbm.h` (`lbm_xsp_*`, `lbm_transport_mapping_cb_proc`,
`lbm_rcv_delete`, `lbm_cancel_timer`), and the 6.17.1 library source
for the timer-cancel return values.
