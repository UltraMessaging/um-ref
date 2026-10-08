# Monitoring — ApplicationSourceID and automatic vs explicit monitoring

## ApplicationSourceID

The NAME field in lbmmon output (`"... received from NAME at IP, process ID=..."`)
is the `ApplicationSourceID` parameter. It is set per-object when registering
contexts, sources, receivers, or event queues via the `lbmmon_*_monitor()` API.

If NULL or empty, defaults to the OS process name (basename of executable on
Linux, from `/proc/self/cmdline`).

Source: `src/mon/lbmmonctl.c`, `populate_common_pkt_attr()` and the
`lbmmon_context_monitor()` family.

## Automatic monitoring (config-driven)

Enabled by setting `monitor_interval` (context or receiver or event_queue scope)
along with `monitor_transport` and `monitor_transport_opts`.

When context-level automatic monitoring fires, the `monitor()` function in
`lbmmonctl.c` retrieves **all** statistics for that context in a single pass:
context stats, source transport stats, receiver transport stats, and IM stats.
All records emitted use the same ApplicationSourceID — either from the
`monitor_appid` context-scope config option, or the process name if unset.

`monitor_appid` exists at context and event_queue scope only (not receiver or
source scope).

Automatic monitoring auto-registers receivers (`lbmmon_rcv_topic_automonitor`
in `lbmrcv.c`), wildcard receivers, and event queues as they are created.
Sources do not have a separate auto-registration path — their stats are
collected as part of context-level monitoring via
`lbm_context_retrieve_src_transport_stats()`.

## Explicit monitoring API

Applications can call `lbmmon_src_monitor()`, `lbmmon_rcv_monitor()`,
`lbmmon_context_monitor()`, `lbmmon_evq_monitor()`, etc. directly.
Each call takes its own `ApplicationSourceID` parameter, so a single process
can register different objects with different names.

## Monitoring context resource defaults

When the LBM monitoring transport creates its internal context (for
sending statistics), it deliberately minimizes resource usage by
overriding several defaults:

- `request_tcp_bind_request_port` = `0` — no request port bound
- `monitor_interval` = `0` — monitoring disabled (avoids recursion)
- `mim_incoming_address` = `"0.0.0.0"` — MIM receiver disabled
- `resolver_cache` = `0` — no topic caching
- `operational_mode` = `"embedded"`

These are set as defaults before applying any user-supplied config
file or `monitor_transport_opts` overrides.  For the source-side
monitoring context, the user can override these via
`monitor_transport_opts` (e.g., `"config=mymon.cfg"` or scoped
key-value pairs).

Source: `src/mon/lbmmontrlbm.c`, `SourceContextOption[]` and
`ReceiverContextOption[]` tables, plus the explicit
`lbm_context_attr_str_setopt(..., "request_tcp_bind_request_port", "0")`
call in the init path.

## The monitoring context inherits application-level XML templates

The LBM monitoring transport creates its context with `context_name` set
to `29west_statistics_context`, and `lbm_context_create()` then applies XML
config by that name (`lbm_xmlcfg_check_context()` in `lbmxmlcfg.c`). It goes
through the same layers as any other context: the `<application template=...>`
templates first, then `<contexts template=...>`, then the templates and options
of `<context name="29west_statistics_context">`. So whatever an
application-level template sets for the application's own contexts also lands
on the monitoring context, unless the monitoring context's own template
overrides it. (`context_name` and `request_tcp_bind_request_port=0` are set
with `setopt`, so XML can't override those; see the `usroptmask` note in
`config_details.md` §3a.)

The trap is topic-resolution settings in an application-level template.
`resolver_service` and `resolver_unicast_daemon` are list options that
accumulate rather than override (`config_details.md` §3a), and an inherited
`resolver_disable_udp_topic_resolution=1` also disables `lbmrd`-based
resolution.

Real case (UM 6.17): an application-level template set `resolver_service`
(SRS) and `resolver_disable_udp_topic_resolution=1` for the data TRD. The
monitoring context's own template added an `lbmrd` for the monitoring TRD, but
inherited both settings: it resolved through the SRS with `lbmrd` resolution
off, and the MCS never received that application's statistics.

