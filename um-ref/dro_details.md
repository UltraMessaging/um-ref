# DRO (Dynamic Routing Option) — Conceptual Details

Companion to `dro_config.md` (which is pure schema). Read this first when
a task involves DROs beyond what `overview.md` covers — then use
`dro_config.md` as a lookup.

The DRO (`tnwgd` daemon) is an **optional** UM component. If everyone
publishing and subscribing is on the same LAN with multicast, you don't
need it. You need it when you want pub/sub to span network boundaries
that multicast can't cross.

---

## 1. The Problem the DRO Solves

UM's normal discovery mechanism is **Topic Resolution (TR)** — usually
multicast. Source advertises a topic by multicast; receivers on the same
LAN hear it, learn the transport address, and join. This works beautifully
on a single LAN. It fails as soon as:

- publishers and subscribers are in different datacenters,
- they're separated by a WAN, a firewall, or any network segment where
  multicast is blocked or impractical,
- you want to limit topic-resolution traffic blast radius.

A DRO is a user-space daemon that bridges these boundaries by tunneling
both topic resolution (discovery) and user data between otherwise
isolated UM networks.

---

## 2. Topic Resolution Domains (TRDs)

A **TRD** is a group of UM contexts that share the same topic-resolution
configuration and can talk to each other via the required transports
(especially for UDP-based TR, the same multicast reachability). "TRD" is
a *logical* concept; it usually maps onto a LAN or VLAN, but the defining
property is configuration, not geography.

- Every context belongs to exactly one TRD.
- Each TRD is tagged with a **domain-id** (a numeric identifier) inside
  the DRO world.
- A topic name is the same string across TRDs, but the **source string**
  (transport address) is different per TRD because each TRD's source is a
  different entity — possibly the real source, possibly a proxy.

**Uniqueness rules** (these are hard):
- Every TRD in your deployment MUST have a unique `domain-id`.
- A single DRO MUST NOT have two endpoint portals connected to the same
  TRD.
- There MUST NOT be two peer links directly connecting the same pair of
  DROs (one link per pair).

---

## 3. Portals: Endpoint vs Peer

A DRO is a collection of **portals** — its connection points. Every DRO
has at least two portals. There are two kinds:

### Endpoint portal (`<endpoint>`)

Connects the DRO to one TRD — the DRO becomes a participant in that
TRD's topic resolution. An endpoint portal creates UM sources, receivers,
and wildcard receivers internally to listen for interest and to
advertise topics from elsewhere.

- Exactly one endpoint portal per TRD-per-DRO.
- `<domain-id>` tags which TRD this endpoint lives in.

### Peer portal (`<peer>`)

Connects the DRO to another DRO over a TCP link (always; this is the
control channel), optionally adding a UDP companion link for data.

- Peer links do NOT touch a TRD directly. They tunnel between DROs.
- One side is the **initiator** (`<initiator>` block), the other is the
  **acceptor** (`<acceptor>` block). Symmetric once connected.

### The usual topology

DRO1 has one endpoint into TRD-A and one peer into DRO2. DRO2 has one
peer into DRO1 and one endpoint into TRD-B. Now TRD-A and TRD-B can
discover each other's topics and exchange messages, even though there's
no multicast reachability between them.

---

## 4. Topology Patterns (Brief)

The docs catalog many patterns. You usually don't need to memorize them,
but the names come up:

- **Direct link** — one DRO, two endpoint portals, bridging two adjacent
  TRDs. No peer hop.
- **Single link** — two DROs joined by one peer link, each also
  connected to a local TRD. The most common multi-datacenter pattern.
- **Parallel links** — multiple paths between two DROs (or TRDs). Lowest
  cost wins; others provide failover (hot/cold).
- **Mesh** — every DRO peered with every other. Many paths, fast
  failover, more configuration.
- **Loop** — DROs arranged in a ring; failure of any one link reroutes
  the other way.
- **Loop + spur** — a ring with one or more DROs hanging off via single
  links (not part of the ring).
- **Transit TRD** — a TRD used purely as a transit network between DROs
  (no applications live there). Sometimes simpler than a direct peer.
- **Star (central DRO or central TRD)** — hub-and-spoke. Hub failure =
  total failure; cheap.
- **Dumbbell / palm tree** — richer patterns; mentioned for completeness.

