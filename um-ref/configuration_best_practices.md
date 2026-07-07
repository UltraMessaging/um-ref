# UM Configuration Best Practices

Actionable checklist drawn from `SKILL.md`, `config_details.md`, and
`store_config.md`. Use this when writing, auditing, or debugging a UM
application or Store configuration. For per-option lookup, use
`config-data.xml`; for prose on config file structure, see
`config_details.md`.

---

## 1. UM Library (Application) Config

### Always use `_attr_create_from_xml()`, never `_create()`

`lbm_*_attr_create()` (the non-`_from_xml` form) does **not** read the
XML config table. Options set as XML defaults are silently ignored, but
XML `<allow>`/`<deny>` constraints are still enforced — producing a
confusing "my default was ignored *and* I got a deny error" failure.

Rule: always call `lbm_*_attr_create_from_xml()` (Java:
`new LBMContextAttributes("name")`), even when you pass `""` as the name.
The `_from_xml` form degrades to plain `_create` behavior when no XML has
been loaded — it is strictly safer.

### Check for soft config errors

UM's config parser (since 6.13) logs errors and continues on unrecognized
option names and out-of-range values — it does **not** throw or return
failure just for those. The return value of `lbm_config()` /
`LBM.setConfigurationXml()` is the only programmatic hint for the soft
cases. Always:

1. Check the return value.
2. Inspect the UM logger output immediately after loading config. Soft
   errors appear there and nowhere else.
3. Treat any unrecognized-option log line as a build-breaking error during
   development (a typo in a UMP option name silently applies no value).

Store and DRO configs are **strict** — errors are fatal. UM library config
loaded *by* the Store (`<lbm-config>` or `<xml-config>` in the Store XML)
still uses the lenient mode.

### Specify interfaces explicitly

UM's "first multicast-capable, non-loopback interface" default depends on
OS reporting order, which can change across kernel versions and hardware
moves. On multi-homed hosts always set `resolver_multicast_interface` (or
equivalent) explicitly.

Three accepted forms:
- **CIDR** — `192.168.0.0/24`. Prefix length need not match the netmask;
  UM scans for the first interface whose IP falls in the masked network.
  `10.0.0.0/8` is the standard "any 10.x interface" idiom.
- **Device name** — must be in double quotes: `"en0"`. In XML use
  `&quot;en0&quot;`.
- **DNS hostname** — resolved at parse time; doesn't track DNS changes.

Setting `resolver_multicast_interface` also changes `LBT-RM` and MIM
interfaces (same option drives all three).

### `resolver_multicast_ttl` — set by use case, not by convention

- **On-box TR domain** (explicit goal: TR traffic must not leave the
  host): set `resolver_multicast_ttl = 0`. Without it, multicast TR
  traffic can escape the host even if the application data never does.
- **Off-box multicast TR** (TR spanning a LAN segment): set TTL high
  enough to reach all participants. Use switch-level multicast policy
  (IGMP snooping, VLAN boundaries) for containment — do not rely on TTL
  as a network boundary. TTL is hop-count only; it cannot substitute for
  proper switch configuration.

### XML declaration consistency

The XML declaration (`<?xml version="1.0" encoding="UTF-8" ?>`) is
optional (UTF-8 is the default for XML 1.0), and neither the UM library
parser nor `umestored` requires it. Include it or omit it, but be
consistent across all config files on a device. Inconsistency is noise
and has caused confusion in code review.

### Disable implicit batching for low-latency sends

`implicit_batching_minimum_length` defaults to 2048 bytes. To minimize
per-message latency (e.g., streaming request/response over TCP), set it
to `1`. This disables implicit batching — each send is transmitted
immediately. For throughput-oriented sources, leave it at the default or
raise it to 8192.

---

## 2. Interrelated Option Pairs

Setting these independently produces NAK storms, false timeouts, or
undetected loss. The recurring rule: *the timeout must be a multiple of
the check/keepalive interval* so a single missed check doesn't trip
the timeout.