**Symptom:** one application's records are missing from the MCS/`lbmmon`
output while other applications' arrive. The application's log shows an
`SRS Controller Connection ... for ContextID (N)` where N (decimal) is the
`29west_statistics_context` ContextID from its `Context ... created` line
(hex).

**Fix:** make the monitoring context's template self-contained by clearing the
inherited lists (`0.0.0.0:0`) and re-enabling UDP topic resolution:

```xml
<template name="mon_ctx">
  <options type="context">
    <!-- Override topic resolution settings inherited from the application's
         templates. An entry of 0.0.0.0:0 clears a resolver list. -->
    <option name="resolver_service" default-value="0.0.0.0:0"/>
    <option name="resolver_disable_udp_topic_resolution" default-value="0"/>
    <option name="resolver_unicast_daemon" default-value="0.0.0.0:0,LBMRD_IP:LBMRD_PORT"/>
    <!-- interface, port ranges, etc. for the monitoring TRD -->
  </options>
</template>
```

Alternatively, attach the data-TRD templates to the application's own
`<context>` element instead of `<application>`, so the monitoring context
never inherits them. Verified on UM 6.17: after the fix, the monitoring
context made no SRS connection and its records reached the MCS. Clearing an
inherited `lbmrd` list is confirmed from source only.

## Diagnostic implication

If lbmmon output shows multiple distinct ApplicationSourceIDs for the same
IP + process ID (e.g., `AppName`, `AppName_prc`, `AppName_tnf`), the
application is using the explicit monitoring API with per-object custom names.
Automatic monitoring alone cannot produce different names for different objects
within one context.

## Receive-side API (writing a monitoring consumer)

An app that *consumes* monitoring statistics — a diagnostic tool, a
metrics forwarder, a JSON transcoder — uses the `lbmmon_rctl_t`
receive controller, not the sender-side `lbmmon_*_monitor()` calls
above. Skip the rest of this section if the task is on the sender side.

### Setup shape

```c
lbmmon_rctl_attr_t *attr;
lbmmon_rctl_attr_create(&attr);

lbmmon_passthrough_statistics_func_t pt = { my_passthrough_cb };
lbmmon_rctl_attr_setopt(attr, LBMMON_RCTL_PASSTHROUGH_CALLBACK,
                        &pt, sizeof(pt));

lbmmon_rctl_t *monctl;
lbmmon_rctl_create(&monctl,
    lbmmon_format_pb_module(),      "passthrough=convert",
    lbmmon_transport_lbm_module(),  "topic=/29west/statistics",
    attr, /*client_data=*/NULL);
lbmmon_rctl_attr_delete(attr);

/* rctl_create spawned a worker thread; my_passthrough_cb fires there. */
/* Keep the process alive; on shutdown: */
lbmmon_rctl_destroy(monctl);
```

The controller owns its own context and receiver — the caller does
not create an `lbm_context_t` / `lbm_rcv_t`. Callbacks fire on
`lbmmon`'s dedicated worker thread and are serialized against each
other.

### Two usage patterns

`lbmmon` supports two independent styles for reading incoming stats,
selectable via the `passthrough` format option:

1. **Per-object-type callbacks (`passthrough=off`, default).** The
   caller registers one or more of
   `LBMMON_RCTL_SOURCE_CALLBACK`,
   `LBMMON_RCTL_RECEIVER_CALLBACK`,
   `LBMMON_RCTL_EVENT_QUEUE_CALLBACK`,
   `LBMMON_RCTL_CONTEXT_CALLBACK`,
   `LBMMON_RCTL_RECEIVER_TOPIC_CALLBACK`,
   `LBMMON_RCTL_WILDCARD_RECEIVER_CALLBACK`,
   `LBMMON_RCTL_UMESTORE_CALLBACK`,
   `LBMMON_RCTL_GATEWAY_CALLBACK`. Each callback receives a
   fully-deserialized statistics struct (`lbm_src_transport_stats_t`,
   `Lbmmon__UMPMonMsg *`, etc.). Best when the consumer wants to
   act on typed C fields directly.

