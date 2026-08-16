---
name: um-ref
description: Learn about Ultra Messaging (UM) in support of coding, configuring, and/or testing it. Triggers when the user asks to design, build, configure, port, extend, or test a program that uses the UM API in C, Java, or C#/.NET — e.g. code that includes `lbm.h` (from `$LBM_REPO/src/lib/lbm/` or `$LBM_INC/`), imports `com.latencybusters.lbm.*`, or references `UltraMessaging` / `LBM*` types. Also triggers when UM is the *subject* of the task: reading, interpreting, reviewing, or analyzing UM configuration files (library XML with `<um-configuration>`, Store XML, DRO/tnwgd configs, lbmrd configs, `.cfg` files with UM options); analyzing, reviewing, or designing application code that calls the UM API; explaining UM option semantics or diagnosing UM behavior (loss, NAKs, resolution, DRO routing). Keyword signals: `tnwgd`, `DRO`, `LBM`, `SRS`, `umestored`, `lbmrd`, option names like `transport_lbtru_*` / `transport_lbtrm_*` / `resolver_*` / `ume_*`. Do NOT trigger on incidental keyword sightings (directory listings, log filenames, grep output) where UM is not the subject of the task. Covers publishers, receivers, contexts, event queues, timers, wildcard receivers, persistence (UMP), and related UM features.
---

# Ultra Messaging (UM) — concepts for writing UM apps

This file is the load-bearing concept doc for any UM coding/design task.
Read it end-to-end before writing or reviewing UM code. Reference docs
(API headers, schema files) are listed in §1 and consulted as lookups.

## 0. Platform and prerequisites (read first)

This skill runs on both Linux/WSL and Windows (Git Bash). Two
user-satisfied prerequisites and a couple of platform rules:

- **`LBM_REPO` / `LBM_INC` / `LBM_DOC`** — at least one must point at a
  UM source (see the Environment check below).
- **`python` must invoke Python 3.6+.** The helper tools (`lbmopt.py`,
  `xmlopt.py`, the `gen_*` scripts) are invoked as **`python …`**, never
  `python3`. They are pure-Python and OS-agnostic; they only need a
  Python 3 interpreter on the `python` name.
  - **Windows (Git Bash):** `python3` usually does *not* exist but
    `python` does and is Python 3 — so the tools work out of the box.
  - **Linux/WSL:** if `python` is missing (some distros ship only
    `python3`), map it: `ln -s "$(command -v python3)" ~/.local/bin/python`
    (ensure `~/.local/bin` is on `PATH`). If a task needs a tool and
    `python` isn't found, offer to create this symlink for the user
    before proceeding.

**Path/symlink rule by platform.** The skill prefers symlink paths
(`./lbm_repo/…`) over env-var paths (`$LBM_REPO/…`) to avoid per-command
permission prompts — but that only applies on **Linux/WSL**, where
symlinks are real. On **Windows**, native symlinks require admin or
Developer Mode and `ln -s` in Git Bash silently makes a *copy*, not a
link — so **do not create or rely on `lbm_repo`/`lbm_inc`/`lbm_doc`
symlinks on Windows; use the `$LBM_REPO`/`$LBM_INC`/`$LBM_DOC` env-var
paths directly.** They resolve correctly there (Git Bash accepts the
mixed `C:\…\lbm/src/…` form, and Python's `os.path.join` handles the
backslashes).

**Configuration review:** when asked to review or audit any UM
configuration file (library XML or Store XML), read
`configuration_best_practices.md` before commenting. Use it as the
checklist; use `lbmopt.py` and `store_config.md` for per-option
lookup.

DRO (cross-network routing) is a separate concept space — see
`dro_details.md` and `dro_config.md` only when the task involves
topology design.

**Version:** this skill describes **UM 6.17.1**. Behavior, default
values, and the set of supported options are all version-specific.
If the deployment under discussion is on a different UM version,
verify against that version's documentation before relying on
specifics from this skill.

**Version compatibility rule:** an application built against an
older UM version can run against a newer library — this is the
supported direction. The reverse (build against a newer library,
deploy against an older library) is **not** supported: the newer
build may expect fields or APIs the older library doesn't have.
Customers usually don't have to think about this; UM's design
(most structs opaque, visible ones only ever grow at the end,
library always allocates) makes it work transparently. When
diagnosing weird cross-version behavior, confirm the build/deploy
direction before looking further. Deep-dive in `gotchas.md`
("Cross-edition daemon/library in one install").

**Environment check:** Once per conversation, run `printenv LBM_REPO
LBM_INC LBM_DOC` (and, on Linux/WSL only, `ls lbm_repo lbm_inc
lbm_doc` for the symlink form) to see which of these three independent
UM sources are available:

- `lbm_repo` / `LBM_REPO` — full source tree (internal engineers):
  headers, source, m4 doc sources, config-data.xml, examples.
- `lbm_inc` / `LBM_INC` — public API headers only (customers):
  `lbm.h` and other public `.h` files.
- `lbm_doc` / `LBM_DOC` — unzipped HTML documentation root
  (customers): built doc tree navigable via grep and read.

Two rules for using them:

1. **On Linux/WSL, prefer the symlink path over the env-var path** for
   direct file reads (`./lbm_repo/...` over `$LBM_REPO/...`). Env-var
   expansions trigger a permission prompt every command; symlinks don't.
   **On Windows this rule is inverted** — symlinks aren't reliable
   (see §0), so use `$LBM_REPO/...` directly.
2. **In customer mode** (no `lbm_repo`), don't cite internal source
   paths in responses — describe behavior, cite options and public
   API, quote from public headers.

`lbmopt.py` and `xmlopt.py` resolve everything themselves and fall
back to bundled copies of `config-data.xml`, `index-ume.m4`, and
`index-dro.m4` if no repo is available — no env var or symlink is
required to answer per-option config questions.

If the environment check finds none of the three sources configured
(no env var, and on Linux/WSL no symlink either), read `setup_help.md`
and walk the user through it before proceeding — that file covers what
to point where, symlinks vs. env vars, and the `python` symlink. If
the sources are present but a task specifically needs one that isn't
(e.g., API signatures with only `lbm_doc` set), tell the user once
which one is missing and continue with what's available where possible.

**Version drift note:** The bundled `config-data.xml` / m4 sources
are version-locked to this skill's release (see the **Version:**
banner above). If `lbm_repo` or `lbm_doc` points at a *different* UM
version, the tool output and doc prose will disagree with the
skill's prose. Prefer the user's deployed version for their concrete
question, and flag the mismatch.

**When to read what.** A quick router for the rest of the skill:

