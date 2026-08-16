# DRO Configuration Reference

This document summarizes every configuration element (option) available in
the Ultra Messaging Dynamic Routing Option (DRO) XML configuration file,
extracted from `index.m4` in this directory. It is organized by the XML
element hierarchy for use as input to a future DRO-configuration skill.

Each DRO is configured by its own XML file. At a minimum, the file
contains a `<tnw-gateway>` root element, which holds a `<daemon>` section
(DRO-wide options) and a `<portals>` section (one `<endpoint>` or `<peer>`
child per portal). Endpoint portals connect to a TRD; peer portals connect
to a peer portal on another DRO.

---

## 1. Top-Level Structure

### `<tnw-gateway>`
Root element. Container for all options in the XML DRO configuration file.

**Attributes**
- `version` — DTD version. Currently `"1.0"`. **Required, no default.**

```xml
<tnw-gateway version="1.0">
  <daemon>...</daemon>
  <portals>...</portals>
</tnw-gateway>
```

### `<daemon>`
Container for options common to the entire DRO process. See Section 2.

### `<portals>`
Container for all `<endpoint>` and `<peer>` portal definitions. See
Sections 3–5.

---

## 2. `<daemon>` Elements (DRO-wide)

### `<name>`
Unique identifier for this DRO. Do not duplicate on any other DRO. Also used
for naming `<endpoint>` and `<peer>` portals (unique within the DRO). No
default.

### `<log>`
Destination for DRO log messages.
- Text content: full pathname (only when `type="file"`).
- `type` — `file`, `syslog`, or `console`. Default `console`.
- `size` — roll log after N million bytes (max 4000, 0 disables). File-type only. Default `0`.
- `frequency` — `daily`, `hourly`, `disable` (also internal `test`). File-type only. Default `disable`.

### `<uid>` / `<gid>`
User/group ID the daemon process drops to when started as root.

### `<pidfile>`
Pathname for the daemon PID file.

### `<lbm-license-file>`
Pathname for the UM license file.

### `<xml-config>`
Specifies the UM XML configuration file referenced by portals (enables
template-based per-portal UM option assignment). Precedence between
`<lbm-attributes>` and `<xml-config>` is scope-dependent: context-scope
`<lbm-attributes>` are overwritten by XML, but source/receiver-scope
`<lbm-attributes>` override XML. See `<lbm-attributes>` below for the
full explanation and source-code citations.

### `<web-monitor>`
Interface:port for the built-in web monitor (e.g., `*:21000`). Omit to
disable. See DRO Web Monitor docs for important security considerations.

### `<route-recalculation>`
Timing for route recalculations after a detected topology change.
- `backoff-interval` — ms to wait after the last detected change before
  recomputing routes. Default `5000`.
- `warning-interval` — ms before warning that recalculation is being held
  up by a non-converging topology. Default `10000`.

### `<route-info>`
Controls propagation and timeout of route information messages between
DROs.
- `propagation-interval` — ms between route-info messages sent to peers. Default `1000`.
- `check-interval` — ms between internal checks for sending route-info, timing out a DRO, or recomputing. Default `750`.
- `timeout` — ms with no route-info from a peer before declaring it out of service. Default `4000`.
- `max-hop-count` — maximum DRO hops a route-info message may traverse. Default `100`.

### `<topicmap>` / `<patternmap>`
Tuning of the internal topic resolution hash tables (topic names /
wildcard patterns respectively).
- `hash-function` — `classic`, `djb2`, `sdbm`, `murmur2`. Default `murmur2`.
- `size` — number of hash buckets; should be prime. Default `131111`.

### `<monitor>`
Container for UM Transport statistics monitoring (library-level stats).
- `interval` — seconds between stats publications; `0` disables. Default `0`.

#### `<monitor><transport-module>`
- `module` — `lbm`, `lbmsnmp`, or `udp`. Default `lbm`.
- `options` — key/value string passed to the transport module
  (`config=<file>`, `topic=<name>`; default topic `/29west/statistics`).

#### `<monitor><format-module>`
- `module` — `csv` or `pb` (Protocol Buffers). Default `csv`.
- `options` — format-module options string (`separator=<char>`; defaults to comma).

