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