| Concern | Options | Rule |
| ------- | ------- | ---- |
| LBT-RM/RU NAK storms | `transport_*_nak_backoff_interval`, `transport_*_nak_generation_interval` | gen ≥ 2× backoff |
| LBT-RM ignore vs backoff | `transport_lbtrm_ignore_interval` (source), `transport_lbtrm_nak_backoff_interval` (receiver) | `ignore_interval` < 0.5 × `nak_backoff_interval`. Receiver randomizes its retry time to [0.5×, 1.5×] backoff; if ignore_interval ≥ 0.5 × backoff, the retry NAK is guaranteed to arrive while the source is still ignoring — it gets an NCF instead of a retransmission, arms the 1 s suppress timer, and recovery is delayed by ~1 s unnecessarily. Defaults (500 ms ignore, 200 ms backoff) violate this: 500 ≥ 0.5 × 200 = 100. |
| Tail loss visibility | `transport_topic_sequence_number_info_interval`, `…_active_threshold`, `transport_*_nak_generation_interval` | active_threshold (s) ≥ (4× TSNI interval + NAK gen interval) ÷ 1000 |
| Undetected loss | `delivery_control_loss_check_interval`, `transport_*_activity_timeout`, `transport_*_nak_generation_interval` | activity_timeout > loss_check + NAK gen; NAK gen ≥ 4× loss_check. **Always enable `delivery_control_loss_check_interval` for UMP receivers.** |
| Late-join transport drop | `retransmit_request_generation_interval`, `transport_*_activity_timeout` | RX-req interval < activity_timeout |
| LBT-IPC receiver deafness | `transport_lbtipc_activity_timeout`, `transport_lbtipc_sm_interval` | activity ≥ 2× sm_interval |
| Erroneous LBT-RM/RU session timeout | `transport_lbt*_activity_timeout`, `transport_lbt*_sm_maximum_interval` | activity ≥ 3× sm_maximum_interval |
| Store activity timeout | `ume_store_activity_timeout`, `ume_store_check_interval` | activity ≥ 5× check |
| Unicast resolver timeout | `resolver_unicast_activity_timeout`, `resolver_unicast_check_interval` | activity ≥ 5× check (or both 0 to disable) |
| **Store registration hangs** | `ume_sri_request_maximum`, `ume_sri_request_interval`, `transport_topic_sequence_number_info_request_maximum`, `transport_topic_sequence_number_info_request_interval`, `transport_*_activity_timeout` | request duration (interval × maximum) ≥ 2× activity_timeout. **The shipped defaults violate this.** Double `ume_sri_request_maximum` and `transport_topic_sequence_number_info_request_maximum` from their defaults (60 → 120) when configuring any UMP receiver. |
| Multicast address range | `transport_lbtrm_multicast_address_low`, `transport_lbtrm_multicast_address_high` | Don't reverse them. Reversed values silently produce a huge range. |
| Store ACK batching vs flight size | `stability-ack-minimum-number` (Store), `ume_flight_size` (source) | `stability-ack-minimum-number` must be **strictly less than** `ume_flight_size`. If equal or greater, sources stall waiting for a batch that only completes on `stability-ack-interval` — "stop-and-go" sending. |
| Store keepalive vs activity timeout | `keepalive-interval` (Store), `source-activity-timeout` / `receiver-activity-timeout` (Store) | activity timeout ≥ 2× keepalive-interval |

---

## 3. Store (`umestored`) Config

### Pre-create cache and state directories

`umestored` will **not** create `disk-cache-directory` or
`disk-state-directory`. If they don't exist the Store fails to start —
often with a confusing error. Create them before starting the Store.

### Size `source-state-lifetime` for your longest offline window

If a source's state lifetime (whichever is shorter: Store
`source-state-lifetime` or source's `ume_state_lifetime`) expires while
the source is offline, the Store releases the RegID and discards the
cached messages. When the source reconnects it re-registers as new and
starts from current — **messages accumulated during the offline window
are silently lost**.