### `<daemon-monitor>` *(DEPRECATED — use UM automatic monitoring with `monitor_format=pb` instead)*
Legacy Daemon Statistics publisher.
- `topic` attribute — topic used for publishing. Default `tnwgd.monitor`.

#### `<daemon-monitor><lbm-config>`
UM config file for the monitor's internal context.

#### `<daemon-monitor><publishing-interval>`
Per-group publish rate. Child `<group name="X" ivl="N"/>` where name is:
  - `default` — applies to all groups not otherwise set.
  - `gateway-config` — `tnwg_dstat_gatewaycfg_msg_t`.
  - `route-manager-topology` — `tnwg_rm_stat_grp_msg_t`.
  - `malloc-info` — `tnwg_dstat_mallinfo_msg_t`.
  - `portal-config` — `tnwg_pcfg_stat_grp_msg_t`.
  - `portal-stats` — `tnwg_dstat_portalstats_msg_t`.
  - `ivl` — seconds between publications (required).

`<publishing-interval>` may also appear directly under `<endpoint>` /
`<peer>` to override intervals per-portal (still deprecated).

#### `<daemon-monitor><remote-snapshot-request>`
- `allow` — `0` (ignore) or `1` (respond). Default `0`. Enables on-demand
  snapshot requests.

#### `<daemon-monitor><remote-config-changes-request>`
- `allow` — `0` or `1`. Default `0`. Enables remote changes to publishing
  intervals via Daemon Control Requests.

### `<propagation-delay>` *(DEPRECATED AND ELIMINATED — do not use)*

---

## 3. Common `<portals>` Child Elements

These may appear in either `<endpoint>` or `<peer>`. (Some are
peer-only or endpoint-only; noted where relevant.)

### `<name>`
Portal name (must be unique within the DRO). No default.

### `<cost>`
Positive non-zero integer forwarding cost. Used by the DRO path-selection
algorithm; lower is preferred. Default `1`.

### `<lbm-config>`
Path to a UM configuration file (plain-text or XML) providing UM options
for the sources/receivers this portal will create. Configuration errors
are logged as warnings (as of UM 6.13) rather than fatal.

### `<lbm-attributes>`
Inline UM option overrides without an external file.

**Precedence depends on both the config file format AND the option
scope — a historical quirk with a scope-dependent twist:**

- **With `<lbm-config>` (flat-text format):** flat config is applied
  first, then `<lbm-attributes>`. The `<lbm-attributes>` values win
  for all scopes. This is the intuitive behavior.

- **With `<xml-config>` (XML format):** behavior differs by scope:

  | Scope | Who wins? | Why |
  | --- | --- | --- |
  | `context` | **XML wins** | DRO calls `lbm_context_attr_set_from_xml()` which uses the **fill** path — unconditionally overwrites regardless of `setopt_mask` |
  | `source` | **`<lbm-attributes>` wins** | XML is applied at `lbm_src_topic_alloc()` via the **check** path which respects `setopt_mask` — skips options already set |
  | `receiver` | **`<lbm-attributes>` wins** | XML is applied at `lbm_rcv_topic_lookup()` via the **check** path — same as source |
  | `wildcard_receiver` | **`<lbm-attributes>` wins** | Same mechanism as receiver |
  | `event_queue` | **`<lbm-attributes>` wins** | Same mechanism |

**Why the split:** The DRO explicitly calls `lbm_context_attr_set_from_xml()`
on the context attributes during portal initialization
(`tnwgendpoint.c` line ~945). This function uses the "fill" path
(`lbm_xmlcfg_fill_ctx_attr`) which has `usroptmask = NULL` and
therefore overwrites unconditionally — even options set via
`<lbm-attributes>`. For source/receiver, there is no equivalent
explicit `set_from_xml` call on the real attrs; instead, the XML is
applied later at object-creation time (`lbm_src_topic_alloc` /
`lbm_rcv_topic_lookup`) via `lbm_xmlcfg_check_src_topic` /
`lbm_xmlcfg_check_rcv_topic`, which use the "check" path with
`usroptmask = attr->setopt_mask`. The check path skips any option
whose `setopt_mask` bit is already set by `<lbm-attributes>`.