| Task | Start here |
| --- | --- |
| Writing UM application code (C/Java/.NET) | this file (SKILL.md), §2 onward |
| Auditing or designing a UM application config | `configuration_best_practices.md` first, then `config_details.md` for prose, `lbmopt.py` for per-option lookup |
| Looking up a C API function/type | `lbm.h` under `lbm_repo/src/lib/lbm/` (internal) or `lbm_inc/` (customer) |
| Looking up Java/.NET API | `java_api.md`, `dotnet_api.md` |
| Tuning or understanding LBT-RM NAK suppression / timers | `lbtrm_details.md` |
| Message fragmentation, APDU, datagram sizing (1472 / dynamic_fragmentation_reduction) | `fragmentation_details.md` |
| Designing a DRO topology / cross-TRD routing | `dro_details.md`, then `dro_config.md` |
| Understanding lbmmon output / monitoring API | `monitoring_details.md` |
| Sizing or operating a persistent Store | `configuration_best_practices.md` §3–5, then `store_config.md` for schema lookup |
| Need full doc prose (rare) | Internal: `lbm_repo/doc/*/index.m4`. Customer: grep HTML files under `lbm_doc/` |
| A UM behavior contradicts what the API implies, or a customer says "flipping this knob broke my code" | `gotchas.md` |

## 1. File inventory

### This skill directory (always available):

- `SKILL.md` — this file. Concepts for application coding, including
  persistence (UMP / Store) and example-app anti-patterns.
- `java_api.md` — Java API. The source-of-truth API reference;
  check this before reading the HTML doc when you need throws
  clauses or full overload menus.
- `dotnet_api.md` — C#/.NET API. Reference lookup.
- `config-data.xml` — bundled UM library configuration options
  reference, version-locked to this skill. Used by `lbmopt.py` when
  no repo path is set. Do not read directly — use `lbmopt.py`.
- `index-ume.m4`, `index-dro.m4` — bundled m4 sources for the
  Persistence Guide and DRO Guide, used by `xmlopt.py` when no repo
  path is set.
- `lbmopt.py` — query tool for `config-data.xml` (the UM library
  configuration options reference). Preferred over reading the XML
  directly; handles multi-scope options and entity escapes correctly.
  Locates `config-data.xml` in this order:
  `./lbm_repo/doc/Config/reference/config-data.xml` →
  `$LBM_REPO/doc/Config/reference/config-data.xml` → bundled copy in
  the skill directory.
  ```
  python lbmopt.py <name>              # scope(s) + default(s)
  python lbmopt.py <name> <scope>      # full dump
  python lbmopt.py --search <keyword>  # find options by name fragment
  python lbmopt.py --scope <scope>     # list all options in a scope
  python lbmopt.py --list-scopes       # show all scopes
  ```
- `xmlopt.py` — query tool for Store (`ume`) and DRO (`dro`) XML config.
  Parses m4 sources. For each source, locates the file in this order:
  `./lbm_repo/doc/<Guide>/index.m4` → `$LBM_REPO/doc/<Guide>/index.m4`
  → bundled `index-ume.m4` / `index-dro.m4` in the skill directory.
  Does not read `lbm_doc` — parser is m4-specific.
  ```
  python xmlopt.py ume <element-id>             # Store XML element/attribute
  python xmlopt.py dro <element-id>             # DRO XML element/attribute
  python xmlopt.py ume <id> --full              # include example XML
  python xmlopt.py ume store-opt <name>         # <ume-attributes> store option
  python xmlopt.py ume store-opt --list         # list all store options
  python xmlopt.py ume --list / --search <kw>   # browse element ids
  ```
  Element-id uses dot notation: `store`, `store.name`,
  `gateway-keepalive.interval`. Use `lbmopt.py` for UM library options.
- `configuration_best_practices.md` — **actionable checklist** for
  writing, auditing, or debugging any UM config (library or Store).
  Start here before `config_details.md` or `store_config.md`.
- `config_details.md` — concept doc for UM application configuration:
  precedence, XML structure, allow/deny rules, interrelated-option
  pitfalls. Read when designing or auditing a config; use
  `config-data.xml` for individual options.
- `store_config.md` — XML schema for the Store (`umestored`). Read
  the persistence sections of this file first; use the schema as a
  lookup.
- `lbtrm_details.md` — LBT-RM protocol internals: NAK suppression
  algorithm, all five timer interactions, NCF behavior, rate limiting,
  differences from PGM. Read when tuning LBT-RM or diagnosing recovery
  latency; use `configuration_best_practices.md` §2 for the actionable
  rules.
- `fragmentation_details.md` — message fragmentation on the send path:
  the APDU concept (`apdu` / `raw_apdu` / `frag_mtu`), how
  `dynamic_fragmentation_reduction` makes the APDU dynamic per-message,
  the MTU/header math behind `datagram_max_size = 1472`, and why the
  `LBM_DEBUG_NET` "APDU" log line is misleading under DFR. Read when
  tuning datagram sizes to avoid IP fragmentation or diagnosing
  unexpected fragmentation.
- `monitoring_details.md` — how ApplicationSourceID works in lbmmon
  output, automatic vs explicit monitoring, monitoring context
  resource defaults, and diagnostic implications.
- `dro_details.md` — concept doc for cross-TRD routing via DRO.
  Companion to `dro_config.md` (schema). Read only when designing
  topology, not while writing application code.
- `dro_config.md` — DRO XML schema. Lookup.
- `gotchas.md` — University of Hard Knocks file: surprising UM
  behaviors that don't fit any single subsystem. Consult when a
  behavior contradicts what the API surface implies, or when a
  customer says "it used to work; then I flipped one config knob and
  it broke." Keyword-indexed for grep. Not consulted routinely.
- `build.sh` — regenerates `java_api.md` and `dotnet_api.md` from
  the upstream Java and C# sources. Run after upstream API changes;
  outputs are checked in so a fresh clone is usable without it.
- `RELEASE_UPGRADE.md` — runbook for the skill maintainer when
  upgrading this skill to a new UM release. Not consulted during
  normal use.

### Out-of-tree — internal mode (`lbm_repo` / `LBM_REPO`):

Paths below use the `lbm_repo/` prefix (symlink form); if only the
env var is set, substitute `$LBM_REPO/` — but prefer the symlink to
avoid repeated permission prompts.

- `lbm_repo/src/lib/lbm/lbm.h` — C API (Doxygen-commented). Reference lookup.
- `lbm_repo/doc/Config/reference/config-data.xml` — UM library
  configuration options reference (XML). Per-option lookup (defaults,
  types, units, allowed values). **Do not parse manually** — use
  `lbmopt.py`.
