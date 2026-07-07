# Store Configuration Reference

This document summarizes every configuration element and option available
in the Ultra Messaging Persistent Store (`umestored` / `umestoreds`) XML
configuration file, extracted from `UME/index.m4`. It is organized by XML
element hierarchy for use as input to a future Store-configuration skill.

A Store Process is started from a Store configuration file. A single
process can host one or more Store instances; each Store instance has its
own `<store>` entry and persists messages for one or more topic patterns
(each in a `<topic>` entry). Store configuration options live either in
the `<store>`-level `<ume-attributes>` (apply to all repositories in that
Store) or the `<topic>`-level `<ume-attributes>` (apply to repositories
for sources matching that topic pattern).

---

## 1. Top-Level Structure

### `<ume-store>`
Root element. Contains everything else.

**Attributes**
- `version` — DTD version. **Required, no default.** DTD versions:
  | Version | Released | Adds |
  |--------:|---------:|------|
  | 1.0 | Feb 2007 (UME 1.0) | Persistent Stores |
  | 1.1 | Apr 2010 (UME 3.0.1 / UMQ 1.0) | Queues / ULB |
  | 1.2 | Mar 2011 (UME 3.2 / UMQ 2.1) | DLQ, Indexed Queuing / Indexed ULB |
  | 1.3 | Nov 2016 (UM 6.10) | `<xml-config>` child under `<daemon>` |
  Newer Stores can read older-DTD files; to use a newer-DTD feature, update
  the `version` attribute.

### `<daemon>`
Container for options applying to the entire Store Process. See Section 2.

### `<stores>`
Container for one or more `<store>` instances. See Section 3.
Multiple Store instances may run in one process for operational
simplicity, or each may run in its own process for failure isolation.
**Do not** run multiple Stores of a single Quorum/Consensus (QC) group in
the same process or on the same host — that defeats QC redundancy.

---

## 2. `<daemon>` Elements (Store-Process-wide)

### `<log>`
Text content: pathname of log file (used only when `type="file"`); omit
text to send to stdout.
- `type` — `file` or `console`. Default `console`.
- `frequency` — `daily`, `hourly`, `disable` (internal `test` exists but
  is reserved for Informatica). Default `disable`. File-type only.
- `size` — MiB at which the log is rolled (1 = 2**20 bytes); `0` disables
  size-based rolling. Default `10`.

### `<pidfile>`
Pathname of the PID file written at start-up.

### `<uid>` / `<gid>`
User/group ID the daemon drops to when started as root.

### `<lbm-license-file>`
Pathname of the UM license file. Retained for backwards compatibility;
starting with UM 6.8 a license key is no longer required for Store
operation.

### `<lbm-config>`
Pathname of a **flat-text** LBM (UM library) configuration file used when
the Store creates its context, sources, and receivers. Can also appear
under `<daemon-monitor>` to configure the monitor's internal UM objects.
Errors in the file are logged as warnings (as of UM 6.13) and the Store
continues running.

### `<xml-config>`
Pathname of an **XML-format** LBM configuration file used when the Store
creates UM objects. Added in DTD 1.3 (UM 6.10).
- `application-name` — UM XML "application name" selector for templates.
  Default `umestored`.

### `<web-monitor>`
`Address:Port` for the Store's built-in web monitor (e.g., `*:15304`, or
an explicit interface IP). Omit to disable. See the Store Web Monitor docs
for security notes.

### `<daemon-monitor>` *(DEPRECATED — migrate to UM automatic monitoring via `monitor_format=pb`)*
Legacy Daemon Statistics publisher.
- `topic` attribute — topic for publishing daemon stats. Default `umestore.monitor`.

#### `<daemon-monitor><lbm-config>`
LBM config for the monitor's internal UM objects (see above).

#### `<daemon-monitor><publishing-interval>`
Per-stats-group publish cadence. Repeat `<group>` children as needed. A
`<publishing-interval>` may also appear directly inside `<store>` to
override cadence per-Store (still deprecated).

