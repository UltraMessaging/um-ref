# Gotchas — surprising UM behaviors that don't fit anywhere else

The University of Hard Knocks file. Low-value most of the time; occasionally
saves an hour of source-diving.

Consult when:
- A UM behavior contradicts what the API surface implies.
- A customer says "it used to work; then I flipped one config knob and it
  broke."
- Something feels like it should be documented but isn't.

Each entry: symptom → why → what to tell the customer.

---

## Receiver-handle out-parameter may not be written before the first callback fires

**Keywords:** receiver handle NULL in callback, `*rcvp` not set, sanity check
fails, clientd receiver pointer, `use_hotlink` broke my code, hotlink footgun,
BOS fires before `lbm_rcv_create` returns, out-parameter race, receiver create
race, pointer written after callback, receiver variable not set, callback runs
during create, program-order bug in rcv_create, HF receiver ordering.

### Symptom

Customer stores the receiver handle in a `clientd` field for a sanity check:

```c
struct client_data { lbm_rcv_t *rcv; ... };
struct client_data cd;
lbm_rcv_create(&cd.rcv, ctx, topic, cb, &cd, NULL);
/* cb: assert(rcv == ((struct client_data*)clientd)->rcv); */
```

Compare fails on the very first callback (typically BOS). `cd.rcv` is NULL
when the callback runs. Often only surfaces after enabling `use_hotlink` — the
same code "worked" before the flag was flipped.

### Why

`lbm_rcv_create` can dispatch the first event **synchronously on the caller's
thread** when the source is already resolved (e.g., another receiver on the
same context is already joined to the same transport session and the source
is live). The two internal paths write the out-parameter at different points:

- **Plain receiver:** `*rcvp = rcv` is executed at `lbmrcv.c:2421` *before*
  the delivery-controller create and BOS dispatch, all inside one call
  (`lbm_rcv_create_internal_ex`). By the time BOS fires, the caller's variable
  is populated. Compare passes.