- `lbm_repo/doc/` — Full user docs (un-built m4 source; rarely
  needed). Each guide's `index.m4` is a single large file. Don't read
  it whole — `grep '^\m4_pg' <file>` produces a table of contents
  with line numbers (one `\m4_pg <anchor> <title>` per section), then
  read only the relevant range:
  - `lbm_repo/doc/Design/index.m4` — Concepts Guide.
  - `lbm_repo/doc/UME/index.m4` — Persistence Guide.
  - `lbm_repo/doc/Gateway/index.m4` — DRO Guide.
  - `lbm_repo/doc/Config/index.m4` — Configuration Guide. Per-option
    detail is generated from `config-data.xml`; read `index.m4` for
    prose context only.
  - `lbm_repo/doc/Operations/index.m4` — Operations Guide.
- Example apps: `lbm_repo/src/example/*.c`, `lbm_repo/src/java/*.java`,
  `lbm_repo/src/dotnet/example/*.cs`. Not production patterns — see
  §18 before copying.
- Product source: `lbm_repo/src/{lib/lbm,gateway,stored,srs,lbmrd,java/com/latencybusters/lbm,jni,dotnet/lbmcs}/`.

### Out-of-tree — customer mode (`lbm_inc` / `lbm_doc`):

Prefer the symlink paths (`lbm_inc/`, `lbm_doc/`) over env-var
expansion for the same reason.

- `lbm_inc/lbm.h` (and other `*.h`) — C API (Doxygen-commented).
  Reference lookup for function signatures, types, constants.