##### `<publishing-interval><group>`
- `name` — **Required.** One of:
  - `default` — applies to groups not otherwise set.
  - `store` — `umestore_store_dmon_stat_msg_t`.
  - `source` — `umestore_repo_dmon_stat_msg_t` (per-source repository stats).
  - `receiver` — `umestore_rcv_dmon_stat_msg_t`.
  - `disk` — `umestore_disk_dmon_stat_msg_t`.
  - `config` — `umestore_*_dmon_config_msg_t`.
  - `memory` — `umestore_smart_heap_dmon_stat_msg_t`.
- `ivl` — seconds between publications. **Required.**

#### `<daemon-monitor><remote-snapshot-request>`
- `allow` — `0` (ignore) or `1` (respond to on-demand snapshot requests).
  Default `0`.

#### `<daemon-monitor><remote-config-changes-request>`
- `allow` — `0` (ignore) or `1` (allow remote changes to daemon-stats
  publishing intervals). Default `0`. **Warning:** if enabled, follow the
  guidance in "Securing Daemon Control Requests".

---

## 3. `<stores>` → `<store>` Element

Each `<store>` defines one Store instance.

### Attributes
- `name` — **Required.** Identifies log messages, web-monitor entries,
  and daemon-stats records. Not the same as the `context-name` option used
  by sources.
- `interface` — IP (or CIDR) address to listen on for incoming Store
  connections. Default `0.0.0.0` (INADDR_ANY). See Identifying Persistent
  Stores for usage.
- `port` — **Required.** TCP port to listen on. `0` (as of UM 6.8) means
  pick any free port in `[request_tcp_port_low, request_tcp_port_high]`;
  that typically requires named Stores (see `context-name` option).

### `<ume-attributes>` (Store-level)
Contains `<option>` children with `type="store"` or `type="lbm-context"`.
Store-level options apply to all repositories in this Store. See
Section 5 for the full Store-option list.

### `<restore-last>`
Limit how much cached data is restored when a disk-based Store is
restarted, to avoid long restore times for very large cache files. If
supplied at both `<store>` and `<topic>`, the `<topic>` setting wins.
- `value` — amount to restore. Range 0–336 when behavior is `hours`. `0`
  disables the feature (restore everything). Default `0`.
- `behavior` — `hours` or `none`. Default `hours`. When `hours`, the most
  recent N hours of messages are restored, measured **relative to the
  last message in the cache**, not to wall-clock time. `none` disables.

### `<publishing-interval>` *(deprecated — Store-level override for daemon-monitor cadence.)*

### `<topics>`
Container for one or more `<topic>` entries (Section 4).

---

## 4. `<store>` → `<topics>` → `<topic>` Element

### Attributes
- `pattern` — **Required.** Topic name (for exact match) or regex (for
  pattern match).
- `type` — how to interpret `pattern`:
  - `direct` — exact topic-name match. **Default.**
  - `PCRE` (alias `pcre`) — Perl-Compatible Regular Expression.
  - `regexp` — POSIX regex. **Deprecated; do not use.**

### `<topic>` → `<ume-attributes>`
Contains `<option>` children with `type="store"`, `type="lbm-receiver"`,
or `type="lbm-source"`. See Section 5 for the Store-option list. The
`lbm-receiver` / `lbm-source` option types are used to override UM library
settings for the Store's internal receivers / proxy sources on this
topic.

### `<restore-last>`
Per-topic override of the `<store>`-level `<restore-last>` (same
attributes).

---

## 5. `<option>` Element

The primary mechanism for setting Store configuration options. Always
appears inside a `<ume-attributes>` block.

### Attributes
- `type` — **Required.** Valid values depend on ancestor:
  | Ancestor | Allowed `type` |
  |----------|----------------|
  | `<store>` | `store`, `lbm-context` |
  | `<topic>` | `store`, `lbm-receiver`, `lbm-source` |
  - `store` — Store-specific option (listed below).
  - `lbm-context` — UM library context option.
  - `lbm-receiver` — UM library receiver option.
  - `lbm-source` — UM library source option.
- `name` — **Required.** Option name.
- `value` — **Required.** Option value.

UM library options (types `lbm-*`) are documented in the UM Configuration
Guide. The Store typically loads most UM options from a flat or XML LBM
config file and uses `<option type="lbm-*">` only to override per-Store or
per-topic settings. When specifying interface options, see "Interface
Device Names and XML" for the escaping rules.