For this architecture's months-long offline scenario: set
`source-state-lifetime` to cover the longest tolerable offline period
plus margin. `0` disables the timeout (state lives forever — the most
conservative choice until the offline window is quantified).

### Don't co-locate QC Store instances

Multiple Stores in a single QC group must run on **separate hosts**, in
**separate processes**. Co-locating them on one host (or one process)
defeats the redundancy QC is meant to provide — one hardware failure
takes out the quorum.

### `retransmission-request-forwarding` is incompatible with "mark stored message invalid"

Do not enable `retransmission-request-forwarding` if you are also using
the "mark stored message invalid" feature. These are explicitly
incompatible.

### `restore-last` requires a first full-restore pass

On the first restart after enabling `<restore-last>`, the Store still does
a full restore to build its index. Subsequent restarts are fast. Don't
mistake that initial slow start for a bug.

### `allow-proxy-source` in QC deployments

If using QC groups, add `proxy-source-repo-quorum-required=1` alongside
`allow-proxy-source=1`. Without it, a Store with no valid quorum can still
elect itself proxy source and advertise stale or missing data.

---

## 4. Persistence Pitfalls (UMP)

From `SKILL.md` §17, condensed:

1. **RegID collisions.** Manual RegID management across restarts or hosts
   without a discipline for uniqueness corrupts receiver ACK state. Use
   Session IDs (`ume_session_id` / `ume_session_id_context`) unless you
   have a specific reason not to.

2. **Flight-size blocking looks like a hang.** Under RPP or slow Store
   ACKs, `lbm_src_send()` blocks when the flight-size limit is hit. Check
   `ume_flight_size`, Store connectivity, and `stability-ack-minimum-number`
   before concluding there's a deadlock.

3. **Stability-ACK batch ≥ flight size → stop-and-go.** See §2 table.

4. **State lifetime shorter than expected downtime.** A returning receiver
   or source that has been offline longer than its state lifetime is treated
   as a new registration and silently skips its backlog. Size state-lifetime
   to the longest tolerable downtime, not to an arbitrary round number.

5. **QC Stores colocated.** See §3.

6. **`retransmission-request-forwarding` + "mark stored message invalid".**
   Explicitly incompatible. See §3.

7. **`restore-last` first-start slow.** See §3.

8. **Store doesn't create directories.** See §3.

9. **Doubled request maximums for UMP receivers.** See §2 table (Store
   registration hangs row). `ume_sri_request_maximum` and
   `transport_topic_sequence_number_info_request_maximum` ship at 60;
   double them.

---

## 5. SPP / RPP Sizing Formulas

From `store_config.md` §10. Use these as floors, then round up to tolerate
bursts.

### SPP (Source-Paced Persistence)

```
ume_flight_size               = 3 × (ume_ack_batching_interval / 1000) × avg_msg_rate
ume_flight_size_bytes         = ume_flight_size × avg_msg_size
ume_repository_size_threshold = ume_flight_size_bytes
ume_repository_size_limit     = 1.2 × ume_repository_size_threshold
```

If `stability-ack-minimum-number > 1` (batched ACKs):

```
ume_flight_size = 3 × ((ume_ack_batching_interval + stability-ack-interval) / 1000)
                  × avg_msg_rate
```

then recompute the others.

### RPP (Receiver-Paced Persistence)

Choose `repository-disk-write-delay` long enough for normal consumers to
ACK within the window (`ume_ack_batching_interval` default 100 ms means a
consumer can hold an ACK for up to 100 ms). Typical values: 1000–5000 ms.

```
ume_flight_size               = 3 × (ume_ack_batching_interval / 1000) × avg_msg_rate
ume_flight_size_bytes         = ume_flight_size × avg_msg_size
ume_repository_size_threshold = (avg_msg_size × avg_msg_rate
                                 × (repository-disk-write-delay / 1000))
                                 + ume_flight_size_bytes
ume_repository_size_limit     = 1.2 × ume_repository_size_threshold
```

