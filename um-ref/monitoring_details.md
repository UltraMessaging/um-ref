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