The choice is about failure modes, WAN economics, and convergence
behavior after failure — not about "features." Pick single-link for the
simple multi-datacenter case; reach for mesh/loop when you need
fast-failover redundancy.

**Unsupported:** active/active ("hot/hot") parallel links are not
supported in the base routing algorithm. Use **hotlinks** for hot/hot
(see §8).

---

## 5. Interest Propagation — How a Remote Subscriber Finds a Source

When a receiver in TRD-B subscribes to topic `AAA` but the source is in
TRD-A, here's what happens:

1. The receiver's context advertises its interest in `AAA` via TR (as
   always).
2. The DRO's endpoint portal in TRD-B hears that interest.
3. The interest propagates across the DRO's internal routing and, if
   necessary, across peer links to DRO(s) connected to TRD-A.
4. The DRO's endpoint portal in TRD-A learns that someone somewhere
   wants `AAA`. It creates a **proxy receiver** in TRD-A that joins the
   real source's transport.
5. The DRO's endpoint portal in TRD-B creates a **proxy source** in
   TRD-B that advertises `AAA` locally. The real receiver joins the
   proxy source's transport.
6. Messages flow: source → proxy receiver (in TRD-A) → DRO → peer link
   → DRO → proxy source (in TRD-B) → real receiver.

Interest can be per-topic or per-pattern. The DRO distinguishes between
topic interest and pattern interest throughout — different tables,
different propagation elements (`<remote-topic>`, `<remote-pattern>`).

### Use-queries

Endpoint portals periodically poll their TRD: "is anyone still
interested in topic X?" These are **topic-use-queries** and
**pattern-use-queries**. If nobody responds within the query's
`timeout` for `max` consecutive tries, the DRO stops forwarding that
topic/pattern.

**Critical:** with UDP-based TR, you MUST NOT disable use-queries — that
is how the DRO learns whether interest still exists at all. With the SRS
TR, interest is push-based and use-queries are unnecessary.

---

## 6. Routing and Cost

A **route** is a path from source TRD to receiver TRD through zero or
more DROs. When multiple paths exist, DROs pick the one with the lowest
summed **cost**.

- `<cost>` on a portal is a positive integer. Lower is preferred.
- Cost is abstract: you decide what it means (latency, $/GB, reliability
  rank, etc.).
- DROs exchange **route-info** messages periodically
  (`<route-info><propagation-interval>`) to build their topology map.
- When the topology changes (link up/down, DRO up/down), DROs wait a
  short **backoff** window (`<route-recalculation><backoff-interval>`)
  for things to settle before recomputing — avoids thrashing on flapping
  links.
- **Convergence is not instantaneous.** Expect seconds of message drops
  during a failover in the base routing algorithm.
- `<route-info><max-hop-count>` bounds how many DRO hops a route-info
  message can take — prevents loops in topology advertisement (not a cap
  on actual data hops).

### Tie-breaking on equal-cost routes

When two candidate routes tie on total cost, UM breaks the tie
deterministically using a per-DRO internal identifier — a random
number chosen at DRO startup and gossiped through the network so every
component computes the same winner. Tie-breaking is therefore
consistent but unpredictable across DRO restarts (the random ID is
fresh each time).

### UIM (Unicast Immediate Message) routing uses the same graph differently

Each app maintains a shortest-path route table keyed by
`(TID, IP, Port)` where TID is the destination TRD's domain ID. When
sending a UIM, the app consults the table and hands the UIM to the DRO
responsible for that TID; the UIM is TCP-based but not end-to-end —
it's forwarded through DROs like any other DRO-routed traffic.
Crucially, UIMs do **not** use proxy-sources or proxy-receivers; this
is a separate routing mechanism that shares the shortest-path
computation with normal source/receiver traffic but applies it
differently.

Normal source/receiver routing uses the same shortest-path algorithm,
but consults it **once** at proxy-source / proxy-receiver creation
time. Once the proxy chain is established, individual messages flow
through it without re-consulting the route table. UIMs consult the
table **on every send**. Consequence: a UIM sender picks up a new
next-hop DRO on the next message as soon as its route table updates,
while source traffic depends on whether existing proxy connections
survive or get re-established.

Under route-group-driven redundancy (see §8), UIMs are duplicated
across the parallel active DROs, just like source/receiver traffic
(via parallel proxy chains).

---

## 7. Proxy Sources and Proxy Receivers (DRO-side)