**Practical implications when using `<xml-config>`:**

- **Context-scope** `<lbm-attributes>` are effectively dead if the
  same option appears in the XML resolution chain. Use named contexts
  with `<source-context-name>` / `<receiver-context-name>` to apply
  per-portal context overrides within the XML hierarchy instead.
- **Source/receiver-scope** `<lbm-attributes>` DO work as overrides —
  they take precedence over anything in the XML config, including
  topic-specific options.

#### `<lbm-attributes><option>`
Each child sets one UM option.
- `scope` — `context`, `source`, `receiver`, `wildcard_receiver`, `event_queue`. **Required.**
- `name` — UM option name. **Required.**
- `value` — option value. **Required.**

### `<source-context-name>` / `<receiver-context-name>`
Names used to look up UM XML templates/contexts for the portal's proxy
source or proxy receiver respectively. Lets you target specific UM
templates per portal.

**Which endpoint's config gets consulted for a given proxy source?**
A DRO creates a proxy source in the TRD **facing the receiver** (not
the TRD facing the originating source). That endpoint — the one that
creates the proxy source — is the one whose `<lbm-config>` /
`<lbm-attributes>` / `<source-context-name>` and per-topic
`<sources>` config are consulted when building the proxy. The
opposite endpoint (facing the originating source) creates a proxy
**receiver**, so its receiver-side config applies there, but its
source-side config is irrelevant to the proxy source on the other
TRD.

Practical implication: when tuning a proxy source (per-topic options,
templates, transport tweaks), edit the endpoint whose TRD faces the
receiver. Duplicating the same source-side config on both endpoints
"to be safe" is harmless but misleading — only one side's config
does anything, and edits on the wrong side silently no-op.

### `<max-queue>`
Max bytes of buffered outbound data (blocking queue size). Default
`1000000`.

### `<uim-max-queue>`
Max bytes of buffered outbound UIM messages. Default `0` ⇒ use legacy
behavior of 10 % of `<max-queue>`.

### `<source-deletion-delay>`
Milliseconds to wait after a source is detected as deleted (via EOS or
route-map change) before deleting the proxy source. Default `1000`.

### `<acl>`
Access control list for the portal. Contains `<inbound>` and/or
`<outbound>` children. See Section 6.

### `<context-query>`
Timing for context-name queries generated at this portal.
*(Contact UM Support before changing.)*
- `interval` — ms between groups of context queries. Default `200`.
- `max-contexts` — max contexts queried per group. Default `20`.
- `periodic-interval` — ms between periodic context-query cycles. Default `300000`.
- `timeout` — seconds a query can go unanswered before removal. Default `900`.

### `<sqn-window>`
Duplicate-detection sliding window for topic-fragment sequence numbers.
*(Contact UM Support before changing.)*
- `size` — max sequence numbers tracked per source; must be multiple of 8. Default `16384`.
- `increment` — step (multiple of 8, divisor of size, < size) by which the window advances. Default `2048`.

### `<gateway-keepalive>` *(peer only)*
DRO-level keepalive between peer portals (not TCP-level).
- `idle` — `yes` (only when no traffic) or `no` (always). Default `yes`.
- `interval` — ms between keepalives; `0` disables. Default `5000`. Recommend ≥ 2000.
- `timeout` — ms with no traffic before declaring the peer dead. Default `15000`. Recommend 3× interval.

### Hotlink-related elements
See `drohotlinks` concept doc.

#### `<hotlink-index>`
Unique hotlink index for this DRO within a TRD (range 0–65535). `0` = do
not participate in hotlink. Default `0`.

#### `<route-group>`
Route-group number (0–65535) associated with this portal for hotlink
routing. May appear multiple times. Default `1`.

### Deprecated use-check / purge / interest-generate / domain-activity elements
**All of the following are deprecated and have no function.** Listed for
completeness only (accepted but ignored): `<topic-use-check>`,
`<pattern-use-check>`, `<topic-purge>`, `<pattern-purge>`,
`<topic-interest-generate>`, `<pattern-interest-generate>`,
`<topic-domain-activity>`, `<pattern-domain-activity>`.