- `lbm_doc/` — Unzipped HTML documentation tree. Contains the built
  guides as HTML files. Use for prose/context (e.g. Concepts Guide
  narrative that the m4 sources don't distill). Navigation strategy:
  - Use `find lbm_doc/ -name "*.html"` to discover available pages.
  - Use `grep -rl <keyword> lbm_doc/` to locate relevant content.
  - Read the matching HTML file(s). HTML is readable as markup —
    extract the prose, ignore boilerplate tags.
  - For per-option config lookup, use `lbmopt.py` / `xmlopt.py`
    (which read the bundled XML / m4 sources) — not `lbm_doc`.

Queueing (UMQ) has had little customer uptake; treat as out of scope
unless explicitly asked.

## 2. Core model

UM is topic-based pub/sub middleware: low latency, high throughput,
configurable reliability. Publishers send to **topics** (string names,
e.g. `"stock.AAPL"`); subscribers receive from topics they're interested
in. UM handles discovery, routing, and delivery. Topics are
lightweight — apps commonly use 100,000+.

### Core objects

- **Context** (`lbm_context_t`) — container for all sources/receivers
  in an app. Manages network resources and discovery. Spawns a
  background **context thread** that processes events. Typically one
  per app, though multiple are valid.
- **Source** (`lbm_src_t`) — publisher endpoint for one topic. Created
  from a context. Use `lbm_src_send()` to publish.
- **Receiver** (`lbm_rcv_t`) — subscriber endpoint for one topic (or a
  pattern). Receives via callback.
- **Event Queue** (`lbm_event_queue_t`) — optional. Decouples callbacks
  from the context thread. Skip for simple/fast callbacks.

### Minimal publisher (C)

```c
lbm_context_t *ctx; lbm_src_t *src; lbm_topic_t *topic;
lbm_context_create(&ctx, NULL, NULL, NULL);
lbm_src_topic_alloc(&topic, ctx, "my.topic", NULL);
lbm_src_create(&src, ctx, topic, NULL, NULL, NULL);
lbm_src_send(src, "Hello", 6, LBM_MSG_FLUSH);
lbm_src_delete(src); lbm_context_delete(ctx);
```

### Minimal subscriber (C)

```c
int rcv_cb(lbm_rcv_t *rcv, lbm_msg_t *msg, void *clientd) {
    switch (msg->type) {
        case LBM_MSG_DATA: /* msg->data, msg->len */ break;
        case LBM_MSG_BOS:  /* publisher started */    break;
        case LBM_MSG_EOS:  /* publisher stopped */    break;
    }
    return 0;
}
lbm_context_t *ctx; lbm_rcv_t *rcv; lbm_topic_t *topic;
lbm_context_create(&ctx, NULL, NULL, NULL);
lbm_rcv_topic_lookup(&topic, ctx, "my.topic", NULL);
lbm_rcv_create(&rcv, ctx, topic, rcv_cb, NULL, NULL);
/* context thread runs the callback; main does other work */
lbm_rcv_delete(rcv); lbm_context_delete(ctx);
```

## 3. Topic resolution (TR)

UM uses **topic resolution** for automatic discovery — you don't
configure where peers live; they find each other. Publishers
advertise (topic name + transport + address); receivers listen for
ads, match topic names, and join the data transport.

All processes that should discover each other share a **TR domain**
(TRD), defined by multicast group+port (multicast TR), server IP+port
(`lbmrd` unicast TR), or SRS endpoint (TCP-based TR).

### TR transports

- **Multicast TR** (default) — UDP multicast for ads. Zero config on a
  LAN.
- **`lbmrd`** (unicast TR) — stateless server simulating multicast for
  TR. Configured via `resolver_unicast_daemon`. Use when multicast is
  unavailable or when client churn is high.
- **SRS** (TCP TR) — Smart Request Service server. Most scalable;
  only advertises topics that have been subscribed (big bandwidth win).
  Configured via `resolver_service`.

**Choosing `lbmrd` vs SRS:** client churn pattern matters more than
peak scalability. SRS keeps per-client session state and churns on
every reconnect, so roaming/short-session deployments prefer
`lbmrd`. SRS pays off for steady-state with many long-lived clients.
When in doubt: `lbmrd` is the conservative choice; SRS is the scale
choice.

### Resolver options are read at context create

`resolver_unicast_daemon`, `resolver_service`, multicast addresses,
local interface bindings — all read once during
`lbm_context_create()`. There is no API to re-target a running
context. To point at a different resolver server (or pick up a new
local IP after an interface change), the context must be destroyed
and recreated. Sources/receivers go with it; if the long-lived state
must survive, keep it on a separate context and use a disposable
context for the leg that needs to retarget.

## 4. Transports (data path)

After discovery, messages flow over data transports. The transport is
independent of TR.

- **LBT-RM** (default) — reliable multicast over UDP. NAK-based
  recovery. Best for one-publisher / many-subscribers.
- **LBT-RU** — reliable unicast over UDP. NAK-based recovery.
- **TCP** — reliable TCP. Receiver-paced. Use when firewalls block
  UDP, or when you need the no-gap property below.
- **LBT-IPC** — shared memory between processes on one host. Lowest
  latency for same-host. Requires IPC resource manager.
- **LBT-SMX** — optimized shared memory. Even lower latency, more
  restrictive than IPC.

### TCP no-mid-stream-gaps property (load-bearing for layered protocols)

A TCP transport session has no mid-stream gaps. While the socket is
still connected, every byte sent before byte N has arrived before
byte N. Apps building reliable-hop protocols on top of UM-over-TCP
can use this: an ack for message N implicitly confirms all prior
messages on the same socket — no selective retransmission, no
per-seqno ack table. UDP-based transports (LBT-RM, LBT-RU) do **not**
have this property; they can present mid-stream gaps that the app
must handle.

### Transport sessions

Multiple topics share the same underlying transport session, keyed by
transport type + network address. 1000 topics might use 10 transport
sessions. Receivers see data for every topic on the session and
filter at the app layer. Loss recovery happens at the transport
level, not the topic level.

Source config determines transport (`transport`, e.g. `lbtrm`/`lbtru`/
`tcp`/`lbtipc`/`lbtsmx`) and address (e.g. `transport_lbtrm_multicast_address`,
`transport_lbtrm_destination_port`).

### Source-side filtering

By default, a source sends all topics on a transport session to all
connected receivers.  With **source-side filtering** enabled
(`transport_source_side_filtering_behavior` = `"inclusion"`), the
source sends nothing to a receiver until that receiver declares which
topics it wants.

**Handshake mechanism:** The receiver sends its topic interest to the
source's **request port** (the TCP UIM port, i.e.
`request_tcp_bind_request_port` on the source's context).  The source
then begins sending only the requested topics to that receiver.

**Applicability:** LBT-RU and TCP only.  Not applicable to LBT-RM
(multicast sources have no per-receiver state to filter).

**Key implication:** Any context acting as a source with source-side
filtering enabled **must have a reachable request port**.  If
`request_tcp_bind_request_port` is 0 (disabled) or unreachable,
receivers cannot register interest and will receive no data.  The
source logs Core-5988-2 when a receiver attempts the handshake but
the request port is not available.

## 5. Messages

### Content

UM treats payloads as opaque byte arrays — no serialization, no
endianness conversion. Messages can be arbitrarily large; UM
fragments large messages into datagrams (default 8KB on UDP-based
transports, configurable) and reassembles transparently.

### Ordering

- Guaranteed: per topic, per publisher.
- Not guaranteed: across topics, or across publishers on the same
  topic.

### Ordered vs arrival-order delivery

- **Ordered** (default) — message N+1 waits for recovery of N if N
  was lost.
- **Arrival order** — deliver immediately on arrival; gaps surface as
  unrecoverable loss later. Useful for "latest value" patterns
  (quotes, telemetry). Set `ordered_delivery 0` on the receiver.

### Loss handling

Transport detects loss and recovers via NAK/retransmission
automatically. When recovery fails (timeouts/buffer limits),
the app sees `LBM_MSG_UNRECOVERABLE_LOSS` with the gap's seqno range
and decides what to do.

```c
case LBM_MSG_UNRECOVERABLE_LOSS:
    /* msg->sequence_number_first_lost, msg->sequence_number_last_lost */
```

## 6. Message lifecycle and memory

### Default lifetime

`lbm_msg_t` (C) / `LBMMessage` (Java) is valid **only during the
callback**. After the callback returns, UM may free or reuse the
message.

### If you only need the bytes

Copy them. `memcpy` in C, `Arrays.copyOf` in Java.

### Zero Object Delivery (ZOD) — why dispose() matters

Calling `dispose()` (Java) / `Dispose()` (.NET) before the callback
returns is not just cleanup — it enables ZOD. When `dispose()` is
called inside the callback, UM can reuse the message object on the
next delivery rather than allocating a new one. This eliminates per-
message GC pressure without any other configuration.

**Java: prefer `dataBuffer()` over `data()`**

`msg.data()` copies the payload into a new `byte[]` on every call.
`msg.dataBuffer()` + `msg.dataLength()` returns a `ByteBuffer` backed
directly by UM's internal buffer — no copy, no allocation. Use
`dataBuffer()` whenever you don't need a standalone `byte[]`.

### If you need the message handle later

Use the retain APIs to extend lifetime past the callback. Required
when you'll later call `lbm_msg_send_explicit_ack`,
`lbm_msg_respond`, or otherwise act on UM-level metadata.
Copying bytes is not enough.

**C:**

```c
lbm_msg_retain(msg);            /* before callback returns */
/* … later, on any thread … */
lbm_msg_delete(msg);            /* exactly once */
```

**Java:**

```java
LBMMessage retained = msg.promote();   /* before onReceive returns */
/* … later … */
retained.dispose();                    /* exactly once */
```

Java notes:

- `promote()` returns a **new** `LBMMessage`; don't keep using the
  original.
- `promote()` is not thread-safe on a given message — call from the
  receive callback before any other thread can see it.
- `promote()` prevents ZOD for that message. To reclaim the promoted
  object efficiently (avoid GC), use an `LBMObjectRecycler`:

```java
LBMObjectRecycler objRec = new LBMObjectRecycler();
LBMContextAttributes ctxAttr = new LBMContextAttributes();
ctxAttr.setObjectRecycler(objRec, null);
LBMReceiverAttributes rcvAttr = new LBMReceiverAttributes();
rcvAttr.setObjectRecycler(objRec, null);

// In callback — deferred processing:
LBMMessage retained = msg.promote();
myQueue.add(retained);
return 0;

// Elsewhere, when done:
retained.dispose();
objRec.doneWithMessage(retained);   // returns object to pool

// At shutdown, after closing all receivers and contexts:
objRec.close();
```

`doneWithMessage()` is what actually returns the object to the pool;
`dispose()` alone does not. A single recycler can be shared across
multiple contexts (it uses thread-local storage internally).

Forgetting the delete/dispose leaks; doing it twice is undefined.

## 7. Threading

### Default model

- Creating a context spawns a **context thread** that runs the event
  loop (sockets, timers, callbacks).
- Receiver callbacks run on the context thread, not the app's main
  thread. Callbacks are serialized against each other (a BOS
  callback won't fire while a data callback is running on the same
  context), but they are **not** serialized against main — any state
  shared with main needs synchronization.
- Most UM objects are not thread-safe; don't call most UM APIs from
  inside callbacks (a few are explicitly callback-safe — check the
  API doc).

Caveats to the "single context thread" picture:

- `lbm_context_process_events` / sequential mode: app pumps events on
  its own thread; no separate context thread.
- XSP (Transport Services Providers) splits receive-side work across
  additional threads. The shipped examples don't use XSP.

### Event queues — decoupling callbacks from the context thread

A slow callback on the context thread blocks event processing →
socket buffers fill → loss. Fix: route callbacks through an event
queue dispatched by an app thread.

```c
lbm_event_queue_t *evq;
lbm_event_queue_create(&evq, NULL, NULL, NULL);
lbm_rcv_create(&rcv, ctx, topic, rcv_cb, NULL, evq);
while (running) lbm_event_dispatch(evq, LBM_EVENT_QUEUE_BLOCK);
```

Cost: extra memory copy + context switches + queue management.
Trade: simplicity at low rates, freedom for slow callbacks. Skip for
short, fast callbacks where the context-thread overhead is the
dominant constraint.

### Activity timeout from slow callbacks

The LBT-RM/LBT-RU activity timeout (`transport_lbtrm_activity_timeout`,
default 60000 ms) counts wall-clock time since the last packet read
on the transport. Since reads happen on the context thread, a callback
that blocks the context thread longer than the activity timeout —
even if the source is still actively sending — triggers a spurious
EOS. UM tears down the delivery controller and discards any queued
messages (including pending request deliveries).

This can happen without an obvious "slow" operation: processing
hundreds of thousands of sequential events (e.g., per-seqnum
unrecoverable loss callbacks each doing a printf) accumulates enough
I/O time to exceed the timeout. Fix: never do slow work in the
callback; record to memory and process later, or use an event queue.

### Sequential vs embedded

Stick with sequential (default — context thread runs automatically).
Embedded mode (no context thread; app calls a processing function
explicitly) is rarely used and easy to get wrong.

## 8. Request / response (asynchronous)

`lbm_send_request` (C) and `LBMSource.send(LBMRequest, ...)` (Java)
**return immediately** after queuing the request. The response
arrives later, on a context thread, via a callback registered on the
request. Treating the send call as if it blocks is a common design
error.

There is no blocking wait-for-response helper in the C API. The only
supported pattern is async: send the request, return, handle the
response in the callback. Java likewise has no blocking equivalent.

**C — typical async:**

```c
lbm_request_t *req;
lbm_send_request(src, msg, len, &req, response_cb, clientd,
                 NULL /* evq */, 0 /* flags */);
/* returns immediately; response_cb fires later with the response */

/* Receiver side (in the receive callback): */
if (msg->type == LBM_MSG_REQUEST) {
    lbm_send_response(msg->response, reply, reply_len, 0);
}
```

**Java — async (only supported pattern):**

```java
LBMRequest req = new LBMRequest(payload, payload.length);
req.addResponseCallback(myResponseCallback);   // implements LBMResponseCallback
src.send(req, LBM.MSG_FLUSH);                  // returns immediately

public int onResponse(Object cbArg, LBMRequest req, LBMMessage msg) {
    /* … handle response … */
    msg.dispose();
    return 0;
}

// Receiver side (in LBMReceiverCallback.onReceive):
if (msg.type() == LBM.MSG_REQUEST) {
    msg.respond(reply, reply.length, 0);
}
```

Common mistakes:

- **Treating `src.send(req, …)` as blocking.** A design that says
  "call send, then ack the upstream Store on the call's return" is
  wrong; the call has returned long before the response arrives. Ack
  must happen inside the response callback.
- **Blocking inside the receive callback** waiting for a response.
  Starves all other receivers in the same context, hangs
  back-pressure, pins the context thread. Correct shape: receive
  callback enqueues the work and returns; another path (timer, the
  response callback, a worker thread) issues the request.
- **Calling `lbm_send_response` with blocking flags from the
  callback.** The default (flags=0) is blocking, which deadlocks
  when called from the context thread. The error is:
  "CoreApi-5688-3680: Blocking sends from within a context-thread
  callback can deadlock." Always use `LBM_SRC_NONBLOCK` when
  responding from inside a receiver callback:
  `lbm_send_response(msg->response, data, len, LBM_SRC_NONBLOCK);`

If older UM overview docs you encounter present the synchronous
helper as the canonical pattern: that presentation is misleading.
Default to async.

### TCP options for request/response

Two options matter and are often left at defaults:

- **`response_tcp_nodelay`** — set to `1`. Without it, the kernel's
  Nagle algorithm may delay small response packets by up to 200 ms.
  The default is `0` (Nagle on), which is the wrong default for any
  latency-sensitive req/resp usage.
- **`response_tcp_deletion_timeout`** — ms the source keeps a
  response TCP connection alive after the response is received,
  waiting for retransmits. Default `3000` (3 s). When persistence is
  in use, a stability ACK cycle can take many seconds (flight-size
  stall, stability-ACK batching, slow Store); extend this to at
  least 2–3× the worst-case stability-ACK round trip, or the
  response transport closes before the ack fires and you lose the
  response.

## 9. Common patterns

### Wildcard receivers

```c
lbm_rcv_topic_attr_t *attr; lbm_rcv_topic_attr_create(&attr);
lbm_rcv_topic_attr_str_setopt(attr, "pattern_type", "pcre");
lbm_rcv_topic_lookup(&topic, ctx, "stock\\..*", attr);
lbm_rcv_create(&rcv, ctx, topic, callback, NULL, NULL);
```

Use for topic hierarchies (`sensor\.room\d+\.temp`) or dynamic topic
sets.

### Hot failover (HFX)

Multiple sources publish the same topic; the receiver listens to the
highest-priority active source. Sources coordinate via the HFX
protocol.

### Late join

Source retains recent messages; new receiver pulls history when
subscribing. The retention buffer is **per topic** (not per transport
session) and lives on the source side independent of persistence.

- Streaming (non-UME): `retransmit_retention_size_threshold` /
  `retransmit_retention_size_limit` /
  `retransmit_retention_age_threshold`. The buffer fills to the
  configured size, then rolls oldest-out as new messages are sent.
- Persistent (UME): same buffer, but the Store keeps it fresh by
  sending stability confirmations that let entries retire.
  `ume_retention_size_threshold`,
  `ume_retention_unique_confirmations`.

Receiver: `use_otr 1` to opt into OTR fetches when transport-level
recovery times out.

Because retention is per-topic while the transmission window is
per-transport-session, retention also protects slow topics from
starvation on a shared session. Example: topics `fast` and `slow`
share one LBT-RM session; a burst on `fast` can push `slow`'s
message out of the session txwmap, but `slow`'s retention buffer
still holds the message and can serve a late-join or OTR request
for it.

### Implicit batching

UM auto-batches small messages into single datagrams to reduce per-
packet overhead. Use `LBM_MSG_FLUSH` to force immediate send (and
disable batching for that message).

### Off-Transport Recovery (OTR)

Receiver-driven fetch from the source's retention buffer (see
"Late join" above) when transport-level NAK recovery times out.
Works for streaming and persistent sources. Receiver opt-in:
`use_otr 1`.