DROs create proxies on demand:

- **Proxy receiver** in the *source's* TRD — joins the real source's
  transport, forwards messages into the DRO.
- **Proxy source** in the *receiver's* TRD — advertises the topic
  locally and transmits messages the DRO has forwarded.

**Key properties:**
- Proxies are **per-topic** and ephemeral. They appear when interest
  requires them and disappear when interest drains.
- A proxy source uses a **different transport session** from the real
  source. Transport type may even differ (e.g., LBT-RM on one side, TCP
  on the other) — this is called **protocol conversion**.
- Proxy source deletion is delayed by `<source-deletion-delay>`
  (default 1 s) to avoid churn on rapid subscribe/unsubscribe cycles.
- A proxy receiver can multiplex multiple originating sources (one per
  originating transport session); a proxy source is per-advertised-source.

**DRO proxy source vs Store proxy source** — these are different
beasts:
- DRO proxy source: forwarding across TRDs. Created per-topic as needed.
  No retention; cannot serve retransmission history.
- Store proxy source: takeover for a silent real source. Created to keep
  a dead source's topic discoverable for recovery purposes. See
  `store_details.md` §5.

**BOS/EOS** reported by a receiver reflects the proxy source-receiver
relationship, not the real end-to-end source. A BOS/EOS event may mean
"DRO created/removed the proxy," not "publisher started/stopped."

---

## 8. Hotlinks (Advanced — Hot/Hot Redundancy)

Hotlinks is an opt-in feature for **active/active** redundancy across
parallel WAN paths. Both paths forward the same messages; UM delivers
the first copy and discards duplicates. If one path fails, the other
continues with no visible gap.

- Sources/receivers must opt in (`use_hotlink`).
- Costs: receivers see ~2× the packet load (duplicates discarded inside
  the UM stack, transparent to the app); network uses ~2× bandwidth.
- Designed for the multi-datacenter-with-dual-WAN case.

Don't reach for hotlinks unless you specifically need zero-gap failover.
Base-algorithm parallel links with fast failover are usually enough.

### How hot/hot is actually implemented — `route-group`

Hotlinks was deliberately **not** built into the shortest-path routing
algorithm. The algorithm is single-route: between any two TRDs it
picks exactly one winning path. Hot/hot redundancy is layered on top
via `<route-group>`, a portal attribute that exploits this by making
certain DROs invisible to each other in the routing graph.

**Rule:** two DROs that share a `<route-group>` on their portals
facing the same TRD become mutually invisible to each other for
shortest-path calculation.

Consequence: each invisible-to-the-other DRO computes shortest-path in
a world where the other doesn't exist, concludes **it** is the only
route to the destination TRD, and goes active. That's how you get two
(or more) DROs simultaneously active between the same TRD pair — the
routing algorithm never sees the redundancy; it just sees multiple
"only routes" running in parallel.

A portal can declare multiple route-groups; a DRO is invisible to any
other DRO with which it shares *at least one* group. This supports
asymmetric redundancy patterns. Canonical example with three DROs all
bridging TRD X ↔ TRD Y via transit TRDs:

- DRO-A: route-group `1` on TRD-X portal.
- DRO-B: route-group `2` on TRD-X portal.
- DRO-C: route-groups `1` and `2` on TRD-X portal.

A and B are in different groups → visible to each other → cost
tiebreak picks a single winner, the other stays standby.
C shares group 1 with A and group 2 with B → C is invisible to both A
and B, and A and B are both invisible to C → C stays active
regardless, alongside whichever of A/B won.
Net: two DROs always active (C + one of {A, B}).

Portal ACLs (see §10) can restrict which messages a DRO carries, so
hot/hot can be scoped per-topic (or per-ACL-criterion, usually topic).
A hot/hot redundant DRO with an allowlisting ACL only carries traffic
for the allowlisted topics; other topics remain single-active with
failover.

### `hotlink-index` and the hotlink-chaining restriction

`<hotlink-index>` is a **separate** knob from `<route-group>`. It's
declared per endpoint portal and governs a different rule: the
hotlink-chaining restriction.