---

## 4. `<endpoint>` Elements

An endpoint portal connects the DRO to a single TRD (topic resolution
domain) via UM sources/receivers configured in that TRD.

### `<domain-id>`
**Required, no default.** TRD identifier for this endpoint. Must be unique
within this DRO (one endpoint per TRD per DRO). All endpoints on different
DROs that interface the same TRD must share the same `<domain-id>`.

### `<topic-resolution>`
Container for endpoint topic-resolution behavior (see sub-elements below).

#### `<topic-resolution><initial-request>`
Initial TR request cadence when the endpoint starts up.
*(Contact UM Support before changing.)*
- `duration` — minimum duration (seconds?) for the initial burst. Default `10`.
- `periodic-interval` — ms between requests during the initial burst. Default `1000`.

#### `<topic-resolution><domain-route>`
Bounds on the periodic "domain route" messages the endpoint sends about
each remote domain it services.
- `min-interval` — ms. Default `100`.
- `max-interval` — ms. Default `1000`.

#### `<topic-resolution><remote-topic-interest>` / `<remote-pattern-interest>`
How often topic- or pattern-interest messages are sent for topics/patterns
the portal has interest in.
- `min-interval` — ms. Default `1000`.
- `max-interval` — ms. Default `60000`.

#### `<topic-resolution><topic-use-query>` / `<pattern-use-query>`
Periodic "are any receivers still interested?" queries per topic / pattern.
*(Contact UM Support before changing.)*
- `max` — retries before giving up and removing the topic/pattern. Default `5`.
- `periodic-interval` — ms between periodic queries. Default `300000`.
- `timeout` — ms to wait for a response. Default `3000`.

#### `<topic-resolution>...<rate-limit>` *(nested in each TR element above)*
Rate-limits messages for the enclosing TR type.
- `bps` — bits/second; `0` disables. Defaults: 500000 for use-queries and interest messages; 0 for domain-route.
- `objects-per-second` — objects/second; `0` disables. Defaults: 500 for use-queries; 0 for interest; 50 for domain-route.

### `<remote-topic>` / `<remote-pattern>`
Timing for checking continued interest in topics / patterns at this portal.
*(Contact UM Support before changing.)*
- `check-interval` — ms between individual continuation checks. Default `90000`.
- `max-topics` / `max-patterns` — max checked per pass. Default `100`.
- `timeout` — ms without refresh before interest is removed. Default `300000`.

### `<late-join>` *(DEPRECATED AND ELIMINATED — do not use)*

---

## 5. `<peer>` Elements

A peer portal connects this DRO to a peer portal on another DRO. Always
uses a TCP control link (`<single-tcp>`); optionally adds a UDP data link
(`<udp>`) for lower latency.

### `<sourcemap>`
Size of the peer portal's internal source map.
- `size` — must be a power of 2. Default `131072`. Raise only for extremely
  high topic counts.

### `<max-datagram>`
Maximum batched datagram size (bytes) allowed on this peer. Does NOT cap
the datagram size for messages larger than the limit — only the batcher.
Max and default `65500`. *(Contact UM Support before changing.)*

### `<batching>` *(peer implicit batching)*
Controls peer-link batching of data messages. Control messages flush any
pending batch.

#### `<batching><min-length>`
Batch flushes when buffered bytes reach this. Default `8192`.

#### `<batching><batch-interval>`
Max ms between queueing the first message of a batch and sending it. Min
3, default `200`.

### `<smart-batch>`
Enable (`1`) / disable (`0`) smart-batch flushing. Default `0`. Works with
both endpoint and peer portals but peer-side uses `<batching><min-length>`
while endpoints use the UM option `implicit_batching_minimum_length`. When
enabled, very large batch thresholds can be used safely.

### `<multiple-receive-max-datagrams>` *(peer `<udp>` only)*
Enables the "receive multiple datagrams" optimization on the UDP peer
link; value = max datagrams per read. `0` disables. Informatica recommends
10–100 for high-throughput.

### `<single-tcp>` *(required on every peer)*
Container for the TCP portion of the peer link. (Note: "single-tcp" is a
legacy name; dual-TCP `<tcp>` was removed in UM 6.10.)

