---
name: fragmentation-details
description: Message fragmentation and datagram sizing on the send path — the APDU concept (apdu / raw_apdu / frag_mtu), how dynamic_fragmentation_reduction makes the APDU dynamic per-message, MTU/header math for 1472, and why the LBM_DEBUG_NET "APDU" log line is misleading under DFR. Read when tuning datagram_max_size to avoid IP fragmentation, or diagnosing why messages fragment sooner than expected.
metadata:
  type: reference
---

# Message Fragmentation and the APDU

UM treats application payloads as opaque byte arrays and will fragment
a message that is too large to fit in a single transport datagram,
reassembling it transparently on the receiver. This file explains how
the send path decides *whether* to fragment and *what chunk size* to
use, the internal "APDU" concept that drives that decision, and how the
`dynamic_fragmentation_reduction` option changes it.

Source: `src/lib/lbm/lbmsrc.c` (send path), `src/lib/lbm/lbmc.c`
(header sizing), `src/lib/lbm/lbtrm/lbtrm.h` (per-transport macros).
Config option: `dynamic_fragmentation_reduction` (context scope,
default 0) — look up with `lbmopt.py`.

---

## 1. What "APDU" means

**APDU (Application Protocol Data Unit)** is UM's term for the maximum
amount of **application payload** that fits in one transport datagram.
A datagram on the wire is:

```
[ transport header ][ LBMC header(s) ][ application payload ]
\__________________ datagram_max_size __________________/
```

If a message's payload exceeds the APDU, UM splits it into multiple
datagrams (fragments), each carrying a piece of the payload plus its
own headers, and the receiver reassembles them.

Each source precomputes three related sizes at **source-create time**,
per transport. For LBT-RM (`lbtrm/lbtrm.h`), with `D` = the configured
datagram max size (`transport_lbtrm_source_datagram_max_size`, else
`transport_lbtrm_datagram_max_size`):

| Field | Formula | Meaning |
|---|---|---|
| `apdu` | `D − transport_hdr − LBMC_MAX_HDR_SZ` | Max app data assuming the **worst-case** LBMC header |
| `raw_apdu` | `D − transport_hdr` | Datagram payload space with **no** LBMC header carved out yet |
| `frag_mtu` | `D − transport_hdr − (LBMC_MAX_HDR_SZ + frag_hdr)` | Per-fragment payload assuming the worst-case header |

`LBMC_MAX_HDR_SZ` is the sum of **every** optional LBMC header that
could ever appear on a message (topic name, app header / message
properties, fragment header, request, batch, OTID, context instance,
UMQ msgid, ...). It is a deliberately pessimistic worst-case reserve.
`apdu` and `frag_mtu` bake that worst case in permanently; `raw_apdu`
does not.