## 10. Persistence (UMP / Store) — architecture

The Store (`umestored` daemon) gives apps "guaranteed delivery"
semantics: messages survive publisher restart, subscriber restart,
and temporary subscriber absence. If a deployment doesn't use
persistence, this whole section can be skipped.

```
             (transport: mcast / RU / TCP)
    Source ──────────────────────────────▶ Receivers
      │                                        ▲
      │ (TCP)                                  │ (TCP, on recovery)
      ▼                                        │
    Store ───────────────────────────────────┘
```

- The source sends each message to **both** receivers (via the normal
  transport) and the Store (via TCP), in parallel. Persistence is a
  fan-out leg, not in the hot path between source and receiver.
- The Store writes to its repository (RAM and/or disk) and returns a
  **stability ACK** to the source.
- A receiver that misses messages (transient loss, crash/restart)
  recovers them from the Store via TCP.

So persistence does not add latency to normal delivery, but it does
add a second thing that can fill, block, or fail.

### Process vs instance vs repository

- **Store Process** — one `umestored` daemon.
- **Store Instance** — one `<store>` element in the Store XML; a
  process may host several.
- **Repository** — one per registered source on a matching topic.
  The unit of retention.

## 11. SPP vs RPP — the pacing choice

This is the biggest architectural decision in a persistent
deployment.