A **hotlink hop** is a DRO traversal where *both* endpoint portals
declare `<hotlink-index>`. UM forbids chaining full hotlink hops: a
hotlinked message cannot exit one full-hotlink DRO and then enter
another full-hotlink DRO. A DRO endpoint *without* `<hotlink-index>`
is transparent to this rule — it's half a hotlink hop, and the TRD on
that side acts as a plain-messaging transit. Two half-hops (TRD A →
[transit TRD] → TRD B, where each DRO has `<hotlink-index>` only on
its non-transit portal) stitch into one logical hotlink hop and are
allowed.

Practical consequence: a TRD whose DROs are full-hotlink on both
portals cannot serve as a transit between other hotlinked TRDs; a TRD
whose DROs are indexed on only one portal (with the other portal
plain) can.

`hotlink-index` and `route-group` are orthogonal: `route-group`
governs DRO visibility for shortest-path (and therefore which DROs end
up active in parallel); `hotlink-index` governs the chaining
restriction. Hotlink setups use them in combination.

---

## 9. DRO + Persistence Interaction

Persistence across TRDs works, but requires care:

- **Store locality.** The Store is usually colocated with the source's
  TRD. It's possible to put the Store in the receiver's TRD, but the
  retransmit path becomes cross-DRO on every recovery and has been
  historically less tested. Prefer source-local Stores.
- **`context-name` + DRO.** The Store should be configured with
  `context-name` (see `store_config.md` §6) so that it can be referenced
  by logical name across TRDs. The DRO propagates context-name
  reachability the way it propagates topics.
- **Enable OTR.** Informatica recommends enabling Off-Transport
  Recovery for persistent receivers in DRO deployments — OTR routes
  retransmit requests through the persistence channel, which the DRO
  forwards, rather than through the transport retransmit path which is
  per-session and doesn't cross DROs well.
- **BOS/EOS reflects proxy lifecycle**, not real source liveness —
  persistence-aware apps should check stability/recovery events, not
  BOS/EOS, to determine source state.

---

## 10. ACLs — Controlling What Crosses

ACLs are attached to portals to filter traffic entering or leaving. Two
use cases dominate:

1. **Security.** Block sensitive topics from leaving a TRD, or block
   untrusted TRDs from injecting topics into a protected one.
2. **WAN hygiene.** A wildcard receiver in TRD-B can otherwise drag
   every source in TRD-A across the WAN. An outbound ACL on the relevant
   portal caps which topics propagate.

### Structure