---

## 6. Store-Level Store Options (`<store>` → `<ume-attributes>` → `<option type="store" ...>`)

### `disk-cache-directory`
Directory for disk-based repository message cache files. 1–230 chars.
User must create the directory; the Store will not. Default
`umestored-cache` (relative to the Store Process's CWD).

### `disk-state-directory`
Directory for disk-based state files. 1–230 chars. User must create.
Default `umestored-state` (relative to CWD).

### `context-name`
Name other UM apps can use to refer to this Store (instead of
`address:port`). 1–128 chars; alphanumeric plus `-` and `_`. Must be unique
across the entire network. Enables DRO-friendly persistence. No default.

### `allow-proxy-source`
`1` permits this Store to become a proxy source if the registered source
terminates. Default `0` (disabled).

### `proxy-source-repo-quorum-required`
`1` tightens the proxy-source election algorithm to better match the
broader UM persistence design (see "Proxy Source Elections"). Default `0`.

### `retransmission-request-processing-rate`
Maximum retransmission requests per second, across all topics in this
Store. Excess requests are dropped. Default `262144`.

---

## 7. Topic-Level Store Options (`<topic>` → `<ume-attributes>` → `<option type="store" ...>`)

### `repository-type`
How messages are retained:
- `memory` — volatile RAM only. **Default.**
- `disk` — disk-backed, with a RAM cache on top.
- `reduced-fd` — **Deprecated, do not use.**
- `no-cache` — **Deprecated, do not use.**

### `repository-size-threshold`
Minimum bytes kept in the in-memory cache (disk Stores keep some recent
messages in RAM even after they hit disk for fast recovery). For SPP,
counts payload + headers + Store overhead; for RPP, only payload.
For RPP, the source's `ume_repository_size_threshold` may override this —
the Store value then caps the source value; sources requesting more are
rejected. Default `1024`.

### `repository-size-limit`
Maximum bytes in the in-memory cache. For `memory` Stores this caps the
entire repository; for `disk` Stores disk capacity is capped by
`repository-disk-file-size-limit`. UM persistence supports at most
2,147,483,647 messages per repository; don't size past that. For SPP,
counts payload + headers + Store overhead; for RPP, only payload. For
RPP, source's `ume_repository_size_limit` is capped by this value.
Default `50331648` (48 MiB).

### `repository-age-threshold`
Seconds a message stays in the repository (RAM cache, whether `memory` or
`disk`). Messages older than this become reclaimable. Rarely used — most
common on `memory`-only Stores. `0` disables age-based retention.
Default `0`.

### `repository-disk-max-async-cbs`
Identical to `repository-disk-max-read-async-cbs` (sets the same
underlying async-read limit). Default `10000`. Originally intended to set
both read and write limits, but the write limit was later fixed at 1.

### `repository-disk-max-write-async-cbs`
Max outstanding async write callbacks for a `disk` repo. **Deprecated;
if supplied, must be `1`.** Any other value is logged as an error and
ignored. Default `1`.

### `repository-disk-max-read-async-cbs`
Max outstanding async read callbacks for a `disk` repo. Too-low values
can severely slow receiver recovery. Default `10000`.

### `repository-disk-file-size-limit`
Max bytes of disk space used for retained messages (`disk` Stores only).
Min enforced at 196992. Same 2,147,483,647-message cap as above applies.
For RPP, source's `ume_repository_disk_file_size_limit` is capped by this
value. Default `104857600` (100 MiB).

### `repository-disk-file-preallocate`
`1` — pre-allocate cache files to their max size on creation (sparse file
on ext3/4 and NTFS). `0` — grow as needed. Pre-allocation reduces
fragmentation and guarantees enough disk space, at the cost of start-up
time when many sources register at once. Default `0`. (`disk` only.)

### `repository-disk-async-buffer-length`
Bytes per buffer used for async disk I/O. Min enforced at 65664.
Default `1024000`. (`disk` only.)

### `repository-disk-message-checksum`
`1` adds a checksum to each on-disk message for restart validation.
Default `0`. (`disk` only.)

### `source-activity-timeout`
ms from last activity of a registered source before its RegID is
released. During the timeout, new sources requesting that RegID get an
error. If proxy sources are enabled (`ume_proxy_source`), the Store
elects a proxy source instead of releasing the RegID. If neither proxy
sources nor `ume_state_lifetime` is configured, state and cache are also
deleted at this point. Can be overridden by `ume_activity_timeout` on the
source. **Should be ≥ 2× `keepalive-interval`.** Default `30000`.

### `source-state-lifetime`
ms from last source activity to deletion of source state and cache
(whether or not a proxy source was elected). Source-side
`ume_state_lifetime` may also set this; the Store uses whichever is
**shorter**. `0` disables. Default `0`.

### `receiver-activity-timeout`
ms from last receiver activity to release of its RegID. During the
timeout, new requests for that RegID get an error. Can be overridden by
`ume_activity_timeout` on the receiver. Default `30000`.

### `receiver-state-lifetime`
ms from last receiver activity to deletion of receiver state/cache.
Receiver-side `ume_state_lifetime` may also set this; Store uses
whichever is **shorter**. `0` disables. Default `0`.

### `source-check-interval`
ms between Store's internal checks for source/receiver activity.
Default `750`.

### `keepalive-interval`
ms between Store-generated keepalives to sources and receivers when no
other traffic is flowing. **`source-activity-timeout` should be ≥ 2× this
value.** Default `3000`.

### `receiver-new-registration-rollback`
Upper bound on the number of messages a re-registering persistent
receiver may recover via "late join". Range 1 to 2,147,483,647 (default
effectively disables the limit). **Leave at default for most use cases.**
Interferes with the persistence delivery guarantee: if the limit is
1,000 and the source has sent 4,000 more messages during the receiver's
absence, the receiver may recover only the latest 1,000. Interacts with
receiver UM options `retransmit_request_maximum` and
`ume_recovery_sequence_number_info_function`. Default `2147483647`.

### `proxy-election-interval`
ms window used when electing a proxy source. Each eligible Store waits a
randomized `[0.5× .. 1.5×]` of this interval before declaring itself the
proxy source, unless another has already been elected.
Default `60000` (60 s).

**Three-tier activity timeout staggering (proxy-source deployments):**
These three timers form an ordering constraint:

1. Store `source-activity-timeout` — shortest; triggers proxy-source
   election when a source goes silent.
2. Source `ume_store_activity_timeout` — slightly longer (a few seconds
   more than the Store's timeout); lets the Store detect the silence first
   before the source concludes the Store is gone.
3. Source `ume_proxy_source` / `proxy-election-interval` — at least 3×
   the Store's `source-activity-timeout`; election must complete before
   the original source gives up and tries to re-register.

Violating the ordering causes races: the source may declare the Store
dead and begin re-registration while the Store is still mid-election,
producing duplicate RegID conflicts or spurious unrecoverable-loss events.

### `stability-ack-interval`
ms upper bound on how long stability ACKs are batched before being sent
to a source. Only effective when `stability-ack-minimum-number > 1`.
Batching increases throughput (especially on memory Stores) at the cost
of a small delivery-stability-notification delay. Default `200`.

### `stability-ack-minimum-number`
Minimum fragment-stability ACKs to accumulate before sending to the
source. Default `1` (no batching). Increase to batch ACKs; for best
results **keep it less than the source's flight size**, otherwise ACKs
wait for `stability-ack-interval` and you get bursty stop-and-go sending.

### `repository-allow-receiver-paced-persistence`
`1` permits a source to request RPP (via `ume_receiver_paced_persistence`
on the source). The Store cannot force RPP; it only allows the source to
request it. Default `0` (Store allows only SPP).

### `repository-allow-ack-on-reception`
`1` permits a source to request "ack on reception" (via
`ume_repository_ack_on_reception`) — RPP-only; ignored on SPP Stores.
The Store cannot force it; it only permits the source to request it.
Default `0`.

### `repository-disk-write-delay`
ms delay after message receipt before the message is written to disk.
Intended for RPP — if all required receivers acknowledge consumption
within the delay, the message is deleted from the memory cache and never
hits disk. Source-side `ume_write_delay` can override per-source, but is
capped by this value (exceeding sources are rejected). `0` disables.
Default `0`. (`disk` only; RPP-specific.)

### `source-flight-size-bytes-maximum`
RPP-only cap on the source's `ume_flight_size_bytes`. Sources exceeding
this during registration are rejected. Default `4194304` (4 MiB).

### `retransmission-request-forwarding`
`1` — Store forwards retransmission requests to the source when the
Store itself lacks the data. `0` — Store services only what it has and
does not forward. **Do not enable when using the "mark stored message
invalid" feature.** Default `0`.

---

## 8. Whitespace Handling (`xml:space`)

Elements whose text content might legitimately contain leading/trailing
whitespace support the standard `xml:space` attribute:
- `default` — trim whitespace (default).
- `preserve` — retain exact whitespace.

Applies to: `<lbm-config>`, `<xml-config>`, `<web-monitor>`,
`<lbm-license-file>`, `<pidfile>`, `<log>`, `<uid>`, `<gid>`.

---

## 9. File-Sharing: XInclude

Store XML files support XInclude for factoring common option groups into
shared files:

```xml
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="FILEPATH"/>
```

`FILEPATH` may be a local path, `http://`, or `ftp://`. Secure schemes
(`https:`, `sftp:`) are **not** supported. Included files must wrap their
content in a single root element (e.g., `<ume-attributes>...</ume-attributes>`).

Typical use: factoring a repeated `<ume-attributes>` block (e.g., a set of
repository options) into a shared file and including it from every
`<topic>` that needs it.

---

## 10. Sizing Guidance Formulas

### SPP (Source-Paced Persistence)
Given:
- `avg_msg_size` — average application message size in bytes.
- `avg_msg_rate` — average send rate in datagrams/second.

Minimum recommended values:
```
ume_flight_size               = 3 * (ume_ack_batching_interval / 1000) * avg_msg_rate
ume_flight_size_bytes         = ume_flight_size * avg_msg_size
ume_repository_size_threshold = ume_flight_size_bytes
ume_repository_size_limit     = 1.2 * ume_repository_size_threshold
```
If `stability-ack-minimum-number > 1`, add `stability-ack-interval`:
```
ume_flight_size = 3 * ((ume_ack_batching_interval + stability-ack-interval) / 1000)
                  * avg_msg_rate
```
(then recompute the others). Source retention (late-join) buffer should
match `ume_flight_size_bytes`.

### RPP (Receiver-Paced Persistence)
Pick `repository-disk-write-delay` long enough for normal consumers to
ACK within the window (consumers may delay ACKs up to
`ume_ack_batching_interval`, default 100 ms). Typical values:
1000–5000 ms.
```
ume_flight_size               = 3 * (ume_ack_batching_interval / 1000) * avg_msg_rate
ume_flight_size_bytes         = ume_flight_size * avg_msg_size
ume_repository_size_threshold = (avg_msg_size * avg_msg_rate
                                 * (repository-disk-write-delay / 1000))
                                 + ume_flight_size_bytes
ume_repository_size_limit     = 1.2 * ume_repository_size_threshold
```
Same `stability-ack-minimum-number > 1` adjustment applies.

Because these are averages, size up (increase `avg_msg_size` or
`avg_msg_rate`) to tolerate bursts — otherwise bursts force unexpected
disk writes and can block sources on flight-size.

---

## 11. Element-Ordering Note

The order of child elements inside `<daemon>`, `<store>`, and `<topic>`
is significant. Use the Store configuration example (around line 6882 of
`UME/index.m4`) as the authoritative ordering template when generating
configurations:

```xml
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <log>...</log>
    <pidfile>...</pidfile>
    <web-monitor>...</web-monitor>
  </daemon>
  <stores>
    <store name="..." port="...">
      <ume-attributes>
        <option type="store" name="disk-cache-directory" value="cache"/>
        ...
      </ume-attributes>
      <topics>
        <topic pattern="test.*" type="PCRE">
          <ume-attributes>
            <option type="store" name="repository-type" value="disk"/>
            ...
          </ume-attributes>
        </topic>
      </topics>
    </store>
  </stores>
</ume-store>
```
