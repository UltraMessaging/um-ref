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