- An `<acl>` contains `<inbound>` and/or `<outbound>` lists.
- Each list is a sequence of `<ace>` entries, evaluated in order.
- Each `<ace>` has `match="accept"` or `match="reject"` and one or more
  condition elements (AND'ed together).
- **Implicit default: reject.** If no ACE matches, the message is
  rejected. ACLs are allowlists.

### What you can match on

- `<topic>` or `<pcre-pattern>` — inbound and outbound.
- Transport attributes (`<transport>`, `<source-ip>`,
  `<multicast-group>`, source/destination ports, IPC xport-id) — inbound
  only.

**Note on remote proxies:** when the source is in a remote TRD,
transport conditions match the *local proxy source's* attributes, not
the originating source. This is easy to get wrong.

**MIM (Multicast Immediate Messaging)** is NOT filterable by ACLs and
is forwarded to all TRDs if used. Don't rely on ACLs to contain MIM.

---

## 11. Peer Link — TCP and Optional UDP

Every peer link is TCP at minimum (always: control messages and,
by default, data too). TCP alone is simple and reliable, but on
high-latency/high-BDP WAN links TCP latency variance and throughput
ceilings can hurt.

### Adding the UDP companion

Configure a `<udp>` block on the peer. Now:

- Control messages still go over TCP.
- Data goes over UDP, using LBT-RU-style NAK-based reliability.
- Both links must be healthy; if either fails, the portal tears down and
  reconnects.

### When to add UDP

- WAN peer with >10 ms RTT and meaningful bandwidth requirements.
- Observable TCP throughput collapse during mild packet loss.
- Latency-sensitive pipelines where TCP retransmit stalls are visible.

For short, reliable peer links (colocated racks, low-loss LANs), plain
TCP is fine.

### Peer-link goodies

- **Batching** (`<batching>`): implicit batching on the peer link.
  Controls amortize per-message overhead.
- **Smart-batch** (`<smart-batch>`): allows very large batch thresholds
  safely.
- **Compression** (`<compression>LZ4</compression>`) — reduces WAN
  bytes at small CPU cost.
- **TLS** (`<tls>`) — peer-link encryption. Required for compliance in
  most inter-datacenter traffic over untrusted networks.

---

## 12. Keepalives and Duplicate Detection

### Gateway keepalive (peer links)

`<gateway-keepalive>` runs at the DRO level, distinct from TCP
keepalive. Sends heartbeats between peers. Informatica recommends
`interval ≥ 2000` ms and `timeout = 3 × interval`. Tune for your
WAN RTT and jitter.

### Sequence-number window (`<sqn-window>`)

The DRO tracks sequence numbers per originating source within a sliding
window to detect duplicates and out-of-order messages across the
proxy-source boundary. Default size 16384, increment 2048; both must be
multiples of 8, and increment must evenly divide size. Don't change this
without a clear reason.

### Out-of-order tolerance on reliable transports

When protocol conversion lands on TCP or LBT-IPC in the receiver's TRD,
minor reordering (which TCP tolerates natively but the UM receiver
stack doesn't expect on a "reliable" session) can trigger false
unrecoverable-loss events. UM 6.12+ exposes
`transport_tcp_dro_loss_recovery_timeout_receiver` and the IPC
equivalent — tune these if you see spurious loss events downstream of a
DRO.

---

## 13. Terminology — Use These Precisely

- **TRD (Topic Resolution Domain)** — a group of contexts sharing TR
  config and (for UDP TR) multicast reachability. Logical, not
  geographic.
- **Domain-id** — numeric tag uniquely identifying a TRD within a
  DRO-connected deployment.
- **Portal** — a connection point on a DRO. Endpoint or peer.
- **Endpoint portal** — portal into a TRD (one per TRD per DRO).
- **Peer portal** — portal to another DRO, over TCP (+ optional UDP).
- **Proxy source / proxy receiver** — DRO-created forwarding entities,
  per-topic, ephemeral.
- **Route** — path through DROs from source TRD to receiver TRD.
- **Cost** — per-portal integer; routes pick minimum summed cost.
- **Hotlink** — opt-in hot/hot parallel-path forwarding.
- **Interest** — a receiver's or pattern's subscription; propagated
  across DROs to pull remote sources into local visibility.
- **UIM (Unicast Immediate Message)** — one-off directed messages the
  DRO forwards; tracked via `<sqn-window>` to dedupe.

---

## 14. Common Pitfalls (From the Docs)

1. **Duplicate `domain-id`** — silent catastrophe. Domain-ids must be
   unique across the deployment.
2. **Two endpoint portals into the same TRD from one DRO** — not
   supported. One endpoint per TRD per DRO.
3. **Two peer links between the same pair of DROs** — not supported.
4. **Disabling use-queries with UDP TR** — the DRO has no way to learn
   interest. Don't.
5. **BOS/EOS misinterpretation** — BOS/EOS on a proxy-sourced topic
   tracks the proxy, not the real source. Don't tie application logic to
   BOS/EOS in DRO deployments without understanding this.
6. **Transport ACL conditions on remote sources** — match the local
   proxy source's transport, not the originating source's.
7. **MIM leaks across TRDs** — ACLs don't filter it. If you use MIM and
   want containment, don't use MIM across DROs.
8. **Mismatched datagram sizes under protocol conversion** — if the
   source side uses larger datagrams than the proxy source's transport
   allows, messages drop. Keep `transport_*_datagram_max_size` aligned
   (Informatica recommends 8192 for UDP-based transports).
9. **Gateway-keepalive timeout too short** — flaky WAN + aggressive
   keepalive = constant reconnects. Default is 15 s; don't go below 2×
   your worst-case RTT jitter.
10. **Expecting instant failover from parallel links** — base routing
    gives you fast-ish failover (seconds), not zero-loss failover. Use
    hotlinks if zero-gap is required.

---

## 15. What Isn't Covered Here

- Full hotlink configuration — only the concept is sketched here. The
  PNG/PPTX files in `doc/Gateway/` (`Hotlinks1..4`, `Hotlinks_chains`)
  are the authoritative diagrams.
- Deep topology-pattern trade-offs — cost tuning for mesh/loop failover
  analysis is a real-world exercise, not a spec.
- Daemon statistics and monitoring — handled by UM automatic monitoring
  (`monitor_format=pb`); the legacy `<daemon-monitor>` in
  `dro_config.md` is deprecated.

If a task requires these, go to `doc/Gateway/index.m4` directly.