### Source-Paced Persistence (SPP) — default

- Source sends at its natural rate.
- Store retains up to `repository-size-limit` (or
  `repository-disk-file-size-limit` for disk Stores), then
  **overwrites oldest** like a circular buffer.
- A slow/absent receiver that falls behind the retention window gets
  unrecoverable loss.
- Source does NOT block on slow receivers. It may briefly block on
  `ume_flight_size` / `ume_flight_size_bytes` if Store stability ACKs
  lag, but that's independent of receiver pace.
- Use when publishers cannot be slowed (market data, sensor feeds).

### Receiver-Paced Persistence (RPP)

- Store retains messages **only as long as some registered receiver
  still needs them**. When all registered receivers ACK, the Store
  deletes.
- If a slow receiver can't keep up and its backlog grows to
  `repository-size-limit`, **the source blocks** (via flight-size).
  The source is paced by the slowest required receiver.
- Enables `repository-disk-write-delay` on disk Stores: if all ACKs
  arrive within the delay window, the message never hits disk —
  memory-Store performance on a disk-type repository.
- Also enables "ack on reception": Store ACKs stability immediately,
  before any receiver ACKs or any disk write. Faster stability at
  the cost of durability if the Store crashes before flush.
- Use when publishers can be paused (UI-driven, command streams,
  order entry).

Mode selection is opt-in on both sides: the Store must permit it
(`repository-allow-receiver-paced-persistence`), and the source must
request it (`ume_receiver_paced_persistence`). The Store cannot force
RPP onto a source. Same story for ack-on-reception.

Sizing: use the formulas in `store_config.md` §10. Don't guess.

## 12. RegIDs and Session IDs

Every source and every receiver has a **RegID** at each Store it's
registered with: a 32-bit integer identifying that specific source-
or-receiver instance to that specific Store. RegIDs are how a
restarted receiver is recognized as "the same receiver" and given
back its unacked messages.

### RegID problem

RegIDs must be unique per topic per Store. Two receivers registering
with the same RegID on the same topic corrupts ACK state. Managing
RegIDs across restarts/failovers manually is fiddly.

### Session IDs — the sane way

A **Session ID** is a 64-bit application-level identifier that
identifies an *app instance* to its Store. The app picks Session IDs
(usually per-context or per-process). The Store maintains an internal
map of `(topic, SessionID) → RegID`; re-registering with the same
Session ID gets the same RegID back automatically.

**Session ID is per-app, not per-stream.** A source and a receiver on
the same persisted stream have **different** Session IDs because
they are different apps. Within a Store, Session IDs must be unique
across the apps using it. A Session ID value reappearing on a
different device is harmless — each device's Store sees only the
apps on that device.

Strong default: use `ume_session_id_context` on the context and pass
RegID=0 everywhere. Manual RegID management is for specialized cases
(explicit RegID handoff between hosts, etc.).

### Activity timeout vs. state lifetime

Two distinct timers bound how long a Store remembers a registration:

- `source-activity-timeout` / `receiver-activity-timeout` — ms since
  last activity after which the RegID is **released** (available for
  reuse). If proxy sources are enabled, this is also when an
  election happens. If neither proxy sources nor a state-lifetime is
  set, state + cache are also deleted at this point.
- `source-state-lifetime` / `receiver-state-lifetime` — ms since last
  activity after which the Store deletes state + cache
  unconditionally. `0` = never.

Client-side `ume_activity_timeout` / `ume_state_lifetime` can
override per-source/per-receiver; the Store uses whichever is
**shorter** for state lifetime.

Pitfall: if a receiver is down longer than its state lifetime, its
unacked messages are gone; re-registration is treated as new and it
starts from current. Size state-lifetime to your longest acceptable
downtime.

## 13. Stability and flight

"Stable" = the Store has persisted the message and ACKed back to the
source. Until stability, the source considers the message **in
flight** and keeps a copy for retransmission.

### Flight-size limits

- `ume_flight_size` — max in-flight message count.
- `ume_flight_size_bytes` — max in-flight byte count. Required for
  RPP — it's how Store back-pressure propagates to the source.
- When the limit is hit, `lbm_src_send()` blocks or returns
  `LBM_EWOULDBLOCK` per `ume_flight_size_behavior`.

### Stability-ACK batching (Store → source)

- `stability-ack-minimum-number` — accumulate this many ACKs before
  sending. Default `1` (no batching).
- `stability-ack-interval` — max ms to hold a partial batch.

Batching saves network/CPU but delays the source's ability to
reclaim flight buffer. **Rule of thumb:** keep batch size strictly
less than the source's flight size, otherwise the source stalls
waiting for batches that fill only after the interval timer — "stop-
and-go" sending.

### Quorum/Consensus stability

If a source is configured with N Stores (a QC group), stability is
defined per-group:

- **Intra-group**: at least quorum (majority) of the group's Stores
  ACK.
- **Inter-group** (multi-group deployments): some/all groups reach
  intra-group stability.

Source reclaim and flight unblocking are tied to the configured
stability policy. `ume_message_stability_notification` fires the
app-visible stability event at the matching threshold.

## 14. Quorum/Consensus (QC) groups

A QC group is a set of independent Stores configured on the source as
peers. The source sends every message to every Store in the group;
stability is per-quorum. A group of N Stores tolerates `(N-1)/2`
failures.

- Typical size: 3 Stores (5 for very high HA).
- **Placement rule:** do not run multiple Stores of one QC group in
  the same `umestored` process or on the same host. Co-location
  defeats the redundancy QC is meant to provide.
- Multi-group persistence (source configured with several QC groups
  + inter-group stability policy) is an advanced pattern; one
  well-placed QC group is the common case.

## 15. Other Store concepts

### Store-side proxy sources (distinct from DRO proxy sources)

When the real source is silent for `source-activity-timeout`, the
Stores in a QC group elect one (`proxy-election-interval`
randomizes timing) to advertise the topic on the dead source's
behalf. The proxy keeps the topic discoverable so late-joining
receivers can register and recover; **it does not originate new
data**. Opt-in via `allow-proxy-source=1`. Tighten with
`proxy-source-repo-quorum-required=1` in real QC deployments.

