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
the EBF applies to any 6.x version). Confirm the host with `ldd --version`
(2.34 or later means it applies).

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
actually uses; the install is shared across hosts via NFS, so one replacement
covers them all.

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