- **Hotlink receiver (`use_hotlink=1`):** `lbm_rcv_create` diverts to
  `lbm_hf_rcv_create` at `lbmrcv.c:2098`. That call runs the delivery-controller
  create (which synchronously dispatches BOS through
  `lbm_hf_rcv_handle_msg` → `lbm_hf_rcv_deliver_msg` → the user's proc), then
  returns. Only after it returns does the outer `lbm_rcv_create` execute
  `*rcvp = hfrcv_p->rcv` at `lbmrcv.c:2101`. So the callback runs while the
  caller's variable is still NULL.

The UM engineers were aware — `lbmhf.c:519` comment "Might be set when BOS is
delivered inside lbm_rcv_create_internal" — and defensively patch the
*internal* handle at `lbmhf.c:905`, but not the caller's clientd field.

### What to tell the customer

The receiver-handle out-parameter is **not guaranteed** to be written before
the first event is delivered. This isn't in the docs (as of UM 6.17.1); doc
bug filed. Applications must not read `*rcvp` (or a clientd field mirroring
it) from inside the callback. Use `msg->topic_name` or a discriminator set
before the create call to identify which receiver's callback is running.

The non-hotlink path's ordering is reliable in practice but not part of the
API contract. Code that works today under the plain-receiver path can start
failing silently when hotlinks are enabled later.

### Reproducer

`~/sford/Documents/Stuff/src/rcv_race/` — minimal C program that reproduces
the failure 10/10 runs with `use_hotlink=1` on a shared LBT-RM session. See
its `req.md` for the full source trace.

---

## Cross-edition daemon/library in one install (UMQ tnwgd + UMP liblbm, etc.)

**Keywords:** UMS, UMP, UMQ, edition, HAVE_UMQ, HAVE_BROKER, HAVE_UME,
liblbm.so build flags, tnwgd built against wrong edition, ABI mismatch,
struct layout, DWARF layout, `strings liblbm.so`, `strings tnwgd`,
`jenkins/builds/UMP`, `jenkins/builds/UMQ`, app built against UMQ runs on
UMP, opaque struct, `lbm_context_t` sizeof differs, walker phantom memory,
core-file analysis phantom bytes, gdb reads wrong offsets.

### Symptom

Two flavors:

1. **Diagnostic tooling reads garbage** from library-owned structs in a
   customer core — enormous phantom line items, "cannot access memory at
   0x<looks-like-ASCII>" errors, back-pointers that go the wrong way.
2. **A UM install directory contains binaries from more than one edition.**
   Example: `bin/tnwgd` reports "Ultra Messaging Gateway Version 6.17.1"
   but `strings tnwgd | grep jenkins/builds` shows `UMQ_6.17.1` paths,
   while `strings lib/liblbm.so.7 | grep jenkins/builds` shows
   `UMP_6.17.1` paths. Everything runs correctly; only tooling notices.

### Why

UM ships three editions built from three source trees, each defining
different `HAVE_*` macros:

- **UMS** — Ultra Messaging Streaming. Base pub/sub. No `HAVE_UMQ`, no
  `HAVE_BROKER`, no `HAVE_UME`.
- **UMP** — Ultra Messaging Persistence. Adds `HAVE_UME`. No `HAVE_UMQ`,
  no `HAVE_BROKER`.
- **UMQ** — Ultra Messaging Queuing. Adds `HAVE_UMQ` and `HAVE_BROKER`
  on top of UMP.

These macros gate conditional fields in several public-ish structs
(most notably `lbm_context_t`, which grows ~200 bytes between UMS and
UMQ builds). A binary compiled from one edition's source carries DWARF
that describes the structs with that edition's field set.

The `tnwgd` daemon is built once, from the UMQ source tree, because it
needs UMQ + broker API knowledge to be a general-purpose router. But
when a customer's install directory ships that same daemon alongside
`liblbm.so` from the *customer's licensed edition* (UMP or UMS), the
two objects describe the same type names with different byte layouts.
This is by design and it works fine at runtime: UM's compat rules
(most structs opaque to apps, visible ones only ever grow at the end,
library always allocates) mean the daemon never reads library-owned
fields directly. But debug tooling that resolves types via
`gdb.lookup_type("lbm_context_t")` gets whichever DWARF gdb hit first
— typically the executable's — and reads at the wrong offsets when
inspecting library-owned heap objects.

Failure mode is silent and dramatic. The wrong offset for the wrong
struct kind can produce arbitrary garbage: a 4-byte size field read
from the middle of a scalar can be ~2^32; a pointer field read from
inside a `char[]` can decode as ASCII on hexdump. Neither triggers
a segfault; the tool just reports fiction.

### What to tell the customer

For customer-facing diagnosis: nothing usually needed. This is a
supported configuration and the daemon runs correctly. Only bring
it up if the customer is (a) writing their own tooling that
inspects UM heap objects, or (b) trying to interpret output from a
tool that appears to be reporting wildly wrong numbers.

For internal tooling authors: resolve UM types through
`liblbm.so`'s DWARF specifically, not the executable's. In gdb
Python: locate the `gdb.Objfile` whose filename matches
`liblbm.so`, get a block anchored in one of its file-static
symbols (`evq_head` from `lbmev.c` is a reliable anchor), and
pass that block to `gdb.lookup_type(name, block=<block>)`. The
library's ABI is authoritative for the bytes at rest because UM
heap objects are always allocated and written by the library —
never by the app.

### Diagnostic

    strings <path>/bin/tnwgd    | grep -o 'jenkins/builds/[^/]*' | sort -u
    strings <path>/lib/liblbm.so* | grep -o 'jenkins/builds/[^/]*' | sort -u

The two commands report the edition each binary was built from
(`UMS_x.y.z`, `UMP_x.y.z`, `UMQ_x.y.z`). Mismatches are common and
benign; matched pairs are simplest for tooling.

---

## Losing all Stores from the SRI does not stop data delivery to the app callback

**Keywords:** SRI, Source Registration Information, all stores gone,
store removed from SRI, `LBM_MSG_UME_REGISTRATION_CHANGE`, persistence
receiver stops receiving, does UME receiver halt on stores gone,
`lbm_ume_rcv_ctlr_handle_updated_sris`, `num_ume_stores_ext`, quorum
lost, QC group all Stores down.

### Symptom

A persistent (UMP) receiver's Stores all disappear from the source's
SRI (e.g., a whole QC group goes down, or is deconfigured). Customer
asks whether the receiver stops invoking the application message/event
callback — i.e., whether losing persistence backing halts live data.

### Why

Live `LBM_MSG_DATA` delivery comes from the normal transport receive
path (`lbmrcvdc.c`), fed directly by the *source's* transport
(multicast/LBT-RU/TCP). That path is independent of Store registration
state. Store registration only governs recovery of backlog/gaps from
the Store, ACK/consumption tracking, and Store-directed retransmission
requests — not the live receive path.

When a new SRI drops a previously-active store,
`lbm_ume_rcv_ctlr_handle_updated_sris()` (`ume/umerctlr.c`) marks that
store `LBM_UME_RCV_STORE_STATE_INACTIVE` and calls
`lbm_rcv_delivery_ctlr_deliver_notification()` to deliver one
`LBM_MSG_UME_REGISTRATION_CHANGE` event per removed store (text:
`"source removed store %u"`). With all three Stores in a QC group
gone, the app gets three separate change notifications — not a single
"all stores gone" event, and not a callback shutdown.
`deliver_notification()` builds an `lbm_msg_t` and pushes it through
`LBM_RCVDC_DELIVER_RETURN` — the exact same delivery macro used for
data messages. It's an extra message multiplexed onto the same
callback, not a gate that suppresses it.

### What to tell the customer

No — the receiver keeps calling the application callback for live
data as long as the source itself is still up and sending. Losing all
Stores costs you durability guarantees (no recovery source for
gaps/backlog, no ACK persistence, no protection against losing unacked
messages across a receiver restart) — it does not stop live delivery.
Expect one `LBM_MSG_UME_REGISTRATION_CHANGE` notification per store
that drops out of the SRI.

One nuance: if this is a brand-new receiver whose very first SRI
already shows zero stores, it can never reach
`LBM_UME_RCV_CTLR_FLAG_REG_COMPLETE`, so it won't get a Store-driven
low-sequence-number/backlog recovery. That only affects recovery of
missed/historical messages, not live delivery going forward.

---

## Receive-side resolver cache accumulates advertisements from unsubscribed topics

**Keywords:** resolver cache growth, `lbm_topic_map_rcv`, receive-side
topic map, resolver_cache option, unsubscribed topics, memory growth
over time, long-running receiver process, why is my resolver map
so large, `res_rcvmap_tablesz`, topic advertisement accumulation.

### Symptom

A long-running UM process's memory grows over hours or days without
new receivers being created. In a core file, `lbm_topic_map_rcv` and
its bucket chains dominate the receive-side context's memory.
Especially prominent in processes that hear advertisements from many
sources on shared TR groups.

### Why

The receive-side topic-resolution cache records every source
advertisement the context hears, regardless of whether the context
has a receiver for that topic. Entries serve fast receiver-creation
lookup and wildcard-pattern matching. There is one opportunistic
eviction path: when a receiver joined to a transport session sees
that session close, UM removes the topic's cache entry, and a new
resolver query typically repopulates it with only currently-active
sources. Absent that trigger — most notably for topics with no local
receiver — entries stick for the process lifetime.

`resolver_cache = 0` disables the cache and eliminates this growth,
but breaks wildcard receivers (they depend on the cache to match
incoming advertisements against patterns). Almost never the right
choice in practice.

### Diagnostic

In `um-walk --tree` output, look at each context's "Other context
memory" section for `lbm_topic_map_rcv.table[]` and its bucket
nodes. Baseline is ~1 MB per receive-context (default
`res_rcvmap_tablesz = 131111` × 8-byte pointers); growth well
beyond that is accumulated advertisements, not receiver state.

---

## `lbm_msgs_rcved` in receiver transport stats is per-session, not per-topic — and TSNIs don't count toward it

**Keywords:** lbm_rcv_retrieve_transport_stats, lbm_rcv_transport_stats_t,
lbm_rcv_transport_stats_lbtrm_t, lbm_msgs_rcved, msgs_rcved, two counters
same name, TSNI, transport_topic_sequence_number_info_interval, per-topic
message count doesn't match, transport session stats, lost TSNI, NAK
timeout on control packet, demux stats, lbtrm_rcv_t stats.

### Symptom

Customer calls `lbm_rcv_retrieve_transport_stats()` for one topic expecting
a per-topic message count, but the returned `lbm_msgs_rcved` is inflated
(includes other topics) or doesn't reconcile with a hand count of received
application messages once TSNIs and loss are in play.

### Why

`lbm_rcv_transport_stats_lbtrm_t` (and the TCP/LBT-RU/LBT-IPC/LBT-RDMA
analogs) has **two** confusingly-similar counters:

- `msgs_rcved` (top of the struct) — raw datagram count at the transport
  layer. For LBT-RM, incremented in `lbtrm_rcv_handle_data()` /
  `_handle_new_data()` / `_handle_old_data()` (`lbtrm/lbtrmrcv.c`) for every
  DATA packet received, regardless of its LBMC content.
- `lbm_msgs_rcved` (further down) — copied from `demux->stats.msgs_rcved`,
  incremented once per LBMC message in `lbm_rcv_demux_fetch_rcv()`
  (`lbmrcv.c:1290`), *before* the per-topic lookup.

Both are counted **per transport session** (`lbm_rcv_demux_t`), i.e. per
source transport-type+address — not per topic. Many topics can share one
session, so querying stats for topic A returns the whole session's count,
including traffic for every other topic riding the same session.

TSNI keepalive packets
(`transport_topic_sequence_number_info_interval`) make this worse: they're
queued through the normal source send path (`lbm_imbq_send`), so on the
wire they're ordinary LBT-RM DATA datagrams — they *do* increment the
transport-layer `msgs_rcved`/`bytes_rcved`. But on receive they're
dispatched via the LBMC **control** path (`lbm_rcv_demux_handle_cntl` →
`lbm_rcv_delivery_ctlr_handle_tsni`), never through `fetch_rcv` — so they
do **not** increment `lbm_msgs_rcved`, `lbm_msgs_no_topic_rcved`, or
`lbm_reqs_rcved`. If a TSNI datagram is lost and its NAK cycle times out,
the ordinary transport-level loss counters (`lost`, `nak_pckts_sent`,
`naks_sent`, then `unrecovered_tmo` or `unrecovered_txw`) increment exactly
as they would for a lost data message — nothing in the stats distinguishes
a lost TSNI from lost application data.

### What to tell the customer

- `lbm_msgs_rcved` (and its transport-layer sibling `msgs_rcved`) are
  session-wide, not per-topic. Get per-topic counts by counting in the
  application's receive callback, not from transport stats.
- Don't expect `lbm_msgs_rcved` to reconcile with a hand count of data
  callbacks when TSNIs are enabled — TSNI traffic inflates the raw
  datagram `msgs_rcved`/`bytes_rcved` and the loss/NAK counters, but never
  touches `lbm_msgs_rcved` itself.
- A spike in `lost`/`nak_pckts_sent`/`unrecovered_tmo` with no matching
  rise in `lbm_msgs_no_topic_rcved` or application-visible loss doesn't
  rule out real message loss — it's equally consistent with lost TSNI
  keepalives on an idle topic, which are invisible to the app by design.

---

## Putting UM's lib directory on `LD_LIBRARY_PATH` can break unrelated tools (`ssh`, `su`) after upgrading past UM 6.13

**Keywords:** libssl.so.1.1 collision, libcrypto.so.1.1 collision, ssh
symbol lookup error, su broken after UM upgrade, undefined symbol
EVP_KDF_ctrl, OPENSSL_1_1_1b, libk5crypto.so.3, LD_LIBRARY_PATH openssl
conflict, SONAME collision, use_tls dlopen, OpenSSL optional dependency,
openssldependency, upgrading UM 6.10 to 6.17 breaks shell scripts.

### Symptom

Customer's application start scripts `export LD_LIBRARY_PATH=<UM lib
dir>:...` so the app can find UM's shared libraries. After upgrading from
UM 6.10/6.12 to 6.13.1+ (e.g. 6.17), any `ssh` or `su` invoked later in the
same shell starts failing:

```
ssh: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b
```

Nothing about the customer's application changed — only the UM version.

### Why

UM's OpenSSL usage is `dlopen()`-based, not linked at build time (fixed in
6.12.1 — see `\ref openssldependency` in the Design guide, and
`lbm_openssl_load()` / `lbm_ssl_init()` in
`src/lib/lbm/security/lbmopensslload.c` / `lbmssl.c`). `lbm_ssl_init()` is
called unconditionally from `lbm_init()` (`lbmctx.c`), so every process
that creates a context attempts to `dlopen()` OpenSSL — but a failed
attempt just sets an internal error state and is otherwise silent; it only
surfaces if the app later calls `use_tls`.

UM bundles its own `libssl`/`libcrypto` next to `liblbm`. Through UM 6.12,
that was OpenSSL **1.0.x**, whose SONAME (`libssl.so.1.0.0`) doesn't match
a modern system OpenSSL's (`libssl.so.1.1`), so having UM's lib dir on
`LD_LIBRARY_PATH` was harmless for other tools — the loader never confused
the two. Starting with **UM 6.13.1**, UM upgraded its bundled OpenSSL to
**1.1.1g** (confirmed still the version in 6.17.1 installs — no further
version bump found in the changelog or in installed binaries), which
shares its SONAME (`libssl.so.1.1`/`libcrypto.so.1.1`) with the system's.
With UM's lib dir on `LD_LIBRARY_PATH`, any process exec'd later in that
shell — `ssh`, `su`, anything dynamically linked against
`libcrypto.so.1.1` — now resolves against **UM's copy** instead of the
system's.

The specific symptom (`EVP_KDF_ctrl` / `OPENSSL_1_1_1b`) is sharper still:
that symbol is a RHEL/CentOS-specific downstream patch to OpenSSL (added
so `libk5crypto`/Kerberos GSSAPI can use it), not part of upstream OpenSSL.
UM's bundled `libcrypto.so.1.1` is built from stock upstream OpenSSL
source and will **never** export it, at any 1.1.1 patch level — so this
isn't fixable by shipping a newer UM-bundled OpenSSL, only by keeping
UM's copy out of the search path for non-UM processes.

The reverse direction also matters: if UM's lib dir is placed *last* on
`LD_LIBRARY_PATH` (e.g. to avoid the above), and an earlier directory in
the path provides an unversioned `libssl.so`/`libcrypto.so` symlink (from
`openssl-devel` or similar) pointing at a **different major version**
(e.g. system OpenSSL 3.x), UM's own `use_tls` will load that instead of
its bundled 1.1.1g — an untested combination. UM's `dlopen()` call uses
the literal unversioned filename `libssl.so`/`libcrypto.so`
(`LBM_OPENSSL_LIBNAME`/`LBM_CRYPTO_LIBNAME` in `lbmopenssl.h`), not the
versioned SONAME, so ordinary SONAME-based dynamic-linking reasoning
doesn't apply — whichever directory earliest in the search path has that
exact unversioned filename wins, regardless of version compatibility.

### What to tell the customer

- Scope `LD_LIBRARY_PATH` to just the UM-linked process invocation (env
  prefix or wrapper), not the whole script — don't export it for the
  remainder of a script that later calls `ssh`/`su`/other system tools.
- Removing UM's bundled `libssl`/`libcrypto` entirely and relying on the
  system's is supported behavior since UM 6.12.1 (run-time `dlopen`, not a
  hard link) — safe with zero functional impact if the app doesn't use
  `use_tls` (or UMM's optional secure daemon communication; compression
  uses LZ4 and is unrelated to OpenSSL).
- If the app does use `use_tls` and relies on system OpenSSL: verify an
  *unversioned* `libssl.so`/`libcrypto.so` symlink actually resolves in
  UM's search path (often only present via `-devel` packages), and verify
  which library actually got loaded (`strace -e trace=open,openat` on the
  UM process, or `lsof -p <pid> | grep ssl`) rather than assuming
  `LD_LIBRARY_PATH` ordering did what was intended — don't reason about it
  as if it were a normal SONAME-based link.

---

## A CPU-starved Store can stall every source that persists to it — and the receiver has no way to detect it

**Keywords:** persistent receiver stall, all sources froze
simultaneously, Store CPU exhaustion, Store IO storm, half-open TCP
connection, SO_KEEPALIVE not configured on receiver,
transport_tcp_activity_method, ume_store_activity_timeout, Store
offline declaration doesn't close socket, slowest consumer bounds
transport, monolithic TCP transport, SRI only on data transport,
receiver has no Store liveness mechanism, manual client bounce
required, Core-5688-1882 on Store, context thread delay on
umestored.

### Symptom

A persistent receiver stops receiving from **all** (or nearly all) of
its active sources at the same instant, and stays frozen until it is
manually restarted — UM never recovers on its own, even though the
sources themselves are healthy and still sending. The common factor
across the frozen sources is that they all persist to the same Store,
and that Store was under heavy CPU/IO load (e.g. `Core-5688-1882`
context-thread-delay warnings of tens of seconds, `sar` showing
`%idle` near 0 / `%iowait` and `%system` spiking) at the moment of the
freeze.

### Why

This is a chain of individually-reasonable behaviors that combine
badly:

1. The Store's context thread stalls under CPU/IO starvation (the
   same `Core-5688-1882` mechanism as `context_thread_internals.md`,
   just triggered by OS-level resource exhaustion rather than an app
   thread holding `ctx->lock`). While stalled, it stops reading off
   its TCP sockets — including the connections to every source
   persisting to it.
2. **A Store counts as a consumer on a TCP source's single,
   monolithic transport** (SKILL.md §10). The source can only publish
   as fast as its slowest consumer drains its socket. With the Store
   not draining, the *entire transport* backs up — every receiver on
   that source stalls too, not just the Store's copy. If many
   independent sources all persist to the same overloaded Store, they
   all stall in lockstep — looking like a coordinated multi-source
   freeze when it's really one shared slow consumer.
3. Each source's app-level `ume_store_activity_timeout` (default
   10,000 ms) fires and the source declares the Store "offline." **This
   declaration does not touch the underlying TCP socket.** The source
   doesn't track which physical TCP connection belongs to which Store
   at the socket-teardown level — declaring a Store dead is bookkeeping
   only. The connection stays open (and the transport stays backed up)
   until something actually closes it at the OS level.
4. The only thing that closes that stuck socket is an actual
   `SO_KEEPALIVE` probe failure — governed by
   `transport_tcp_activity_method`/`transport_tcp_activity_timeout` at
   **source** scope, nominally the configured timeout but documented
   as able to run "more than a factor of 2" longer in practice. If
   `SO_KEEPALIVE` isn't configured at all (method `"timer"`,
   timeout `0` — the UM default), nothing ever closes it, and the
   stall is permanent until manual intervention.
5. Meanwhile the **receiver** has no independent way to notice any of
   this. It doesn't track Store liveness itself — it only knows about
   Stores via SRI messages from the source (§15), which travel
   exclusively over the same source→receiver data transport that just
   went stale. If that transport is itself a plain TCP connection with
   no `SO_KEEPALIVE`/timer activity detection configured on the
   **receiver** side either, the receiver has literally zero signal
   that anything is wrong — no closed socket, no EOS, no updated SRI.
   It just sits there, indefinitely, until something external (a
   manual bounce) intervenes.

Confirmed in one SR: the Store's own context-thread delay recovered
within seconds of the CPU storm ending, but the receiver stayed frozen
for several more hours until manually restarted — consistent with the
Store-side symptom and the receiver-side stall being two different
things, connected only by the (never-torn-down) socket.

### What to tell the customer

- Configure `SO_KEEPALIVE` (`transport_tcp_activity_method` +
  a non-zero `transport_tcp_activity_timeout`) on **both** scopes —
  source and receiver — for any TCP-transport persistent deployment.
  A source-only setting (common, since it's the side people think to
  tune for Store connectivity) still leaves the receiver with no way
  to detect a half-open connection to a source.
- Don't assume `ume_store_activity_timeout` firing means the stuck
  connection is cleared — it's an app-level bookkeeping declaration,
  not a socket close. The actual recovery time bound is the
  `SO_KEEPALIVE` timeout (which can run well over its configured
  value), not the (typically much shorter) activity-timeout value.
- Investigate Store-host CPU/IO health (`sar`, `Core-5688-1882` counts
  in the Store's own log) whenever multiple independent sources on a
  persistent receiver freeze at the same instant — a shared overloaded
  Store is a strong explanation for an otherwise-mysterious
  simultaneous multi-source stall, and doesn't require any single
  source or the receiver itself to be misbehaving.
- Per-Store-process `Core-5688-1882` accounting must be split by
  context-thread-id when a process hosts more than one Store instance
  (each runs its own context thread) — summing delay-seconds across
  threads before comparing against a wall-clock window produces
  misleading totals. See `um-sr-analysis`'s `context_thread_internals.md`.

---

## A DRO relaying route-info through an older-version peer silently drops `ROUTE_INFO_NBR_EXT` (route-group neighbor data)

**Keywords:** DRO route info duplicate, second route announcement missing
metadata, ROUTE_INFO_NBR_EXT missing, route groups not propagating,
tnwg_rm_propagate_lsinfo, stripped neighbor extension, mixed-version DRO
mesh, UM 6.16 DRO relaying 6.17 route info, route group filtering not
working across gateways, two copies of same gateway announcement one
portal.

### Symptom

A debug/packet capture on a DRO shows **two copies** of the same
link-state announcement (same originating `node_id`/`gateway_name`,
same or adjacent `sqn`) arriving on the identical portal — one carrying
the `ROUTE_INFO_NBR_EXT` option (route-group-per-neighbor data), one
without it. Symptoms downstream: route-group-based neighbor filtering
(`tnwg_rm_should_ignore_neighbor`) behaves inconsistently depending on
which copy a given DRO ends up using, because a copy with no
`ROUTE_INFO_NBR_EXT` is treated as "this neighbor has no route groups,"
not "unknown."

### Why

Confirmed by diffing the actual source trees side by side
(`UM_6.16/29West/lbm/src/gateway/tnwgrm.c` vs
`UM_6.17.2/29West/lbm/src/gateway/tnwgrm.c`,
`src/lib/lbm/lbmc.h`):

- `LBMC_CNTL_ROUTE_INFO_NBR_EXT_OPT` does not exist at all in UM 6.16's
  `lbmc.h`. It was added later; in 6.17.2 it even shows the scar tissue of
  that addition — `lbmc.h:393` has a commented-out earlier definition
  reusing `UME_STORE_DOMAIN_OPT`'s bit value before being moved to
  `0x2000`.
- In 6.16, `tnwg_rm_propagate_lsinfo()` (`tnwgrm.c:776-799`) only ever
  sets `ROUTE_INFO`, `ROUTE_INFO_NEIGHBOR`, and `GATEWAY_NAME` on the
  outgoing control message. There is no `route_info_nbr_ext` field and no
  code path that could carry it.
- In 6.17.x, `tnwg_rm_propagate_lsinfo()` (`tnwgrm.c:878-903`) *always*
  sets `ROUTE_INFO_NBR_EXT` and copies `lsinfo->route_info_nbr_ext` on
  every propagate call — it never conditionally strips the option itself.
  The ingest side, `tnwg_rm_enqueue_link_state_info()` (`tnwgrm.c:436-463`),
  only copies the incoming NBR_EXT data if the *received* wire message had
  the option set (`LBMC_CNTL_MSG_PTR_INFO_FLAG_CHECK(info,
  LBMC_CNTL_ROUTE_INFO_NBR_EXT_OPT)` at line 453); otherwise
  `lsinfo->route_info_nbr_ext` is left zeroed from the `memset` at line
  444, with no fatal assert (unlike `ROUTE_INFO`/`ROUTE_INFO_NEIGHBOR`/
  `GATEWAY_NAME`, which *are* asserted present).

So in a mesh with a mix of 6.16 and 6.17.x DROs: a 6.17.x originator sends
link-state with `ROUTE_INFO_NBR_EXT` set. A 6.16 DRO relaying that
announcement onward has no code that even recognizes the option — its
relayed copy legitimately omits it, because the 6.16 binary doesn't know
it exists. A separate copy of the same announcement that only ever
transited 6.17.x hops keeps the option intact. If the topology has more
than one path between the originator and an observing portal, both
copies can land on it — looking like one DRO is "stripping metadata" when
really it's just an older binary that predates the feature. (Also worth
checking: `tnwg_peer_connection_send_capabilities_timer_cb` in
`tnwgpeer.c` sends a structurally different, deliberately NBR_EXT-less
`GatewayControl` message — `ROUTE_INFO_NEIGHBOR` + `GATEWAY_NAME` +
`TNWG_CAPABILITIES`, no `ROUTE_INFO` at all — once per peer-link
connect/reconnect. A generic capture filter that just looks for "carries
this gateway's neighbor data" can mistake *that* handshake message for a
stripped duplicate of the real flooded announcement too; the receive-side
dispatch (`tnwgpeer.c:2705` vs `:2741`) treats them as unrelated message
classes.)

### What to tell the customer

- Route-group filtering between gateways (`ROUTE_INFO_NBR_EXT`) requires
  **every DRO on every path** between the gateways using route groups to
  be UM 6.17+ (first version carrying the option) — a single older DRO
  anywhere on an alternate path will emit a legitimate, NBR_EXT-less copy
  of the announcement when it relays link-state.
- Treat this as expected version-skew behavior, not a bug: `ROUTE_INFO`
  present but `ROUTE_INFO_NBR_EXT` absent on a relayed message is
  consistent with that hop being pre-6.17, not with a bug in
  `tnwg_rm_propagate_lsinfo` (which, on 6.17+, never conditionally
  strips the option itself — it either doesn't exist yet on the relaying
  binary, or it's always included).
- Before concluding this is the cause, confirm the DRO version at each
  hop (`tnwgd -v` / version string in its startup log) and that the
  topology actually has more than one path to the portal where both
  copies were observed.
- Don't confuse this with the per-connection capabilities handshake
  message noted above — that one never carries `ROUTE_INFO`/`sqn`/
  `vers` at all, so it's not really "the same announcement," just
  easy to conflate with it in a raw capture.

---

## `umestored` (or UMDS server) crashes at startup on glibc 2.34+, empty log

**Keywords:** umestored, Store, UMDS, segfault, core dumped, crash at
startup, empty store.log, SmartHeap, libsmartheap_smp64.so, glibc 2.34,
RHEL 9, EBF, UM_Glibc_2.34.

### Symptom

The Store (`umestored`) segfaults during initialization and its log file is
empty (the shell reports `Segmentation fault`). The same applies to the UMDS
server. Check this first; it is the first thing to rule out when a Store dies
with nothing in its log.

### Why

The Store and UMDS server link "SmartHeap" (`libsmartheap_smp64.so`), a
malloc/free replacement. glibc 2.34 and later (Red Hat Linux 9 and above,
CentOS Stream 9) requires any malloc replacement to provide additional APIs.
The SmartHeap shipped with older UM releases lacks them. The EBF's README
says the SmartHeap shipped with versions before 6.17 lacks them (and that
the EBF applies to any 6.x version). But a UM 6.17 install (January 2025
build) was seen still carrying the 2018 library, so check the library file
(size and date, below), not the UM version. Confirm the host with
`ldd --version` (2.34 or later means it applies).

### Fix

Apply the "UM_Glibc_2.34" EBF (EBF = Emergency Bug Fix: a patch sent to
customers to fix a bug; most EBFs are simply a build of the full UM product,
but this one is a single replacement library). It works for any 6.x version
of UMP, UMQ or UMDS. In the UM install, find `libsmartheap_smp64.so` (under
`Linux-glibc-2.17-x86_64/lib`), rename it to `libsmartheap_smp64.so.old`
(`mv -n`), and copy the EBF's `libsmartheap_smp64.so` in its place.

Internal (lab): the EBF is at `/29W/Amun/home/Morgue/SPECIAL_EBF/UM_Glibc_2.34`
(contains `README.txt` and the `.so`), reachable from every lab host. (The
`/proj/Morgue/...` path doesn't exist on `hal`.) Customers get it from UM
support as `UM_Glibc_2.34.tz`. Replace the library in the install the test
actually uses. The install is shared across hosts via NFS, but one
replacement does not cover them all: the EBF library fails on glibc older
than 2.34 (see below), so a shared install can't serve both old- and
new-glibc hosts with a single copy.

### Telling the two mismatches apart

The Store needs the SmartHeap that matches the host's glibc. Both
mismatches fail, but differently (observed 2026-10-20, UM 6.17):

| Library on host | Symptom |
|---|---|
| Old library (2018, 100639 bytes) on glibc 2.34+ (hal) | Silent segfault, exit 139, empty log |
| EBF library (Jan 2024, 113000 bytes) on glibc < 2.34 (zeus, 2.28) | Loader error, exit 1: `version 'GLIBC_2.34' not found (required by libsmartheap_smp64.so)` |

A silent crash means the old library is on a new glibc. A `GLIBC_2.34 not
found` message means the EBF library is on an old glibc. Check with
`ldd --version` and the library's size and date. The same applies in
containers, where the image's glibc decides, not the host's.

Without changing a shared install, put a directory holding the right
library first on `LD_LIBRARY_PATH` (the binaries have no RPATH), chosen by
glibc version in `lbm.sh`.

If running `umestored` in WSL, the same rules apply: check `ldd --version`
and `scp` the EBF's `.so` from the lab as needed.

---

## UM's bundled OpenSSL on `LD_LIBRARY_PATH` breaks system tools

**Keywords:** LD_LIBRARY_PATH, libssl.so.1.1, libcrypto.so.1.1, OpenSSL,
curl, git, ssh, wget, symbol lookup error, undefined symbol,
`EVP_KDF_ctrl`, `OPENSSL_1_1_1b`, libk5crypto, UM encryption, TLS, lbm.sh.

### Symptom

After `export LD_LIBRARY_PATH=$LBM/lib` (the usual way to make UM
programs find `liblbm.so`), unrelated system tools fail on startup,
e.g.:

    curl: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b

Whether a given tool breaks depends on how the OS built it, so one tool
can fail while a similar one works (seen on a RHEL-family host: `curl`
failed, `wget` worked).

### Why

The UM `lib/` directory ships its own `libssl.so*` and `libcrypto.so*`.
With that directory on `LD_LIBRARY_PATH`, every dynamically linked
program prefers UM's copies over the system's, and system libraries
built against a different OpenSSL fail symbol lookup. UM binaries and
libraries have no RPATH/RUNPATH, and the UM-supplied `SRS` and `MCS`
wrapper scripts don't set a library path, so UM relies on the caller
to set `LD_LIBRARY_PATH`.

UM uses these OpenSSL libraries only for its encryption (TLS) feature,
and it loads them manually at runtime, not as a link-time dependency.
If encryption isn't configured, the libraries don't need to be present.
As far as Informatica knows, no UM customer uses the encryption feature.

### What to tell the customer

- Simplest fix, if they don't use UM encryption: delete `libssl.so*` and
  `libcrypto.so*` from the UM `lib/` directory. UM runs fine without
  them.
- Otherwise, don't export `LD_LIBRARY_PATH=$LBM/lib` in a login shell.
  Set it only for UM processes (per-command prefix or a wrapper
  script), or clear it for the tool that breaks
  (`env -u LD_LIBRARY_PATH curl ...`).

---

## XML config: interface values in templates are validated in every process

**Keywords:** `Core-11187-1`, `Core-11187-2`, `Core-5688-4085`, no interfaces
matching criteria, error parsing application name, `default_interface` error,
shared XML file across hosts, network namespaces, XML template interface,
wrong host's interface, multi-host um.xml.

### Symptom

A process that loads an XML config logs errors such as:

```
Core-11187-1: Error parsing line 26 attribute name 'default_interface' - ignoring.
Core-11187-2: Default value '10.201.1.0/24' invalid: CoreApi-5688-4101: no interfaces matching criteria.
Core-5688-4085: error parsing application name 'resp' (set via ENV var)
```

The interface named belongs to a template that this application doesn't
use. It is meant for another process, on another host or in another network
namespace.

### Why

When a process loads the XML file, it validates the interface options in
**every template** in the file, not just the templates its own application
uses. A value naming an interface the process can't see fails validation.
That option is dropped, and `Core-5688-4085` is logged for the process's
application. Despite that message, the rest of the application's
configuration still applies. Interface options inside **other applications'**
`<context>` elements are not validated at all.

Verified on UM 6.17 (hal, 2026-10-15). A test program with
`LBM_XML_CONFIG_APPNAME=good` and an XML template setting a nonexistent
`default_interface` logged all three messages, whether or not any
application used that template and wherever it appeared in the file. The
program still got its own template's `request_tcp_port_low`. The same
nonexistent interface inside another application's `<context>` options
logged nothing.

### What to tell the customer

- The errors are noise if the template isn't used by that process, but
  they hide real errors, so restructure rather than ignore them.
- Keep per-host interface options out of shared templates. Put them in the
  owning application's `<context>` options, or use one XML file per host.
- A process whose *own* template has a bad interface value silently falls
  back to the default interface for that option.

---

## `tnwgd` fails if `LBM_XML_CONFIG_FILENAME` is set and `dro.xml` has `<xml-config>`

**Keywords:** `CoreApi-9310-1`, XML configuration has already been loaded,
DRO won't start, tnwgd XML twice, `LBM_XML_CONFIG_FILENAME` exported, DRO
`<xml-config>`.

### Symptom

`tnwgd` exits at startup with:

```
error processing XML configuration file: [CoreApi-9310-1: XML configuration has already been loaded.]
```

### Why

The UM library loads the file named by `LBM_XML_CONFIG_FILENAME` when it
initializes. The DRO then tries to load the file named by its own
`<daemon><xml-config>` element, and the library refuses a second XML load.
Observed on UM 6.17, typically when a test script exports the variable for
its applications and the DRO inherits it.

### What to tell the customer

Don't set `LBM_XML_CONFIG_FILENAME` in `tnwgd`'s environment; give the DRO
its XML file only through `<xml-config>`. In scripts, pass the variable on
each application's command line (`env LBM_XML_CONFIG_FILENAME=... app`)
instead of exporting it.

---

## `lbmrespq` quits when any requester goes away

**Keywords:** `lbmrespq` exits, responder quits, End of Transport Session,
EOS, request/response example, DRO proxy source.

### Symptom

A test using the stock `lbmrespq` as responder stops answering after the
first requester exits. Its log ends with `End of Transport Session` and
`Quitting`.

### Why

`lbmrespq`'s receive callback deletes the receiver and unblocks its event
loop on the first `LBM_MSG_EOS`. Through a DRO, each requester's source is
a separate proxy source, so the first requester to exit produces an EOS.
Observed on UM 6.17.

### What to tell the customer

It's example behavior, not a library one. For tests with requesters that
come and go, use a copy of `lbmrespq` that logs EOS without quitting.

---

## A DRO's proxy sources apply implicit batching

**Keywords:** request latency 200 ms, DRO latency, implicit batching,
`implicit_batching_minimum_length`, `implicit_batching_interval`, proxy
source.

### Symptom

Small messages (for example, requests) take about 200 ms more through a
DRO than their sender's own flushing would suggest; round trips of a few
ms become 200 to 400 ms.

### Why

Messages wait up to `implicit_batching_interval` (default 200 ms) in each
source that batches: the sending application's, and again the DRO's proxy
source when it forwards them. `LBM_MSG_FLUSH` in the application removes
only the first. The DRO's proxy sources take source options from the
portal context's XML configuration. Observed on UM 6.17, for a small
request and a 1.5 MB response through one DRO: 410 ms round trip with
defaults, 210 ms with the request flushed, 10 ms with
`implicit_batching_minimum_length` 1 in the application and the DRO.

### What to tell the customer

Most deployments set `implicit_batching_minimum_length` to 1 for both
applications and DROs. Set it in the DRO's XML configuration (the
portals' contexts) as well as in the applications.

---

## DRO endpoint "sent" statistics count queued UIMs

**Keywords:** `unicastMsgBytesSent`, `unicast_msg_bytes_sent`, DRO
endpoint portal stats, UIM queue, DRO memory growth, OOM, backlog not
visible.

### Symptom

A DRO's memory grows while its endpoint portal statistics show UIMs
(including responses) sent as fast as they arrive.

### Why

When a DRO forwards a UIM out of an endpoint portal, it queues it on the
UM library's TCP connection to the destination with no size limit, and
counts it as sent at that point. Observed on UM 6.17: the endpoint portal's
`unicastMsgBytesSent` equaled the bytes received from the other portal
(4,937 MB) while about 1,900 MB was still queued in the DRO, matching its
`mallocInfo` memory in use.

### What to tell the customer

The endpoint statistics don't show the UIM backlog. Watch the DRO's
process memory, or `mallocInfo` in its monitoring data
(`uordblks` + `hblkhd` is memory in use; RSS stays high after memory is
freed).

---

## Each DRO portal creates an LBT-RM source on the default multicast group

**Keywords:** DRO LBT-RM source, 224.10.10.21, unexpected multicast,
`transport_lbtrm_multicast_address`, DRO portal source context.

### Symptom

DRO monitoring shows a source transport like
`LBTRM:<portal address>:14390:...:224.10.10.21:14401` in each portal's
source context, even though the configuration sets `transport` to `tcp`
and no application source uses LBT-RM.

### Why

Each portal creates it at startup, before any proxy source exists; the
proxy sources themselves use the configured transport. Its purpose
wasn't investigated (observed on UM 6.17). It uses the default LBT-RM
multicast address unless the portal's configuration overrides it.

### What to tell the customer

It isn't the data path. On networks where the default multicast group is
in use or filtered, set the LBT-RM address options for the DRO's portal
contexts.