#### `<single-tcp><interface>`
Dotted-decimal or CIDR address for the TCP peer link's local interface.

#### `<single-tcp><send-buffer>` / `<receive-buffer>`
Socket buffer sizes in bytes.
- Under `<single-tcp>`: default `0` (OS TCP autotuning).
- Under `<udp>`: send default `1048576`, receive default `8388608`.

#### `<single-tcp><keepalive>`
Presence enables the TCP SO_KEEPALIVE signal. Off by default.

#### `<single-tcp><nodelay>`
Presence enables TCP_NODELAY (disables Nagle — lower latency, lower
throughput efficiency). Off by default.

#### `<single-tcp><compression>`
Peer-link compression algorithm. Only value supported: `LZ4`. Omit for no
compression.

#### `<single-tcp><tls>`
Container enabling TCP peer-link encryption. Contains:
- `<certificate>` — path to PEM server cert.
- `<certificate-key>` — path to PEM private key for the above cert.
- `<certificate-key-password>` — passphrase for the encrypted private key.
- `<trusted-certificates>` — path to a PEM file of trusted client CAs/certs.
- `<cipher-suites>` — comma-separated OpenSSL cipher suite names in descending preference. Default is the secure system default.

#### `<single-tcp><initiator>`
Present on the initiating side. The peer portal actively connects to its
companion's `<acceptor>`.
- `<address>` — IP of the remote acceptor.
- `<port>` — TCP port of the remote acceptor (matches remote `<listen-port>`).
- `reconnect-interval` attribute (on `<initiator>`) — ms to wait before reconnecting after disconnect. Default `5000`.