This is **not** the same as a DRO-side proxy source (which bridges
TRDs for live forwarding). See `dro_details.md`.

### State vs cache, memory vs disk

A disk-type repository has two on-disk areas:

- `disk-state-directory` — small files: receiver positions, RegID
  mappings, sequence-number bookkeeping. Essential for restart
  correctness. Lightweight.
- `disk-cache-directory` — actual retained messages. Big. Capped by
  `repository-disk-file-size-limit`.

On Store restart, the cache restores into RAM up to
`repository-size-limit`. For large caches, the restore is slow;
`<restore-last>` (hours-based, relative to the *last message* in the
cache, not wall-clock) limits how much loads at startup. The first
restart after enabling it still does a full restore (index build);
subsequent restarts are fast.

Repository types:

- `memory` — RAM only. Fast, volatile.
- `disk` — disk-backed with a RAM cache; cold messages spill from
  RAM to disk when above `repository-size-threshold`.
- `reduced-fd`, `no-cache` — deprecated, don't use.

`repository-size-threshold` vs `repository-size-limit`:

- threshold = soft floor on RAM cache (memory repos: minimum
  retention; disk repos: how much hot RAM cache to keep).
- limit = hard cap on RAM cache.
- Disk capacity is separately capped by
  `repository-disk-file-size-limit`.

### Durable receivers — registration and recovery

Happy path:

1. Receiver sees the SRI (Source Registration Info) packet, learns
   Store address(es).
2. Receiver registers with Store(s) over TCP, supplying RegID=0 and a
   Session ID; gets back its RegID and starting seqno.
3. Store delivers any backlog the receiver hasn't ACKed (empty on
   first registration).
4. Receiver consumes messages and ACKs them back to the Store.

Restart path: same handshake, but step 3 produces a non-empty
backlog (everything since the last ACK, up to retention). The
receiver recovers from the Store, not the source.

ACK batching (receiver → Store):

- `ume_use_ack_batching` (default on) — receivers batch ACKs.
  Higher throughput, more duplicates after a crash (the Store didn't
  hear about recent consumption).
- `ume_explicit_ack_only` — app calls
  `lbm_msg_send_explicit_ack()` (C) / `LBMMessage.sendExplicitAck()`
  (Java) per message. Use when ACK must be coupled to a durable
  commit (e.g., a DB transaction): never ACK before the durable
  commit succeeds.

`receiver-new-registration-rollback` bounds how far back a
*re-registering* receiver receives history. The default
(2,147,483,647) effectively disables the bound. Lowering it violates
the persistence delivery guarantee — a receiver gone too long
silently skips messages. Only reduce if you deliberately want that.

### DRO-friendly persistence

When persistence crosses TRDs, a source in TRD-A wants to be findable
from TRD-B via a DRO, and its Store needs reachability too.
`context-name` on the Store lets the Store be referenced by logical
name rather than `address:port`, and the DRO propagates the name's
reachability across TRDs. See `dro_details.md` for the DRO side.

Note on `retransmission-request-forwarding`: some docs suggest
enabling it on DRO-connected Stores so requests the Store can't fill
get forwarded to the source. Rarely useful in practice — the source
retention buffer is sized for transport NAK recovery (seconds),
while Store repositories hold minutes to hours. If a message isn't
in the Store, odds it's still at the source are near zero. The
legitimate corner case is a just-restarted Store with an empty
cache; the better answer there is for the receiver to try the next
Store in the quorum. Treat this option as opt-in for a diagnosed
need.

## 16. Persistence terminology — use precisely

- **Registration** — a source/receiver registering its RegID with a
  Store. A receiver is only "persistent" if it has registered.
- **Session ID** — application-level identifier (64-bit) that lets UM
  manage RegID lifecycle on the app's behalf. Prefer to manual
  RegIDs.
- **Stable** — message has been persisted at the configured quorum
  and that fact has been ACKed back to the source. Not the same as
  "delivered to receiver."
- **In flight** — sent by the source but not yet stable.
- **Stability ACK** — Store → source: "I have this message."
- **Delivery confirmation** — receiver → source: "I consumed this
  message." Separate from stability ACK; optional; required for
  `ume_retention_unique_confirmations`.
- **Repository** — per-source retention area inside a Store
  instance. One source on one topic = one repository.
- **Proxy source (Store-side)** — Store-elected stand-in for a silent
  real source; advertises the topic only. Not a DRO proxy.
- **QC group** — set of Stores the source treats as peers for
  redundancy.

## 17. Persistence pitfalls

For the broader set of timer-pair traps that affect persistent and
non-persistent receivers alike (NAK storms, undetected loss, store
registration hangs, etc.), see `config_details.md` §11.

1. **RegID collisions.** Manual RegIDs across restarts/hosts without
   a discipline for uniqueness corrupts receiver state. Use Session
   IDs unless you know why you aren't.
2. **Flight-size blocking looks like a hang.** Under RPP or slow Store
   ACKs, the source blocks in `lbm_src_send()`. Check flight size,
   Store connectivity, and stability-ACK batching settings.
3. **Stability-ACK batch ≥ flight size.** Causes "stop-and-go"
   sending — source stalls waiting for a batch that finalizes only on
   the interval timer. Keep batch size < flight size.
4. **State lifetime shorter than expected downtime.** Returning
   receiver is treated as new, silently skips backlog. Size state-
   lifetime to bound the longest tolerable downtime.
5. **QC Stores colocated.** Multiple Stores of one QC group on one
   host or in one process defeats the redundancy.
6. **Disable `retransmission-request-forwarding` when using "mark
   stored message invalid"** — these features are explicitly
   incompatible.
7. **Restore-last on first startup.** The index isn't built yet; the
   first restart after enabling it still does a full restore.
8. **The Store doesn't create directories.** `disk-cache-directory`
   and `disk-state-directory` must already exist before the Store
   starts.
9. **Store registration hangs from too-low request maximums.** The
   shipped defaults for `ume_sri_request_maximum` and
   `transport_topic_sequence_number_info_request_maximum` violate
   the "request duration ≥ 2× transport activity timeout" rule and
   need to be roughly doubled for a UMP receiver. See
   `config_details.md` §11.