Same `stability-ack-minimum-number > 1` adjustment applies.

---

## 6. Recipe Configurations

From `config_details.md` §13. Starting points, not gospel.

### Lowest latency

```
source  implicit_batching_minimum_length   1
context mim_implicit_batching_minimum_length  1
receiver ordered_delivery  0    # if arrival-order is acceptable
context response_tcp_nodelay  1
transport_lbtrm_nak_backoff_interval  10   # ms; small LANs only
```

### Highest throughput

```
source implicit_batching_minimum_length  8192
```

### Multicast sources by default

```
source transport LBT-RM
source transport_lbtrm_data_rate_limit       <modest value>
source transport_lbtrm_retransmit_rate_limit <modest value>
```

Start small on rate limits and raise after testing.

---

## 7. Additional Library Options Worth Knowing

These don't fit neatly into the interrelated-pairs table but come up
frequently in production tuning.

### Request / response

- **`response_tcp_nodelay` (context)** — default `0`. Set to `1` for
  any workload that uses `lbm_send_request` / `lbm_send_response`
  (including this architecture's TA ↔ Acceptor hop). Default off is
  bad for req/resp latency; Nagle's algorithm batches the response ACK.

- **`response_tcp_deletion_timeout` (context)** — default 20,000 ms
  (20 s). The response TCP session is torn down after this idle period.
  If req/resp is used for more than one-shot initialization, or if
  persistence is involved (stability ACK → respond cycle can take many
  seconds), extend this substantially (e.g., 300,000 ms or longer).
  Undersize it and "connection reset" errors appear mid-session.

### File descriptor management

- **`fd_management_type` (context)** — set to `"epoll"` on Linux,
  `"wincompport"` on Windows. The default is OS-specific but is
  generally an improvement opportunity on both platforms.

- **`file_descriptor_management_behavior` (context)** — `"pend"`
  (default) or `"busy_wait"`. `"busy_wait"` reduces latency at the
  cost of a dedicated CPU core. Only effective with the kernel driver;
  Solarflare/OpenOnload has its own busy-wait mechanism.

### Delivery and backpressure

- **`delivery_control_maximum_burst_loss` (receiver)** — default is
  low. For UMP deployments (where the Store handles recovery) set to
  a very large value (10⁸–10⁹). At 1 M msgs/sec a one-second network
  outage drops 1 M messages; if this threshold is too low, UM declares
  unrecoverable loss on traffic the Store could otherwise recover.

- **`ume_application_outstanding_maximum` (source)** — disabled by
  default. Enabling it turns on "throttled delivery": the Store will
  not deliver more than N messages to the application at once, acting
  as back-pressure when the app is slow. Useful when the consuming
  application has bounded processing capacity. Size to the application's
  comfortable in-memory queue depth; too small causes unnecessary
  delivery stalls.

### Topic resolution

- **`resolver_send_final_advertisements` (source)** — strongly
  recommended when Store proxy sources are in use. Also helps when
  receivers start after sources have gone idle (prevents "EOS without
  BOS"), and bounds TR cache growth when many short-lived sources are
  created and destroyed. Produces a burst of traffic when many sources
  are deleted simultaneously — acceptable for most deployments.

- **`resolver_service_interest_mode` (context)** — if using
  `resolver_source_notification_function` with TCP TR (SRS), set to
  `"flood"`. Without it, SRS interest-mode filtering can prevent
  notifications from reaching the callback.

### MIM

- **Do not use MIM** unless specifically required. MIM was disabled by
  default as of UM 6.8. If you do enable it, wire up
  `mim_unrecoverable_loss_function` (context) — without it, MIM
  unrecoverable loss events are silently discarded.

### LBT-RM retransmit rate limiter

- **`transport_lbtrm_retransmit_rate_limit` (context)** — default 5
  Mbps. Don't evaluate it as a percentage of line rate; compare it to
  the actual average data rate during peak periods. At high data rates
  a 1-second network outage can produce a retransmission burst that far
  exceeds 5 Mbps, slowing recovery to the point where the NAK
  generation interval expires and messages become unrecoverable.

### SmartSource

- **`smart_src_user_buffer_count` (source)** — default 32. Most
  applications don't need more than 1. Oversizing wastes memory,
  especially when the number of sources is large.

- **`smart_src_max_message_length` (source)** — default can change
  between UM versions. Always set explicitly to your actual maximum
  message size rather than relying on the default.

---

## 8. Java / .NET: Zero Object Delivery (ZOD) and Recycling

ZOD and the object recycler are the two mechanisms for eliminating
garbage collection pressure in Java/.NET UM applications. They are
related but distinct.

### ZOD (Zero Object Delivery)

ZOD is not a configuration option — it is an internal optimization
that activates automatically when the application follows the rules.
The rule: **call `msg.dispose()` (Java) / `msg.Dispose()` (.NET) at
the end of every receive callback** for messages you are not retaining.
When `dispose()` is called before the callback returns, UM can reuse
the message object on the next delivery instead of allocating a new
one. No configuration is required.

For Java: prefer `msg.dataBuffer()` + `msg.dataLength()` (returns a
`ByteBuffer` backed directly by UM's internal buffer) over `msg.data()`
(which copies the payload into a new `byte[]`). `dataBuffer()` is the
ZOD-friendly form — no copy, no allocation. Only use `data()` when you
genuinely need a standalone `byte[]`.

For .NET: use `msg.dataPointer()` and `msg.length()` for the same
zero-copy access.

**If you cannot process the message fully inside the callback:** call
`msg.promote()` (Java) / promote equivalent (.NET) before the callback
returns, and call `dispose()` later when processing is done. Note:
`promote()` prevents ZOD for that message — a new object is allocated.
To reclaim it efficiently, use a recycler (below).

### Object Recycler (Java)

The `LBMObjectRecycler` pre-pools message objects so that promoted
messages that are later `dispose()`d can be reused rather than
garbage-collected.

```java
LBMObjectRecycler objRec = new LBMObjectRecycler();

LBMContextAttributes ctxAttr = new LBMContextAttributes();
ctxAttr.setObjectRecycler(objRec, null);

LBMReceiverAttributes rcvAttr = new LBMReceiverAttributes();
rcvAttr.setObjectRecycler(objRec, null);

// ... in receive callback, when deferring processing:
LBMMessage retained = msg.promote();
myQueue.add(retained);
return 0;

// ... elsewhere, when done with message:
retained.dispose();
objRec.doneWithMessage(retained);

// ... at shutdown, after closing all receivers and contexts:
objRec.close();
```

Key points:
- `doneWithMessage(msg)` is what actually returns the object to the
  pool. `dispose()` alone does not; it marks the message free for UM,
  but the Java object is not pooled until `doneWithMessage` is called.
- A single recycler instance can be shared across multiple contexts
  (the implementation uses thread-local storage internally, so it is
  thread-safe without external locking).
- **`sourceEvent.dispose()`** should always be called at the end of
  source event callbacks, for the same reason as message disposal. In
  practice there are few use cases for promoting a source event for
  deferred processing, but the dispose call is always correct.

---

## 9. Persistence: Additional Notes

### Activity timeout staggering (Store ↔ source ↔ proxy)

Three timers interact; they should be staggered so that each layer
times out *after* the layer upstream of it has had a chance to react:

1. **Store `source-activity-timeout`** — shortest. The Store releases
   the RegID first if the source goes quiet.
2. **Source `ume_store_activity_timeout`** — a few seconds longer than
   the Store's value. The source gives the Store time to react before
   declaring the Store lost.
3. **Proxy source election (`proxy-election-interval`)** — at least
   3× the Store's activity timeout. The proxy should not elect itself
   while there is still a chance the real source will return.

"A few seconds of separation" (1–2 s) is sufficient between tiers 1
and 2. Tier 3 needs substantially more headroom because a premature
proxy election can advertise stale data.

### Forced reclaims

When a source's retention buffer (or the Store, under SPP) needs to
reclaim a message before any receiver has consumed it, there are two
ways to be notified:

1. **`LBM_SRC_EVENT_UME_MESSAGE_RECLAIMED_EX` source event** — fires
   with flags indicating whether it was a forced reclaim, the sequence
   number, the Store name, and `clientd`. Applies to UMP (persistent)
   sources only.

2. **`ume_force_reclaim_function` (source)** callback — delivers topic,
   sequence number, and `clientd`. Applies to both UMS (streaming with
   retention) and UMP. Required for streaming sources if you need to
   act on forced reclaims; for UMP either mechanism works.

### RPP multi-second stability ACK delay

There is a known interaction between several RPP configuration options
(`ume_flight_size_bytes`, `repository-size-threshold`,
`repository-size-limit`, `stability-ack-interval`,
`stability-ack-minimum-number`) that can produce multi-second delays
in receiving stability ACKs even at moderate message rates. If you
observe sources stalling unexpectedly under RPP, audit all five of
these values as a group using the sizing formulas in §5 before tuning
any single option in isolation.

### XSP and latency outliers

XSP (Transport Service Providers) distributes receive-side work across
additional threads, eliminating head-of-line blocking that produces
long-tail latency outliers. The tradeoff is complexity: XSP adds
threads, requires its own configuration, and is harder to debug. Only
reach for XSP after profiling shows that receive-side serialization is
the actual source of outliers.

---

## 10. Monitoring

- **Use a separate TRD for monitoring data.** Monitoring traffic shares
  transport and TR resources with application data by default; a
  dedicated monitoring TRD prevents monitoring congestion from masking
  or worsening application-layer problems.

- **Use TCP transport for monitoring data,** and consider unicast TR.
  Monitoring consumers are typically few and known; TCP unicast gives
  reliable delivery without depending on multicast infrastructure.

- **Send monitoring data on a different NIC than application data.**
  A saturated application NIC should not take down visibility.

- **At least one MCS (or equivalent monitoring collector/server) per
  data center.** Do not send monitoring data across a WAN — WAN
  instability is often what you are trying to detect; routing
  monitoring over the same path creates a blind spot at exactly the
  wrong moment.

---

## 11. Operations Readiness

Tools to install on every production host or container before going live:

- **Standard network tools:** `ethtool`, `tcpdump`, `netstat` (or `ss`),
  `ifconfig` (or `ip`), `ping`, `traceroute`, `lsof`. These are standard
  on most Linux installs but frequently stripped from containers.
- **If using Solarflare/OpenOnload:** `onload_stackdump`, `onload_tcpdump`.
- **`gstack`** (requires `gdb`) for live thread backtraces.
- **`mtools`** (`msend`, `mdump`) for UM-level send/receive testing.
- **UM example apps** (or Support-hardened equivalents) for on-device
  smoke testing.

Enable core files on production hosts and know where they are written.
A process that exits unexpectedly but leaves no core provides almost no
diagnostic signal.

---

## ⚠ Conflicting Advice — Read Before Acting

Two items in circulating UM best-practices documents give opposite
guidance. The resolutions below reflect the current settled position
in this skill.

### `delivery_control_loss_check_interval`

- **This skill (§2 table):** "Always enable for UMP receivers."
  Source: `config_details.md` §11, which cites a specific failure mode
  where tail loss goes both unreported and silently drops the next
  buffered message.
- **Alternate view (from internal best-practices notes):** "Discouraged;
  only useful for short-lived sources." Rationale given: per-receiver
  scan cost is non-trivial at high receiver counts.

**Resolution:** Enable it for UMP receivers unless the deployment has
a very large number of receivers (tens of thousands) and profiling
shows the scan cost is significant. For this architecture's receiver
counts, enable it.