2. **Passthrough (`passthrough=on` or `=convert`).** The caller
   registers `LBMMON_RCTL_PASSTHROUGH_CALLBACK` (only). The
   callback receives the packet header, the parsed
   `lbmmon_packet_attributes_t`, and the raw serialized payload
   bytes. Best when the consumer wants to route/reserialize/relay
   messages rather than consume typed fields — e.g. converting to
   JSON, forwarding to another system, writing to disk.

The shipped `src/example/lbmmon.c` registers **all** the per-object
callbacks *and* the passthrough callback to demonstrate every API
surface at once. Real consumers pick one style. The two are
mutually exclusive in practice: with `passthrough=on|convert` the
per-object deserializers short-circuit before invoking their typed
callbacks, so those callbacks never fire.

### `passthrough=convert` handles CSV senders transparently

`lbmmon_rctl_create` **always registers both built-in format
modules internally** (CSV at `formats[LBMMON_FORMAT_CSV_MODULE_ID]`,
PB at `formats[LBMMON_FORMAT_PB_MODULE_ID]`), regardless of the
`Format` argument passed. Dispatch keys off the *incoming packet's*
module ID. So even if the caller passes `lbmmon_format_pb_module()`,
a CSV packet still reaches the CSV deserializer.

With `passthrough=convert` in the format options (seen by both
built-in modules' `mInit`), the CSV deserializer parses the payload
into a `lbm_*_stats_t` struct, and the controller then invokes the
**PB** module's serializer to re-encode those stats as PB bytes.
The passthrough callback receives PB bytes regardless of what the
sender emitted. For PB packets, `passthrough=convert` is treated as
`passthrough=on` (a PB→PB conversion is a no-op).

Coverage: only the six object types the CSV module supported
convert — SOURCE, RECEIVER, EVENT_QUEUE, CONTEXT, RECEIVER_TOPIC,
WILDCARD_RECEIVER. UMESTORE, GATEWAY, SRS, UMDS, and
CONTROL_MESSAGE were PB-only from introduction; old CSV-only
senders never produced them.

### Transport events (BOS/EOS/loss) are not surfaced

The `lbm` transport module (`lbmmon_transport_lbm_module()`) owns
its own `lbm_rcv_t` on the statistics topic and consumes BOS,
EOS, and unrecoverable-loss events internally — they land in UM's
logger (`lbm_log`) but do not reach the passthrough or per-type
callbacks. A consumer that needs these events has to open a
separate `lbm_rcv_t` on the same topic in a separate context.

### `msg->source` (transport source string) is not surfaced

The passthrough callback receives `lbmmon_packet_attributes_t`
(sender IPv4, timestamp, ApplicationSourceID, process ID, context
instance, domain ID) but not the UM transport source string
(`"LBTRM:239.101.3.1:14400"`) that `lbm_msg_t->source` carries.
Consumers that need sender identity read it from the parsed
attributes; consumers that need the transport session use the same
"separate `lbm_rcv_t`" workaround as for transport events.

### Options-string lifetime

The format options and transport options passed to
`lbmmon_rctl_create` are consumed synchronously — both format
modules' `mInit` and the transport module's `mInitReceiver` walk
the strings with `strncpy` into private storage during the create
call, then never re-read the caller's buffer. Local automatic
storage (`std::string` in `main`, `char[]` on the stack) is safe;
the strings only need to outlive `lbmmon_rctl_create`. The one
exception is `mApplyOptions`, which re-reads the buffer — but that
path is invoked only by an explicit caller-driven API and doesn't
fire on its own.

### Transport modules

Besides `lbmmon_transport_lbm_module()`, UM ships
`lbmmon_transport_udp_module()` (raw UDP) and
`lbmmon_transport_lbmsnmp_module()` (SNMP-agent). The LBM
transport is the right choice when consuming the standard
`/29west/statistics` topic; the others exist for legacy transports.

The LBM transport module's options string accepts `config=FILE`
(a UM configuration file applied to the internal context and
receiver) and `topic=NAME` (statistics topic; default
`/29west/statistics`, set in `lbmmontrlbm.c:DEFAULT_TOPIC`).

## Where the protobuf monitoring messages are built

The `.proto` files are `src/monproto/*.proto` (internal source tree).
Each component fills its messages in different code; to learn what a
field really contains, read the filling code, not just the `.proto`:

| Message | `.proto` | Filled in |
|---|---|---|
| `UMSMonMsg` (library: context, transports, event queue, receiver topic, wildcard receiver) | `ums_mon.proto` | `src/mon/lbmmonfmtpb.c` (`lbmmon_*_format_pb_serialize()`; `_deserialize()` is the reverse), from the `lbm_*_stats_t` structs in `lbm.h` |
| `UMMonAttributes` (in every message) | `um_mon_attributes.proto` | `lbmmon_attributes_format_pb_serialize()` in `lbmmonfmtpb.c` for the library, Store, and DRO; `MonitorInfoMessage.srsAttributesToProtobuf()` for the SRS |
| `UMPMonMsg` (Store) | `ump_mon.proto` | `src/stored/umestats.c`: `umestore_lbmmon_retrieve_*()` for configs and stats; `umestore_process_event()` for events |
| `DROMonMsg` | `dro_mon.proto` | `src/gateway/tnwg_dstat.c` (`tnwg_retrieve_mon_*()`) |
| `SRSMonMsg` | `srs_mon.proto` | `src/srs/daemon/src/main/java/com/informatica/um/srs/monitor/MonitorInfoMessage.java` |

The deprecated non-protobuf daemon statistics have C structs in
`src/lib/lbm/umedmonmsgs.h` (Store) and `src/lib/lbm/tnwgdmonmsgs.h`
(DRO). Their field meanings are mostly still accurate for the matching
protobuf fields, but they are not maintained; the `.proto` comments are
the definitive field descriptions for the Store, DRO, and SRS.

Behaviors that surprise consumers:

- **Store IP addresses are integers.** `UMPMonMsg.Configs.ip_addr` and
  `...RcvConfig.ip_addr` are `uint32` holding the raw `s_addr` in
  network byte order (kept from `umedmonmsgs.h`). On an x86 Store host,
  10.29.3.42 arrives as 0x2A031D0A (704847114). Every other address in
  the monitoring messages is a dotted-decimal string.
- **SRS periodic updates set only what changed.** A snapshot sets every
  SRS statistic; a periodic update sets only the statistics that
  changed, so proto3 consumers see the others as zero, not as absent.
- **Store event gaps (as of DEV_MAIN, 2026-10).**
  `SOURCE_REREGISTERED_EVENT` is never delivered (no case for it in
  `umestore_process_event()`), and `Event.dmon_topic_idx` is never set.

## MCS: monitoring data as JSON in SQLite

With its SQLite connector, MCS stores each received message as one row
holding the **whole top-level message** as JSON, in the table for its
type: `umsmonmsg`, `umpmonmsg`, `dromonmsg`, or `srsmonmsg` (created by
`src/mon/daemon/src/bin/ummon_db.sql`; each has a single `message`
column). The conversion is Java
`JsonFormat.printer().includingDefaultValueFields()`
(`src/mon/daemon/.../connector/sqlite/UMMonDBSQLite.java`), so the
standard proto3 JSON mapping applies:

- Field names are lowerCamelCase (`bytes_sent` -> `bytesSent`); paths
  are rooted at the message, for example
  `$.stats.sourceTransports[0].lbtrm.bytesSent`.
- 64-bit integers are JSON **strings** (`"1000"`). SQLite's
  `json_extract()` returns them as text, so `max()`, `ORDER BY`, and
  `> N` compare as text (any text is greater than any number) unless
  the query uses `CAST(... AS INTEGER)`.
- Scalars are always present; unset sub-messages and unused `oneof`
  members are omitted; enums are value names; `bytes` are base64.
- `UMMonControlMsg` is not stored.

The Operations Guide's "MCS JSON Format" section documents every
stored field (path, type, description), generated from the `.proto`
files and `lbm.h` / `lbmmon.h` by `doc/share/gen_stats_map.py`.