10. **RPP multi-second stability ACK delay.** Under RPP, stability
    ACKs can be delayed by many seconds due to an interaction between
    `ume_flight_size_bytes`, `repository-size-threshold`,
    `repository-size-limit`, `stability-ack-interval`, and
    `stability-ack-minimum-number`. If the source's in-flight byte
    count approaches the flight-size ceiling before the Store has
    issued an ACK batch (because the batch threshold hasn't been
    reached and the interval hasn't fired), the source stalls.
    Mitigations: ensure `stability-ack-minimum-number` is well below
    the effective flight-size message count; tune
    `stability-ack-interval` down; or widen the repository limits
    relative to the flight size so the source rarely reaches the
    ceiling. See `configuration_best_practices.md` §9.

## 18. Example apps — anti-patterns to avoid

The example programs that ship with UM (`lbmsrc`, `lbmrcv`,
`lbmreq`, `lbmresp`, `umesrc`, `umercv`, and kin) are API demos, not
reference implementations. Several patterns are fine for a 10-message
smoke test and wrong for anything heavier.

### Style

The shipped examples deviate from current best practices. When
writing fresh code, only follow the example conventions if the code
is intended to be integrated into the product. For new example
programs, ask whether modern coding styles should apply; if so, use
generally accepted naming and modularization.

### Threading boundary

In the default config the examples use, callbacks are serialized
against each other on the context thread but **not** against the
app's main thread. Any state shared between callbacks and main needs
synchronization. (See §7 for the exceptions: sequential mode, XSP.)

### Logging splices mid-line under unbuffered stdout

Stdio's per-FILE lock makes each `printf` call atomic — not each
"line." A helper that emits a hex-dump row via 17 separate `printf`
calls plus a trailing `printf("\t%s\n", textver)` lets another
thread's `printf("Sending response.\n")` land between bytes of the
dump row, producing spliced output:

```
00 00 00 00 00 00          Sending response. 1 response of 15 bytes (15 total bytes).
                     	......
```

`stdbuf -o0` makes the splice inevitable: fully unbuffered stdout
turns every printf into its own write syscall, so the per-FILE lock
is released between every byte. Test harnesses that anchor on
`^Sending response\.` will miss spliced instances and report phantom
mismatches.

Remember: **`stdbuf -o0` + multi-printf helper + any other thread
that prints = log corruption**.

### Callback-sets-global, main-polls-global is racy

A pattern in `lbmresp.c` and similar:

```c
/* in rcv_handle_msg, context thread */
lbm_msg_retain(msg);
response_msg = msg;
response = lbm_deserialize_response(...);

/* in main */
while (1) {
    SLEEP_MSEC(100);
    if (response != NULL) { /* use, then null both */ }
}
```

Problems:

- At >10 msg/s, the callback fires twice before main wakes up. The
  second call overwrites `response_msg` with a fresh
  `lbm_msg_retain`; the first retained message never gets
  `lbm_msg_delete`'d → leak. The first `response`'s reply is never
  sent → silent drop on the wire.
- No memory barrier between the callback's stores and main's loads.
  Works in practice on x86 with these specific types; not portable.

Correct shape: "one place processes a message" — either do the work
in the callback (if short and non-blocking) or hand off through a
real queue. A single shared pointer plus a sleep loop is not a
handoff mechanism.

### Request/response is asynchronous (see §8)

The receive callback should not block waiting for a response.
`lbmreq.java` follows the async pattern despite some superficially
blocking-looking output ("Sent request N. Pausing K seconds." — the
pause is to let responses arrive **on the context thread**, not
because send blocked).

## 19. Common error symptoms

### "I'm not receiving messages"

- Publisher and subscriber in the same TR domain? Check
  `resolver_service` / `resolver_unicast_daemon`, or
  multicast group/port.
- Topic name exact match? Topic names are case-sensitive.
- Subscriber created before publisher? Try a delay before sending.
- Firewall blocking UDP multicast? Try TCP.

### "Unrecoverable loss"

- Network overload — check rate-limit config and link utilization.
- Slow receiver / blocking callback — switch to event queue or
  optimize.
- Network infrastructure — packet loss at switch/router; multicast
  config.

### "High latency"

- Ordered delivery where arrival-order would suffice?
- Event queue overhead unnecessary?
- Rate-limiting too restrictive?
- TCP transport where multicast would work?

### "Application hangs"

- Callback calling a blocking UM API — use an event queue.
- Object create/delete order wrong.
- Blocking send with flight size exceeded (UMP) — check Store
  connectivity, flight-size config.

## 20. Best practices

Configuration:

- Use XML config files. Don't hardcode transport addresses.
- Don't guess option values; use `lbmopt.py` as the lookup (it
  handles all three source-file locations transparently).
- Always create attribute objects via `lbm_*_attr_create_from_xml()`
  (with a descriptive name, even just `""`), never the plain
  `lbm_*_attr_create()`. The non-`from_xml` form silently ignores
  XML defaults while still enforcing XML restrictions, which
  produces "I set the default in XML, why is it ignored *and* why
  am I being denied?" failures.
- Several option pairs are *interrelated* — set one without the
  other and you get NAK storms, false timeouts, or undetected loss.
  The recurring pattern is "timeout ≥ N × check interval."
  Specific pairs: see `config_details.md` §11.
- The shipped defaults for `ume_sri_request_maximum` and
  `transport_topic_sequence_number_info_request_maximum` are too
  low — they don't satisfy the request-duration ≥ 2× transport
  activity timeout rule. Double them when configuring a UMP
  receiver.
- Errors in flat-text and library XML config are *non-fatal*: UM
  logs and continues. Return value of `lbm_config()` is the only
  hint. Check it, and check the logger output, or typos go silent.
  (Daemon configs — Store, DRO — are strict and fail loudly.)

Error handling:

- Always check return values. `LBM_OK` (0) = success; `-1` = failure;
  `lbm_errmsg()` for details.
- Handle `LBM_MSG_UNRECOVERABLE_LOSS`. Log enough context to
  diagnose (topic, source).

Threading:

- Keep callbacks fast. Use event queues for I/O-bound work.
- Don't call most UM APIs from inside callbacks.
- Don't share UM objects across threads without synchronization.

Memory:

- Don't retain `lbm_msg_t*` past the callback without
  `lbm_msg_retain` / `promote`.
- Don't free `msg->data` (UM owns it).

Resource lifetime:

- Delete receivers before sources before contexts. Reverse order of
  creation.

Performance:

- One context per app, not thousands.
- Reuse sources; don't churn create/delete.
- Don't disable rate limiting without understanding the
  consequences.

Testing:

- Test with loss (unplug a cable, drop with iptables).
- Multiple subscribers, multiple publishers.
- Monitor stats.

## 21. Out of scope here

UMQ (queues), indexed queuing, ULB (ultra load balancing), and
"mark stored message invalid" are advanced features for specialized
deployments. If a task involves them, treat this doc as incomplete
and consult the primary UM docs:

- UMQ, indexed queuing, ULB: `lbm_repo/doc/UMQ/index.m4` (internal)
  or the UMQ pages under `lbm_doc/` (customer).
- Mark stored message invalid: `lbm_repo/doc/UME/index.m4` (internal)
  or the Persistence pages under `lbm_doc/` (customer).