#### `<single-tcp><acceptor>`
Present on the accepting side. Listens for connections from the peer's
initiator.
- `<listen-port>` — TCP port to listen on (must match the remote initiator's `<port>`).

### `<udp>` *(optional — adds UDP data link to the peer)*
Adds a UDP-based (LBT-RU-like) data link to the peer. TCP peer link
(`<single-tcp>`) is still required for control messages. Port is set via
`<port>` and is independent of the TCP port.

#### `<udp><port>`
UDP port used for both incoming and outgoing data on this peer. Required.

#### `<udp><coalesce-threshold>`
Coalescing threshold analogous to `transport_lbtru_coalesce_threshold_source`. Default `15`.

#### `<udp><transmission-window>`
Retransmit buffer sizing for the UDP peer link.
- `size` — bytes of user data retained (excluding overhead). Default `25165824`.
- `limit` — hard memory cap including overhead (`0` = no extra cap). Default `0`.

#### `<udp><peer-rate-limit>`
UDP peer-link rate limiter (independent per peer portal).
- `data` — max data bits/second incl. overhead. Default `10000000`.
- `retransmit` — max retransmit bits/second. Default `5000000`.
- `interval` — rate-limiter period in ms. Default `100`.

#### `<udp><nak-handling>`
NAK-based loss recovery controls on the UDP peer link.
- `initial-backoff-interval` — ms from loss detection to first NAK. Default `0`.
- `backoff-interval` — ms between subsequent NAKs. Default `200`.
- `suppress-interval` — ms to suppress NAKs after receiving an NCF. Default `1000`.
- `generation-interval` — ms until a lost datagram is declared unrecoverable. Default `10000`.
- `ignore-interval` — ms a sender ignores additional NAKs after a retransmit. Default `100`.
- `send-naks` — `yes` or `no`. Default `yes`. `no` disables loss recovery.

#### `<udp><session-message>`
Session (keepalive) messages for the UDP peer link.
- `min-interval` — ms. Default `200`.
- `max-interval` — ms. Default `10000`.
- `activity-timeout` — ms with no traffic before declaring the link dead. Default `60000`.

#### `<udp><connect>`
UDP peer-link connection-establishment algorithm.
- `attempt-interval` — ms between connect attempts. Default `200`.
- `max-attempts` — retries before giving up and fully re-initializing (which restarts both TCP and UDP). Default `10`.

### `<tcp>` / `<companion>` *(DEPRECATED AND ELIMINATED as of UM 6.10 — use `<single-tcp>` instead.)*

---

## 6. Access Control Lists (`<acl>`)

An ACL is attached to a portal (`<endpoint>` or `<peer>`). It filters
messages by topic name, transport attributes, or source IP. ACEs in an
ACL are evaluated in order; each is either `accept` or `reject`.

### `<acl>`
Container. Children: `<inbound>` and/or `<outbound>` (each holds `<ace>`s).

### `<inbound>` / `<outbound>`
Separate lists for messages coming in (from the attached TRD / peer) vs.
going out. Most match conditions can be used in `<inbound>`; only
`<topic>` and `<pcre-pattern>` (and the deprecated `<regex-pattern>`) may
be used in `<outbound>`.

### `<ace>` (Access Control Entry)
A single matching rule.
- `match` — `accept` or `reject`. **Required.**
- Children — one or more conditional elements (below). All conditions must
  match for the ACE to match.

### ACE Conditional Elements

The note below applies to **all** conditional elements: when the source is
in a remote TRD, the condition matches the DRO-local proxy source's
characteristic, not the originating source.

#### `<topic>` *(inbound or outbound)*
Matches exact topic name. Supports `xml:space="preserve"` to retain
surrounding whitespace for unusual topic names.

#### `<pcre-pattern>` *(inbound or outbound)*
Matches topic against a Perl-Compatible Regular Expression. Supports
`xml:space="preserve"` (required if the pattern contains spaces).

#### `<regex-pattern>` *(DEPRECATED — use `<pcre-pattern>`)*
POSIX regex topic match.

The remaining conditionals apply only to `<inbound>` ACLs. Each uses the
same structure: a `comparison` attribute and a `value` attribute.
Comparison tokens (synonyms listed together):

| Token | Synonym | Meaning |
|-------|---------|---------|
| `eq` | `equal` | equal |
| `ne` | `notequal` | not equal |
| `lt` | `lessthan` | less than |
| `le` | `lessthanequal` | ≤ |
| `gt` | `greaterthan` | greater than |
| `ge` | `greaterthanequal` | ≥ |

`comparison` and `value` are required on each conditional (no defaults).

#### `<transport>`
Matches the transport type. Only `eq`/`ne` comparisons accepted.
- `value` — `tcp`, `lbt-rm` (or `lbtrm`), `lbt-ru` (or `lbtru`), `lbt-ipc` (or `lbtipc`).

#### `<source-ip>`
Matches source IP of the transport (TCP, LBT-RM, LBT-RU only).

#### `<multicast-group>`
Matches multicast group address (LBT-RM only).

#### `<udp-destination-port>`
Matches UDP destination port (LBT-RM only).

#### `<udp-source-port>`
Matches UDP source port (LBT-RM and LBT-RU).

#### `<tcp-source-port>`
Matches TCP source port (TCP transport only).

#### `<xport-id>`
Matches LBT-IPC transport ID (LBT-IPC only).

---

## 7. Whitespace Handling (`xml:space`)

Any text-content element that might legitimately contain leading/trailing
whitespace supports the standard `xml:space` attribute:
- `default` — trim whitespace (this is the element's default).
- `preserve` — retain exact whitespace.

Applies to: `<name>`, `<lbm-config>`, `<xml-config>`, `<web-monitor>`,
`<lbm-license-file>`, `<pidfile>`, `<log>`, `<source-context-name>`,
`<receiver-context-name>`, `<topic>`, `<pcre-pattern>`, `<regex-pattern>`.

---

## 8. File-Sharing: XInclude

DRO XML files support XInclude to factor common content (e.g., reusable
ACLs) into shared files:

```xml
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="FILEPATH"/>
```

`FILEPATH` may be a local path, `http://`, or `ftp://` URL. Secure
variants (`https:`, `sftp:`) are **not** supported. The included file must
have a single root element wrapping its contents.

---

## 9. Element-Ordering Note

The order of child elements under `<daemon>`, `<endpoint>`, `<peer>`, and
some containers is significant. Use the file-structure example at the top
of the XML configuration reference in `index.m4` (around line 4064) as
the authoritative ordering template when generating configurations.