The same three-field pattern exists for every transport
(`LBM_TRANSPORT_*_SRC_APDU` / `_RAW_APDU` / `_FRAG_MTU` macros); only
the transport-header term differs (TCP's is effectively zero).

---

## 2. The static (legacy) algorithm — `dynamic_fragmentation_reduction = 0` (default)

On every send, the send path (`lbm_any_src_sendv_ex_post_block()` in
`lbmsrc.c`) computes the total user payload length `totallen` and:

```c
fragment       = (totallen <= src->apdu) ? 0 : 1;   /* fragment-or-not */
local_frag_mtu = src->frag_mtu;                     /* chunk size if fragmenting */
```

Both `apdu` and `frag_mtu` already had `LBMC_MAX_HDR_SZ` subtracted at
create time, so **every** message is treated as if it carries the
maximum-size header — even a message with no options at all. This is
simple and cheap (just reads two fixed fields) but pessimistic: small
messages fragment "too early" and datagrams are under-filled.

---

## 3. The dynamic algorithm — `dynamic_fragmentation_reduction = 1`

Instead of assuming the worst-case header, UM computes the **actual**
header size for *this specific message*:

```c
actual_hdr_sz = lbmc_calculate_hdr_buff_size(src->ctx, info); /* real, per-message */
actual_hdr_sz += <largest transport data header>;            /* compile-time constant */

fragment       = (totallen + actual_hdr_sz) <= src->raw_apdu ? 0 : 1;
local_frag_mtu = src->raw_apdu − actual_hdr_sz − LBMC_FRAG_HDR_SZ;
```

Two things to note:

- The comparison is against **`raw_apdu`** — the payload space with no
  header carved out yet — and the code subtracts only *this message's*
  real header. (The legacy path compares against the pre-shrunk
  `apdu`.)
- `lbmc_calculate_hdr_buff_size()` (`lbmc.c`) walks the message's
  option flags and adds only the headers actually present: topic name,
  message properties / app header, fragment header, request, batch,
  OTID, context instance, UMQ msgid, etc.

**The APDU is therefore dynamic — it can vary from message to message.**
A send with no options gets a small header and packs more payload into
the datagram; the very next send that attaches a message property sets
the `LBMC_APPHDR*` flags, grows `actual_hdr_sz`, and thus shrinks the
effective APDU for that message only.

### Why the option exists

By recovering the difference between the worst-case header
(`LBMC_MAX_HDR_SZ`) and each message's real header, DFR lets each
datagram more fully utilize the configured `datagram_max_size` —
reducing both UM-level fragmentation (fewer fragments) and IP-level
fragmentation. Per the option's documentation it is primarily of
interest to LBT-RM / LBT-RU users on kernel-bypass drivers, and should
be set together with `datagram_max_size = 1472` (see §4). The cost is a
small per-send CPU increment for the header walk, versus the legacy
path's fixed-field read.

---

## 4. MTU and header math — where 1472 comes from

`datagram_max_size` is measured at the **UDP-payload** level (the
LBT-RM/RU datagram — transport header + LBMC header + app data — rides
inside one UDP datagram). To land the whole thing in a single standard
Ethernet frame with **no IP fragmentation**, size it to the UDP payload
that fits under a 1500-byte IP MTU:

```
1500 (IPv4 MTU)  −  20 (IPv4 header)  −  8 (UDP header)  =  1472
```

The 28 bytes subtracted are **IPv4 (20) + UDP (8) only**. Ethernet
framing (14-byte header + 4-byte FCS, plus preamble and interframe gap)
lives *outside* the 1500 MTU and is **not** subtracted.

Caveats that change the number:

- **IPv4 options** raise the IP header above 20 bytes (up to 60),
  reducing usable payload. Rare on ordinary LANs (routers often
  drop/slow-path option-bearing packets), but real in specific cases:
  **Router Alert** (IGMP/RSVP/PIM control traffic — usually not your
  data packets), and **CIPSO/IPSO security labels** on
  government/defense **labeled/MLS networks** — the one case where your
  *data* packets can carry an option and silently defeat 1472. Source
  routing (LSRR/SSRR), Record Route, and Timestamp options also exist
  but are almost universally blocked or diagnostic-only.
- **IPv6**: 40-byte fixed header → `1500 − 40 − 8 = 1452` (plus any
  extension headers).
- **VLAN (802.1Q)** tags, and tunneling/encapsulation (VXLAN, GRE,
  IPsec, PPPoE) eat further into usable payload — size to the innermost
  path MTU.

---

## 5. Gotcha: the `LBM_DEBUG_NET` "APDU" log line is misleading under DFR

At source-create time UM emits (twice — standard source and smart
source, in `lbmsrc.c`):

```c
MUL_DEBUG(LBM_DEBUG_NET, ("src %p APDU %u FRAG %u [apphdrlen %u]\n",
                          src, src->apdu, src->frag_mtu, apphdrlen));
```

This line **always prints the static, worst-case values** (`src->apdu`
and `src->frag_mtu`, both computed with `LBMC_MAX_HDR_SZ`), **even when
`dynamic_fragmentation_reduction` is enabled**, for two reasons:

1. It logs `src->apdu` / `src->frag_mtu`, which the DFR path never uses
   and never updates — DFR works from `raw_apdu` and a per-message
   local `actual_hdr_sz` / `local_frag_mtu`.
2. It fires once, at source creation, long before any message is sent —
   so it cannot reflect a per-message value even in principle.

So under DFR the logged APDU is an **overly conservative** number: the
real, effective APDU for any given message is generally *larger* (less
header subtracted) and varies message to message.

**There is no per-message debug log of the actual APDU**, and adding one
that reports a single "the APDU" value would be meaningless: because
different messages carry different header sets (depending on send
options — properties, request, batch, spectrum channel, UMQ, etc.),
there is no single actual APDU to report. The effective value is only
determined at the moment of each send, inside
`lbmc_calculate_hdr_buff_size()`, for that message's specific flags. Any
accurate diagnostic would have to log per send (`totallen`,
`actual_hdr_sz`, `raw_apdu`, resulting `local_frag_mtu`, and fragment
count) — which is why the create-time summary line simply reports the
static worst case instead.

---

## 6. Quick reference

| Aspect | Legacy (`=0`, default) | `dynamic_fragmentation_reduction=1` |
|---|---|---|
| Header size assumed | Worst case (`LBMC_MAX_HDR_SZ`), fixed at create | Actual per-message (`lbmc_calculate_hdr_buff_size`) |
| Fragment test | `totallen <= apdu` | `totallen + actual_hdr_sz <= raw_apdu` |
| Fragment MTU | `frag_mtu` (worst-case) | `raw_apdu − actual_hdr_sz − frag_hdr` |
| APDU value | Static, one per source | **Dynamic, varies per message** |
| Datagram fill | Under-fills (pessimistic) | More fully utilizes datagram_max_size |
| Debug "APDU" line | Accurate | **Misleading — prints static worst case** |

Recommended pairing: enable DFR **and** set `datagram_max_size = 1472`
(IPv4) to avoid IP fragmentation on kernel-bypass drivers.
