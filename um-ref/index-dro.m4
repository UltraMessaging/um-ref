m4_define(`m4_title', `Dynamic Routing Guide') m4_dnl
m4_define(`m4_first_sect', `Introduction') m4_dnl
m4_define(`m4_pdf_name', `UM_Routing_Guide=en.pdf') m4_dnl
m4_include(`initial.m4')

This document explains design concepts and product implementation for
the Ultra Messaging <i>Dynamic Routing Option</i> (DRO).

For policies and procedures related to Ultra Messaging Technical Support,
see <a href="https://ultramessaging.github.io/UM_Support.html">UM Support</a>.

m4_include([[[copyright.m4]]])

m4_include([[[legal.m4]]])

The Ultra Messaging Dynamic Routing Option (DRO) consists of a daemon named
"tnwgd" that bridges disjoint
\ref topicresolutiondomain "Topic Resolution Domains" (TRDs) by effectively
forwarding control and user traffic between them.
Thus, the DRO facilitates WAN routing where
multicast routing capability is absent, possibly due to technical obstacles
or enterprise policies.

FYI: for historical reasons, the DRO has gone by several names:
<ul>
<li>Gateway
<li>tnwg = "Twenty Nine West Gateway"
<li>UM Router
<li>Dynamic Router
<li>DRO = Dynamic Routing Option
</ul>
In the UM documentation, the term "DRO" is generally used for brevity,
but sometimes various abbreviations that include "tnwg" are used.

\m4_s1 drofeatures DRO Features

The DRO includes the following features:
<ul>
<li>Full bidirectional forwarding
<li>Multi-hop forwarding
<li>Mesh, loop, or alternate path DRO configurations
<li>Automatic rerouting around faults
<li>Support for wildcard receivers
<li>Support of Request/Response messages
<li>Traffic filtering on multiple criteria
<li>DRO resilience
<li>UMP persistence support
<li>UM transport monitoring statistics
<li>Web Monitoring
<li>MIM and UIM forwarding
</ul>

The following features are not fully supported in this release of the DRO:
<ul>
<li>Queuing, both ULB and Brokered (including brokered JMS)
<li>Multitransport Threads (MTT)
</ul>

If you desire any of these features or any configuration or topology not
presented in this document, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\note The DRO is not directly supported on the OpenVMS platform.
UM applications running on the OpenVMS platform, however, can use a
DRO running on a different platform, such as Microsoft Windows or Linux.

\m4_pg droarchitecture DRO Architecture

\m4_s1 umrouterportals DRO Portals

The DRO uses interfaces, called portals, through which to pass data.
A DRO consists of two or more bidirectional portals that may be one
of two types:

<ul>
<li>An endpoint portal, which communicates directly to a UM topic resolution
domain (TRD; see Topic Resolution Domains).
<li>A peer portal, which communicates via TCP with another peer portal (of
another DRO), allowing tunneling between DROs. Two peer portals
connected to each other are referred to as companion peers, and by
default, utilize TCP connections for data and control traffic.
Compression and encryption can be applied to TCP-only peer links.
Optionally, latency can be reduced by adding UDP to the peer link;
see \ref udppeerlink.
</ul>

The figure below shows a simple DRO use case, where two DROs
bridge an ISP to connect two TRDs using a TCP link.

\image html portals.png
\image latex portals.png

You configure portals in the DRO's XML configuration file, specifying
the portal's name, cost, UM Configuration, Access Control Lists and other
attributes. See \ref xmlconfigurationreference.

\m4_s2 udppeerlink UDP Peer Link

By default, a DRO peer link uses a single TCP connection to
communicate between two DROs.
But TCP can introduce latency outliers and limit throughput,
especially when used over a high-bandwidth, high-latency WAN
link that experiences occasional packet loss.
Latency and throughput can be improved by enabling
the UDP peer link option.

When UDP is enabled for a peer link, the TCP peer link is still used for
DRO command and control messages.
Everything else, including user data, is exchanged using UDP.

To enable UDP on a peer link,
use the \ref droelementudp.
At a minimum, you must configure the port number.

When configured, both the TCP and the UDP links must be
operational.
If either link fails to pass data,
the DRO will disconnect and reconnect until both
links are successful.

The UDP peer link uses the same reliable unicast protocol as
the \ref transportlbtru protocol,
and shares many of the same configuration options as
the transport.
However, unlike LBT-RU, the UDP peer link does not need
to have a datagram maximum size configured.
It is hard-coded to a large value (above 65,000 bytes),
chosen to be sufficient to handle all valid UM fragment sizes.

Starting with UM version 6.17, the UDP Peer link supports
compression and encryption.
See \ref droelementcompression and \ref droelementtls.

\m4_s1 topicresolutiondomains Topic Resolution Domains

Since topic resolution uses UDP, sources and receivers must have UDP
connectivity to each other. When they do, we consider them to be in the
same topic resolution domain (TRD). More specifically, UM contexts must
satisfy the following two requirements to belong to the same topic
resolution domain.

<ul>
<li>The contexts must use the same topic resolution UM configuration (i.e.,
resolver_* options are the same).
<li>Contexts can communicate using the protocols required for both message
transport and topic resolution traffic.
</ul>

For example, two contexts on separate machines in the same LAN are not in
the same topic resolution domain if they use different resolver addresses.
See Multicast Resolver Network Options. A topic resolution domain can span
a WAN if the UM contexts on each side of a firewall use the same UM
configuration and the firewall allows UDP traffic (multicast or unicast)
to pass.

Each endpoint portal must identify its associated topic resolution domain with
a domain-id the DRO's XML configuration file, as in the example below.
All portals in the same TRD must have the same domain-id, and different TRDs
networked together via DROs must have domain-ids unique to each other.

\code
  <portals>
    <endpoint>
      <name>LAN100</name>
      <domain-id>100</domain-id>
      <lbm-config>lan100.cfg</lbm-config>
    </endpoint>
    <endpoint>
      <name>LAN200</name>
      <domain-id>200</domain-id>
      <lbm-config>lan200.cfg</lbm-config>
    </endpoint>
  </portals>
\endcode

\m4_s1 proxysourcesandproxyreceivers Proxy Sources and Proxy Receivers

To resolve a topic across a DRO (described in
\ref basicumrouteroperation),
the DRO creates, within portals, proxy sources and proxy receivers
(shown in the figure below by their dashed lines). These proxies behave
like their UM counterparts; they resolve topics on the TRDs like normal
sources and receivers, and the DRO internally passes data from one
portal to the other. However unlike regular sources, proxy sources do not
have retransmission retention buffers normally used for Late Join or OTR.

\image html proxies.png
\image latex proxies.png

Portals exist while the DRO is running, however, the DRO
creates proxy sources and receivers during topic resolution and deletes
them when the topic is retired.

\note The proxy sources created by the DRO are unrelated to proxy
sources created by the UMP persistent store.

\m4_s2 umrouterandtransportsessions DRO and Transport Sessions

When the DRO creates proxy receivers to get messages to forward,
be aware that the <i>transport sessions</i> carrying those messages are
not extended to the destination TRD.
Instead, the proxy receiver simply takes the messages from the originating
transport sessions and transfers them to the destination DRO's proxy sources.
Those proxy sources create new transport sessions for those outgoing messages.

The proxy sources' outgoing transport sessions are unrelated to the
originating sources' transport sessions.
They can even use different transport types, performing a protocol conversion.
In fact, a single transport session can contain multiple sources from
different originating publishing applications for the same topic.
Alternatively, multiple sources from the same originating publishing
application which are mapped to the same originating transport session
can be split into multiple transport sessions by the proxy sources in a
remote TRD.

One consequence of the independence of incoming and outgoing transport
sessions is that TCP flow control does not transit the DRO.
A slow receiver in a remote TRD cannot "push back" on a fast source.
In cases where a TCP transport session is slowed down due to one or more
slow receivers,
an intermediate DRO will eventually have to drop messages.

\warning A single source's "source string" will be different in different
TRDs connected by DROs.
See \ref sourcestringsinaroutednetwork for details.

\m4_s1 routing Routing

In multiple-DRO environments where more than one DRO can
provide possible messaging pathways, the DROs are able to cooperatively
determine and establish optimal routes. Also, the DRO network is able
to detect link or other DRO outages and automatically reroute traffic
as needed. See \ref routingtopologies for more information.

\m4_pg umrouterconcepts DRO Concepts

\m4_s1 basicumrouteroperation Basic DRO Operation

The DRO's routing algorithm is said to be "interest-based".
That is, subscribers express interest in topic names and/or
wildcard topic patterns.
The DRO network maintains lists of topics and patterns for each TRD,
and routes messages accordingly.

The diagram below shows a DRO bridging topic resolution domains
TRD1 and TRD2, for topic AAA, in a direct link configuration.
Endpoint E1 contains a proxy receiver for topic AAA and endpoint E2
has a proxy source for topic AAA.

\image html basic_routing.png
\image latex basic_routing.png

To establish topic resolution in an already-running DRO, the following
sequence typically occurs in an example like the above figure.

<ol>
<li>A receiver in TRD2 issues a TQR (Topic Query Record) for topic AAA.
<li>Portal E2 receives the TQR and passes information about topic AAA
to all other portals in the DRO. (In this case, E1 is the only
other portal.)
<li>E1 immediately responds with three actions: a) create a proxy receiver
for topic AAA, b) the new proxy receiver sends a TQR for AAA into TRD1,
and c) E1 issues a Topic Interest message into TRD1 for the benefit of any
other DROs that may be connected to that domain.
<li>A source for topic AAA in TRD1 sees the TQR and issues a TIR
(Topic Information Record).
<li>E2 creates proxy source AAA, which then issues a TIR to TRD2.
The receiver in TRD2 joins the transport, thus completing topic resolution.
<li>E1's AAA proxy receiver sees the TIR and requests that E2 (and any
other interested portals in the DRO, if there were any) create a
proxy source for AAA.
</ol>

\m4_s2 interestandtopicresolution Interest and Topic Resolution

As mentioned in \ref basicumrouteroperation,
the DRO's routing algorithm is "interest-based".
The DRO uses UM's Topic Resolution (TR) protocol to discover and maintain
the interest tables.

For \ref tcpbasedtopicresolutiondetails "TCP-based TR",
the SRS informs DROs of receiver topics and wildcard receiver patterns. 

For \ref udpbasedtopicresolutiondetails "UDP-based TR",
the application's TR queries are used to inform DROs of its receiver
topics and wildcard receiver patterns.

\attention If using UDP-based TR, do not disable querying,
as that would prevent the DRO from discovering topic and pattern interest.

\m4_s2 interestandusequeries Interest and Use Queries

When a DRO starts, its endpoint portals issue a brief series of Topic
Resolution Request messages to their respective topic resolution domains.
This provokes quiescent receivers (and wildcard receivers) into sending Use
Query Responses, indicating interest in various topics.
Each portal then records this interest.

\image html dro_tr_1.png
\image latex dro_tr_1.png

After a DRO has been running, endpoint portals issue periodic Topic
Use Queries and Pattern Use Queries (collectively referred to as simply
Use Queries). Use Query Responses from UM contexts confirm that the
receivers for these topics indeed still exist, thus maintaining these topics
on the interest list. Autonomous TQRs also refresh interest and have the
effect of suppressing the generation of Use Queries.

\image html dro_tr_2.png
\image latex dro_tr_2.png

In the case of multi-hop DRO configurations, DROs cannot
detect interest for remote contexts via Use Queries or TQRs.
They do this instead via Interest Messages. An endpoint portal generates
periodic interest messages, which are picked up by adjacent DROs
(i.e., the next hop over), at which time interest is refreshed.

\image html dro_tr_3.png
\image latex dro_tr_3.png

You can adjust intervals, limits, and durations for these topic resolution
and interest mechanisms via DRO configuration options (see
\ref xmlconfigurationreference).

\m4_s2 umrouterkeepalive DRO Keepalive

To maintain a reliable connection, peer portals exchange DRO Keepalive
signals. Keepalive intervals and connection timeouts are configurable on a
per-portal basis.
You can also set the DRO to send keepalives only when traffic is idle,
which is the default condition.
When both traffic and keepalives go silent at a portal ingress, the portal
considers the connection lost and disconnects the TCP link.
After the disconnect, the portal tries to reconnect.
See \ref droelementgatewaykeepalive "<gateway-keepalive>".

\m4_s2 finaladvertisements Final Advertisements

DRO proxy sources on endpoint portals, when deleted, send out a
series of final advertisements.
A final advertisement tells any receivers, including proxy receivers on
other DROs, that the particular source has gone away.
This triggers EOS and clean-up activities on the receiver relative to
that specific source, which causes the receiver to begin querying according
to its topic resolution configuration for the sustaining phase of querying.

In short, final advertisements announce earlier detection of a source that
has gone away, instead of transport timeout.
This causes a faster transition to an alternative proxy source on a
different DRO if there is a change in the routing path.

\m4_s2 moreaboutproxysourcesandreceivers More About Proxy Sources and Receivers

The domain-id is used by Interest Messages and other internal and
DRO-to-DRO traffic to ensure forwarding of all messages (payload
and topic resolution) to the correct recipients.
This also has the effect of not creating proxy sources/receivers where
they are not needed.
Thus, DROs create proxy sources and receivers based solely on
receiver interest.

If more than one source sends on a given topic, the receiving portal's
single proxy receiver for that topic receives all messages sent on that topic.
The sending portal, however creates a proxy source for every source sending
on the topic.
The DRO maintains a table of proxy sources, each keyed by an
Originating Transport ID (OTID), enabling the proxy receiver to forward each
message to the correct proxy source.
An OTID uniquely identifies a source's transport session, and is included
in topic advertisements.

\m4_s2 protocolconversion Protocol Conversion

When an application creates a source, it is configured to use one of the
UM transport types.
When a DRO is deployed, the proxy sources are also configured to use one of
the UM transport types.
Although users often use the same transport type for sources and proxy sources,
this is not necessary.
When different transport types are configured for source and proxy source,
the DRO is performing a protocol conversion.

When this is done, it is very important to configure the transports to use
the same maximum datagram size.
If you don't, the DRO can drop messages which cannot be recovered through
normal means.
For example, a source in \ref topicresolutiondomain 1
might be configured for TCP, which has a default
maximum datagram size of 65536.
If a DRO's remote portal is configured to create LBT-RU proxy sources, that
has a default maximum datagram size of 8192.
If the source sends a user message of 10K, the TCP source will send it as a
single fragment.
The DRO will receive it and will attempt to forward it on an LBT-RU proxy
source, but the 10K fragment is too large for LBT-RU's maximum datagram
size, so the message will be dropped.

See \ref messagefragmentationandreassembly.

The solution is to override the default maximum datagram sizes to be the
same.
Informatica generally does not recommend configuring UDP-based transports for
datagram sizes above 8K, so it is advisable to set the maximum datagram
sizes of all transport types to 8192, like this:

\verbatim
context transport_tcp_datagram_max_size 8192
context transport_lbtrm_datagram_max_size 8192
context transport_lbtru_datagram_max_size 8192
context transport_lbtipc_datagram_max_size 8192
source transport_lbtsmx_datagram_max_size 8192
\endverbatim

Note that users of a \ref glossarykernelbypass "kernel bypass" network driver
(e.g.  Solarflare's Onload) frequently want to avoid all IP fragmentation,
and therefore want to set their datagram max sizes to an MTU.
See \ref datagrammaxsizeandnetworkmtu
and \ref dynamicfragmentationreduction.

Configuration options:
\ref transporttcpdatagrammaxsizecontext,
\ref transportlbtrmdatagrammaxsizecontext,
\ref transportlbtrudatagrammaxsizecontext,
\ref transportlbtipcdatagrammaxsizecontext,
and \ref transportlbtsmxdatagrammaxsizesource.

Final note: the \ref resolverdatagrammaxsizecontext option also
needs to be made the same in all instances of UM, including DROs.

\m4_s1 multihopforwarding Multi-Hop Forwarding

UM can resolve topics across a span of multiple DROs.
Consider a simple example DRO deployment,
as shown in the following figure.

\image html multi_hop.png
\image latex multi_hop.png

In this diagram, DRO A has two endpoint portals connected to
topic resolution domains TRD1 and TRD2.
DRO B also has two endpoint portals, which bridge TRD2 and TRD3.
Endpoint portal names reflect the topic resolution domain to which they connect.
For example, DRO A endpoint E2 interfaces TRD2.

TRD1 has a source for topic AAA, and TRD3, an AAA receiver.
The following sequence of events enables the forwarding of topic messages
from source AAA to receiver AAA.

<ol>
<li>Receiver AAA queries (issues a TQR).
<li>DRO B, endpoint E3 (B-E3) receives the TQR and passes information
about topic AAA to all other portals in the DRO.
In this case, B-E2 is the only other portal.
<li>In response, B-E2 creates a proxy receiver for AAA and sends a Topic
Interest message for AAA into TRD2.
The proxy receiver also issues a TQR, which in this case is ignored.
<li>DRO A, endpoint E2 (A-E2) receives this Topic Interest message
and passes information about topic AAA to all other portals in the DRO.
In this case, A-E1 is the only other portal.
<li>In response, A-E1 creates a proxy receiver for AAA and sends a Topic
Interest message and TQR for AAA into TRD1.
<li>Source AAA responds to the TQR by sending a TIR for topic AAA.
In this case, the Topic Interest message is ignored.
<li>The AAA proxy receiver created by A-E1 receives this TIR and requests
that all DRO A portals with an interest in topic AAA create a proxy
source for AAA.
<li>In response, A-E2 creates a proxy source, which sends a TIR for topic
AAA via TRD2.
<li>The AAA proxy receiver at B-E2 receives this TIR and requests that all
DRO B portals with an interest in topic AAA create a proxy source for AAA.
<li>In response, B-E3 creates a proxy source, which sends a TIR for topic AAA
via TRD3. The receiver in TRD3 joins the transport.
<li>Topic AAA has now been resolved across both DROs,
which forward all topic messages sent by source AAA to receiver AAA.
</ol>

\m4_s1 routingwildcardreceivers Routing Wildcard Receivers

The DRO supports topic resolution for wildcard receivers in a manner
very similar to non-wildcard receivers.
Wildcard receivers in a TRD issuing a WC-TQR cause corresponding proxy
wildcard receivers to be created in portals, as shown in the following figure.
The DRO creates a single proxy source for pattern match.

\image html wildcard.png
\image latex wildcard.png

\m4_s1 forwardingcosts Forwarding Costs

Forwarding a message through a DRO incurs a cost in terms of latency,
network bandwidth, and CPU utilization on the DRO machine
(which may in turn affect the latency of other forwarded messages).
Transiting multiple DROs adds even more cumulative latency to a message.
Other DRO-related factors such as portal buffering,
network bandwidth, switches, etc., can also add latency.

Factors other than latency contribute to the cost of forwarding a message.
Consider a message that can be sent from one domain to its destination domain
over one of two paths.
A three-hop path over 1Gbps links may be faster than a single-hop path over
a 100Mbps link.
Further, it may be the case that the 100Mbps link is more expensive or less
reliable.

You assign forwarding cost values on a per-portal basis.
When summed over a path, these values determine the cost of that entire path.
A network of DROs uses forwarding cost as the criterion for determining
the best path over which to resolve a topic.

\m4_s1 umrouterrouting DRO Routing

DROs have an awareness of other DROs in their network and how
they are linked.
Thus, they each maintain a topology map, which is periodically confirmed
and updated.
This map also includes forwarding cost information.

Using this information, the DROs can cooperate during topic resolution
to determine the best (lowest cost) path over which to resolve a topic or
to route control information.
They do this by totaling the costs of all portals along each candidate route,
then comparing the totals.

For example, the following figure shows two possible paths from TRD1 to TRD2:
A-C (total route cost of 11) and B-D (total route cost of 7).
In this case, the DROs select path B-D.

\image html routing.png
\image latex routing.png

If a DRO or link along path B-D should fail,
the DROs detect this and reroute over path A-C.
Similarly, if an administrator revises cost values along path B-D to
exceed a total of 12, the DROs reroute to A-C.

If the DROs find more than one path with the same lowest total cost value,
i.e., a "tie", they select the path based on a node-ID selection algorithm.
Since administrators do not have access to node IDs,
this will appear to be a pseudo-random selection.

In normal usage, you cannot configure parallel paths
(such as for load balancing or Hot failover),
as the DROs always select the lowest-cost path and only the
lowest-cost path for all data between two points.

An exception to this rule is \ref drohotlinks (see next section).

\m4_s1 drohotlinks DRO Hotlinks

The DRO "hotlink" feature is intended for large UM deployments where
multiple datacenters are interconnected by two independent global
networks.
The function of the DRO hotlinks feature is to implement a form of
\ref hotfailoverhf whereby two copies of each message are
sent in parallel over the two global networks from a publishing datacenter
to subscribing datacenters.
The subscribing process will normally receive both copies of each
message, but UM will deliver the first one it receives and discard the second.

The purpose for this feature is to provide high availability in the face
of failure of a global network.
It is unlikely that both global networks will fail at the same time,
so if one does fail, the messages flowing over the other network will
continue to provide connectivity without the need to perform an explicit "fail over"
operation (which can introduce temporary packet loss and latency).

\m4_s2 hotlinkslogicalinterpretation Hotlinks: Logical Interpretation

Hotlinks operate on a \ref topicresolutiondomain ("TRD") basis.
Here is a typical hotlink topology:

\image html Hotlinks1.png
\image latex Hotlinks1.png

The primary job of the DRO is to connect TRDs together.
In the above diagram, messages for topic "XYZ" published by SRC1 are received
by RCV1, RCV2, and RCV3.

Let's consider RCV3.
There are two possible paths to get from SRC to RCV3:
transiting through TRD 98 and transiting through TRD 99.
If this were a normal (not hotlinked) DRO deployment, UM would determine
which path has the lowest cost and would route all messages through that path,
not using the other path at all.
With the hotlinks feature enabled, both DRO 1A and DRO 1B will create proxy
receivers for topic XYZ and both will forward every message across the
corresponding transit TRD to the destination.
Once in the destination TRD 3, both copies of each message are received by
the subscribing application RCV3, and UM will deliver the first one that
arrives and discard the second.

To enable the hotlinks feature, you must:
<ul>
<li>Define a \ref droelementhotlinkindex "hotlink index" and a
\ref droelementroutegroup "route group" on each hotlinked DRO's portal
connected to the datacenter (*not* the redundant WAN links).
(More information on these settings below.)
<li>Configure the \ref usehotlinksource "source" and
\ref usehotlinkreceiver "receiver" for "use_hotlink".
</ul>

A DRO is configured to operate in a hotlinked fashion by setting the
\ref droelementhotlinkindex "hotlink index".
When assigning hotlink index values,
each DRO operating in hotlinked mode must have different index value
for endpoint portals within a given TRD.
In the above diagram, DROs 1A and 1B must have different
index values. But they do not have to be unique across the entire network.
So the index values in one TRD can overlap with indices used in other TRDs.
Note that there is no need to use the same index value for the corresponding
DROs in each hotlinked TRD (i.e. DROs 1A, 2A, and 3A do not need to use the same indices).

The \ref droelementroutegroup "route group" values are intended to show
which DRO portals should operate in hotlink mode with respect to each other.
DROs 1A and 1B use the same route group, and therefore will operate in
hot-hot mode. This allows the mixing of multiple hotlink groups and
non-hotlinked DROs in the same TRD. See \ref mixingregularandhotlinkeddros.
The route group is only meaningful for DRO portals configured with a hotlink index.

\m4_s2 hotlinksphysicalinterpretation Hotlinks: Physical Interpretation

Normally there is no expectation of mapping between TRDs and the physical
entities (networks, datacenters, hosts).
The distribution of programs to TRDs is logical, not physical.
However, the hotlinks feature deviates from that pattern with the expectation
that TRDs map onto specific physical entities.
Here is the previous logical TRD network shown in its physical embodiment:
\image html Hotlinks2.png
\image latex Hotlinks2.png

The above diagram is a "dual hub with spokes" topology where the
two WAN-based TRDs are the hubs and the data centers are the spokes.
It is assumed that each data center's LAN uses LBT-RM (multicast)
transports, although this is not strictly necessary.

The publisher for topic "XYZ" (SRC1) is in datacenter 1.
It sends a single message via multicast onto LAN 1.
The subscriber "RCV1" will receive a copy of the message,
as will the two DROs labeled "1A" and "1B".
Those DROs will forward the message onto "WAN A" and "WAN B" respectively.
Now you have two copies of the message.
Let's follow the message into datacenter 2 via DROs "2A" and "2B".
Each DRO receives its respective copy of each message and forwards
it onto LAN 2.
Note there are still two copies of the message on LAN 2.
Finally receiver "RCV2" gets both copies of the message,
and UM's "hot failover" logic delivers the first one to the application
and discards the second one.

Note that the WAN TRDs can also use multicast,
or can be configured for unicast-only operation.
In fact, even the LANs can be used in unicast mode, although that
will force the publisher "SRC1" to send the message three times,
to RCV1, DRO 1A, and DRO 1B.

The benefit of the hotlinks feature is that if WAN A fails, the receivers for XYZ
will not detect any disruption or latency outliers - WAN B will continue
carrying the messages.
There is no "fail over" sequence.
A downside of this design is that the receivers will experience twice
the packet load.
However, also note that the second copy of each message is discarded
inside UM, so no application overhead is consumed.

The hotlinks feature is intended to
be used in deployments similar to the above diagram,
with DROs interconnecting multiple datacenters.
It is not designed to handle redundancy within a datacenter.

\m4_s2 exampledroconfiguration Example DRO Configuration

Here is the configuration for "DRO 1A" referenced in the previous
sections:
\verbatim
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
  <daemon>
    <name>dro_1A</name>
    <log type="console"/>
    <pidfile>dro_1A.pid</pidfile>
    <xml-config>um.xml</xml-config>
  </daemon>
  <portals>
    <endpoint>
      <name>TRD1</name>
      <domain-id>1</domain-id>
      <cost>1</cost>
      <hotlink-index>1</hotlink-index>
      <route-group>1</route-group>
      <lbm-attributes>
        <option name="context_name" scope="context" value="dro_1A-1"/>
      </lbm-attributes>
    </endpoint>
    <endpoint>
      <name>TRD98</name>
      <domain-id>98</domain-id>
      <cost>1</cost>
      <lbm-attributes>
        <option name="context_name" scope="context" value="dro_1A-98"/>
      </lbm-attributes>
    </endpoint>
  </portals>
</tnw-gateway>
\endverbatim

Some notes:

<ul>
<li>No peer link portals are used. Only endpoint portals.
<li>The portals' associated contexts are named so that the "um.xml"
file can configure the contexts independently by context name.
<li>Portal TRD1 has a \ref droelementhotlinkindex "hotlink index" defined.
Portal TRD98 does not. This is because messages published to TRD 98
should not be replicated by other DROs connected to TRD 98.
Only portals connected to TRDs 1, 2, and 3 should replicate messages.
</ul>

\m4_s2 hotlinksourcestrings Hotlink Source Strings

Most receiver events contain a \ref sourcestring field.
In a network using DROs, that source string can represent
the proxy source of an adjacent DRO (see \ref sourcestringsinaroutednetwork).
This proxy source string serves the same function of uniquely identifying
the source from the receiver's point of view.

However, when the hotlinks feature is enabled, multiple DRO proxy
sources can be associated with the same originating source.
Events carrying only the proxy source string cannot be correlated
to the same originating source using only the hotlinked DRO proxy sources.

So when a receiver has \ref usehotlinkreceiver enabled, receiver event
delivery is modified to use the originating source's source string as
the receiver event's "source" field.
Note that this is different from a non-hotlinked receiver which
delivers the source string of the adjacent DRO's proxy source.

This change is only apparent for receivers that are in a different TRD
than the originating source. For receivers in the same TRD, the
"source" field contains the originating source's source string for
both hotlink-enabled and non-hotlink-enabled receivers.

An additional enhancement to assist in correlating proxy sources with
their corresponding originating source is provided for the
\ref receiverbosandeosevents. The proxy source string is provided with
those two events.

In C, the BOS/EOS proxy source is provided in
\ref lbm_msg_t_stct::proxy_source.

In Java, the BOS/EOS proxy source is provided by
\ref com::latencybusters::lbm::LBMMessage::proxySource

\m4_s2 mixingregularandhotlinkeddros Mixing Regular and Hotlinked DROs

It is possible to extend the basic hotlinked hub-and-spoke topology.
This example is contrived to show three different less-common
use cases:
<ul>
<li>Critical vs. non-critical topics,
<li>Non-hotlinked data centers,
<li>Hotlinked spurs.
</ul>

\image html Hotlinks3.png
\image latex Hotlinks3.png

\anchor noncriticaltopics
<b>Non-Critical Topics</b>

This use case acknowledges the fact that hotlinked receivers can receive double the network traffic.
The advantage is high availability in the face of network failure. However, there are
use cases where only a subset of "critical" topics require high availability, while normal
"non-critical" topics can rely on \ref parallellinks with failover.

In the above diagram, TRD 1 has publishers of critical topics that end with "_crit" and other,
non-critical topics that do not end with "_crit". DRO 1B is configured to only forward topics
that end with "_crit" with the configuration:

\verbatim
<endpoint>
  ...
  <acl><inbound>
    <ace match="accept"><topic>.*_crit$</topic>
  </ace></inbound></acl>
  ...
</endpoint>
\endverbatim

Since topic "XYZ" does not end with "_crit", DRO 1B will not forward those messages.

Now look at DROs 1A1 and 1A2. Note that they are in different route groups.
Since they are configured as \ref parallellinks to TRD 98, they represent a hot/cold
failover pair. Only one will be active, which can be controlled with
\ref droelementcost. If the active DRO fails, a failover to the inactive
DRO will happen after a timeout. Topic "XYZ" will experience temporary
packet loss until the failover completes.

Now note that DRO 1B is in two route groups: 1 and 2.
This means that whichever of DROs 1A1 or 1A2 are active,
DRO 1B will act as a hotlinked pair to it.
For topics that end with "_crit", if DRO 1A1 fails, there will not be
packet loss since DRO 1B is replicating the traffic for those topics.

\anchor nonhotlinkeddatacenters
<b>Non-Hotlinked Data Centers</b>

TRD 200 is connected to TRD 2. But the connection is not
with two networks, so enabling hotlinks will not significantly
increase availability. To conserve bandwidth, DROs 2C and 2D are
not configured with hotlink indices or route groups. Thus,
2C and 2D act as a hot/cold failover pair. 

\anchor hotlinkedspur
<b>Hotlinked Spur</b>

TRD 300 is connected to TRD 3 with two independent networks,
but not the "main" world-wide networks embodied in transit TRDs 98 and 99.
It sets up a separate pair of hotlinked DROs, DRO 3C and 3D, in route group 2 (to separate
them from DROs 3A and 3B).
Thus, messages published from TRD 3 can be hotlinked down to TRDs 98 and 99,
and also hotlinked upward to TRD 300

\attention This configuration does not provide full connectivity.
Due to \ref drohotlinkrestrictions item 5, "No hotlink chains",
a publisher in TRD 1 will not have its messages forwarded all the way to TRD 300,
since it would have to transit two hotlinked hops.
For full connectivity, TRDs 1 and 2 would also have to have hotlinked DROs connecting
them to TRD 300. (Note that this restriction does not interfere with connectivity to
TRD 200 - TRD 1 can reach TRD 200 by transiting only a single hotlink hop.)

Finally, note also that DROs 3A and 3B do not use transit TRDs between TRDs 3 and 300.
Normally this would be done, but it was omitted to simplify the drawing.

\m4_s2 implementingdrohotlinks Implementing DRO Hotlinks

Applications do not need special source code to make use of hotlinks.
Contrast this with the \ref hotfailoverhf feature that requires the use
of special hot failover APIs.
Hotlinks use standard source APIs (but see \ref drohotlinkrestrictions),
and is enabled through
\ref usehotlinksource "source" and \ref usehotlinkreceiver "receiver"
configuration, and setting up DROs.

\m4_s2 drohotlinkrestrictions DRO Hotlinks Restrictions

<ul>
<li><b>XSP deletion</b> -
If using \ref transportservicesproviderxsp "XSPs" with hotlinked receivers, no XSPs can be deleted
until all receiver objects are deleted.
See \ref xsplimitations.

<li><b>No Hot Failover</b> -
The hotlinks feature is not compatible with regular \ref hotfailoverhf.
They are intended for different use cases and may not be used
in the same UM network.

<li><b>No Smart Sources</b> -
The hotlinks feature is not supported by \ref smartsources.

<li><b>Locate Stores in same TRD as source</b> -
Hotlinks supports UM's \ref persistence feature.
However, whereas a non-hotlinked DRO network allows Stores to be placed
anywhere in the network, the hotlink feature adds the restriction that the
Stores must be in the same TRD as the source.
Note that Informatica generally considers this restriction to be the best
practice except in certain limited use cases.

<li><b>No hotlink chains</b> -
Informatica only supports a single central redundant pair of networks using the
hotlinks feature.
UM does not support multiple hotlink hops
(<a href="https://ultramessaging.github.io/UM_Support.html">Contact UM Support</a>
for potential workarounds if this is necessary).
For example, this topology is not supported:
\image html Hotlinks_chains.png
\image latex Hotlinks_chains.png

</ul>

\m4_s1 routingtopologies Routing Topologies

You can configure multiple DROs in a variety of topologies.
Following are several examples.

\m4_s2 directlink Direct Link

The Direct Link configuration uses a single
DRO to directly connect two TRDs.
For a configuration example, see \ref directlinkconfiguration.

\image html direct_link.png
\image latex direct_link.png

\m4_s2 singlelink Single Link

A Single Link configuration connects two TRDs using a DRO on each end of
an intermediate link.
The intermediate link can be a "peer" link, or a
\ref transittrdlinkconfiguration "transit TRD".
For configuration examples,
see \ref peerlinkconfiguration and \ref transittrdlinkconfiguration.

\image html single_link.png
\image latex single_link.png

\m4_s2 parallellinks Parallel Links

Parallel Links offer multiple complete paths between two TRDs.
However, UM will not load-balance messages across both links.
Rather, parallel links are used for failover purposes.
You can set preference between the links by setting the primary path for the
lowest cost and standby paths at higher costs.
For a configuration example, see \ref parallellinksconfiguration.

\image html parallel_links.png
\image latex parallel_links.png

Note that if a DRO or network link fails, the failover action to the
parallel DRO can take several seconds, during which time messages are
not forwarded (loss).
They represent a hot/cold failover pair, with only one of them active.
See \ref drohotlinks for zero-loss hot/hot resilience.

\m4_s2 loops Loops

Loops let you route packets back to the originating DRO
without reusing any paths.
Also, if any peer-peer links are interrupted, the looped DROs
are able to find an alternate route between any two TRDs.

\image html loops.png
\image latex loops.png

\m4_s2 loopandspur Loop and Spur

The Loop and Spur has a one or more DROs tangential to the loop
and accessible only through a single DRO participating in the loop.
For a configuration example, see \ref loopandspurconfiguration.

\image html loop_and_spur.png
\image latex loop_and_spur.png

\m4_s2 loopwithcentralizedtrd Loop with Centralized TRD

Adding a TRD to the center of a loop enhances its rerouting capabilities.

\image html loop_central_trd.png
\image latex loop_central_trd.png

\m4_s2 Star Star with centralized TRD

A Star with a centralized TRD does not offer rerouting capabilities but
does provide an economical way to join multiple disparate TRDs.

\image html star_central_trd.png
\image latex star_central_trd.png

\m4_s2 starwithcentralizedumrouter Star with Centralized DRO

The Star with a centralized DRO is the simplest way to bridge
multiple TRDs.
For a configuration example, see \ref starconfiguration.

\image html star_central_dro.png
\image latex star_central_dro.png

\m4_s2 mesh Mesh

The Mesh topology provides peer portal interconnects between many DROs,
approaching an all-connected-to-all configuration.
This provides multiple possible paths between any two TRDs in the mesh.
Note that this diagram is illustrative of the ways the DROs may be interconnected,
and not necessarily a practical or recommended application.
For a configuration example, see \ref meshconfiguration.

\image html mesh.png
\image latex mesh.png

\m4_s2 palmtree Palm Tree

The Palm Tree has a set of series-connected TRDs fanning out to a more
richly meshed set of TRDs.
This topology tends to pass more concentrated traffic over common links for
part of its transit while supporting a loop, star, or mesh near its terminus.

\image html palm_tree.png
\image latex palm_tree.png

\m4_s2 dumbbell Dumbbell

Similar to the Palm Tree, the Dumbbell has a funneled route with a loop,
star, or mesh topology on each end.

\image html dumbell.png
\image latex dumbell.png

\m4_s1 unsupportedconfigurations Unsupported Configurations

When designing DRO networks,
do not use any of the following topology constructs.

Two peer-to-peer connections between the same two DROs:

\image html two_peers.png
\image latex two_peers.png

Two endpoint connections from the same DRO to the same TRD:

\image html two_endpoints.png
\image latex two_endpoints.png

Assigning two different Domain ID values (from different DROs) to the same TRD:

\image html two_domainids.png
\image latex two_domainids.png

\m4_s1 umfeaturecompatibility UM Feature Compatibility

You must install the UM Dynamic Routing Option with its companion Ultra
Messaging UMS, UMP, or UMQ product, and versions must match.
While most UM features are compatible with the DRO, some are not.
Following is a table of features and their compatibilities with the DRO.

<table>
<tr><th>UM Feature <th>DRO Compatible? <th>Notes
<tr><td>Connect and Disconnect Source Events <td>Yes, but see \ref sourceconnectanddisconnectevents <td>
<tr><td>\ref hotfailoverhf <td>Yes <td>The DRO can pass messages
sent by HF publishers to HF receivers, however the DRO itself cannot
be configured to originate or terminate HF data streams.
<tr><td>\ref hotfailoveracrossmultiplecontexts <td>Yes <td>
<tr><td>\ref latejoin <td>Yes <td>
<tr><td>\ref messagebatching <td>Yes <td>
<tr><td>Monitoring/Statistics <td>Yes <td>
<tr><td>\ref multicastimmediatemessaging (MIM) <td>Yes <td>
<tr><td>\ref offtransportrecoveryotr <td>Yes <td>
<tr><td>\ref ordereddelivery <td>Yes <td>
<tr><td>\ref predefinedmessages (PDM) <td>Yes <td>
<tr><td>\ref requestresponse <td>Yes <td>
<tr><td>\ref selfdescribingmessaging (SDM) <td>Yes <td>
<tr><td>\ref smartsources <td>Partial <td>
The DRO does not support proxy sources sending data via Smart
Sources.
The DRO does accept ingress traffic to proxy receivers sent by
Smart Sources.
<tr><td>Source Side Filtering <td>Yes <td>
The DRO supports transport source side filtering.
You can activate this either at the originating TRD source,
or at a downstream proxy source.
<tr><td>\ref sourcestring <td>Yes, but see \ref sourcestringsinaroutednetwork <td>
<tr><td>\ref grptransportacceleration "Transport Acceleration" <td>Yes <td>
<tr><td>\ref transportlbtipc <td>Yes <td>
<tr><td>\ref transportlbtrm <td>Yes <td>
<tr><td>\ref transportlbtru <td>Yes <td>
<tr><td>\ref transportlbtsmx <td>Partial <td>
The DRO does not support proxy sources sending data via LBT-SMX.
Any proxy sources configured for LBT-SMX will be converted to TCP,
with a log message warning of the transport change.
The DRO does accept LBT-SMX ingress traffic to proxy receivers.
<tr><td>\ref transporttcp <td>Yes <td>
<tr><td>\ref transportservicesproviderxsp <td>No <td>
<tr><td>JMS, via UMQ broker <td>No <td>
<tr><td>\ref spectrum <td>Yes <td>
The DRO supports UM Spectrum traffic, but you cannot
implement Spectrum channels in DRO proxy sources or receivers.
<tr><td>UMP Implicit and \ref explicitacknowledgments <td>Yes <td>
<tr><td>UMP Persistent Store <td>Yes <td>
<tr><td>UMP \ref persistenceproxysources <td>Yes <td>
<tr><td>UMP \ref quorumconsensusstorefailover <td>Yes <td>
<tr><td>UMP \ref managingregidswithsessionids <td>Yes <td>
<tr><td>UMP \ref receiverpacedpersistenceoperations (RPP) <td>Yes <td>
<tr><td>UMQ \ref umqoverview "Brokered Queuing" <td>No <td>
<tr><td>UMQ \ref ultraloadbalancingulb <td>No <td>
<tr><td>Ultra Messaging Desktop Services (UMDS) <td>Not for client
connectivity to the UMDS server <td>
<tr><td>Ultra Messaging Manager (UMM) <td>Yes <td> Not for DRO management
<tr><td>UM SNMP Agent <td>No <td>
<tr><td>UMCache <td>No <td>
<tr><td>\ref umwildcardreceivers <td>Yes <td>
<tr><td>Zero Object Delivery (ZOD) <td>Yes <td>
</table>

\m4_pg umrouterimplementation DRO Implementation

\m4_s1 umrouterconfigurationoverview DRO Configuration Overview

When the DRO daemon launches, it uses configuration option
settings to determine its behavior and expectations.
You specify option values in an XML configuration file,
and reference the file from a command line argument.

Typically, you have a separate XML configuration file for each DRO,
which contains structured configuration elements that describe aspects of the
DRO.
Within this XML configuration file, each endpoint portal definition points
to a UM configuration file, which allow the portal to properly connect to
its TRD.

\m4_s1 creatingapplicationsforumroutercompatibility Creating Applications for DRO Compatibility

When developing messaging applications that use Ultra Messaging and,
in particular, the DRO, please observe the following guidelines.

\m4_s2 namingandidentification Naming and Identification

An important part to successfully implementing DROs is prudent and
error-free naming of TRDs, DROs, portals, etc.,
as well as correct identification of IP addresses and ports.
It is good practice to first design the DRO network by defining all
connections and uniquely naming all DROs, portals, and TRDs.
This works well as a diagram similar to some examples presented in
this document.
Include the following names and parameters in your design diagram:

<ul>
<li>TRD names and IDs
<li>DRO names
<li>Portal names
<li>Portal costs
</ul>

For example, a well-prepared DRO design could look like the
following figure.

\image html design_diagram.png
\image latex design_diagram.png

\m4_s2 portalcosts Portal Costs

A network of DROs uses forwarding cost as the criterion for
determining the best (lowest cost) path over which to resolve a topic
and route data.
Forwarding cost is simply the sum of all portal costs along a multi-DRO path.
Thus, total cost for the single path in the above example is 34.
(Note that this is a non-real-world example,
since costs are pointless without alternate routes to compare to.)
You assign portal costs via the `<cost>` configuration option.

After the DRO network calculates its paths, if a new lower-cost
source becomes available, receivers switch to that path.

\m4_s2 accesscontrollistsacl Access Control Lists (ACL)

In the DRO, an Access Control List (ACL) is a method of blocking
traffic from being forwarded from one TRD to another.

Typical applications for this feature are:
<ul>
<li>Prevent unauthorized access to sensitive messages.
<li>Prevent overloading of bandwidth-limited WAN links,
even in the face of accidental use of overly-permissive wildcard receivers.
<li>ACLs can be used to limit the amount of Topic Resolution traffic
for topics on TRDs that don't need those topics.
However, the use of wildcard receivers can result in TR traffic even for
topics which are blocked from being forwarded.
</ul>

You can apply Access Control Lists to one or more of a DRO's
portals to filter traffic by topic, transport, transport session, etc.
You configure an ACL in a DRO's XML configuration's
\ref droelementacl "<acl>" element,
as a child of an \ref droelementendpoint "<endpoint>" or
\ref droelementpeer "<peer>" portal.
As messages are processed by the DRO,
the portals use the ACLs to decide whether to reject the the messages or
accept them.

<b>Inbound vs. Outbound</b>

There are two types of ACLs: inbound and outbound.

\image html acl.png
\image latex acl.png

An inbound ACL tests messages from a source TRD on their way into a DRO portal,
and decides whether to reject or accept them. If accepted, the messages can
be forwarded to the appropriate destination portal(s).

An outbound ACL tests messages on their way out of a DRO portal,
and decides whether to reject them, or transmit them to the destination TRD.

This distinction becomes especially important when a DRO has more than two
portals.
Messages rejected <i>inbound</i> cannot be forwarded at all.
Messages rejected <i>outbound</i> can allow messages to be forwarded out
some portals but not others.

An ACL contains one or more Access Control Entries (ACEs).

<b>Access Control Entry (ACE)</b>

An ACE specifies a set of message matching criteria,
and an action to perform based on successful matches.
The action is either accept (the message is made available for forwarding,
based on interest) or reject (the message is dropped).

When more than one ACE is supplied in an ACL,
messages are tested against each ACE in the order defined until a match is
found, at which point the ACE specifies what to do (reject or accept).

An ACE contains one or more conditional elements.

<b>Conditional Elements</b>

Conditional elements do the work of testing various characteristics of
messages to determine if they should be rejected or accepted (made
available for forwarding).

When more than one conditional element is supplied in an ACE,
received messages are tested against all of them to determine if the
ACE should be applied.

There are two classes of conditional elements:
<ul>
<li>Topic conditionals, which test the topic string of a message.
<li>Transport session conditionals, which test network transport session
characteristics of a message.
</ul>

Topic conditionals can be included on both inbound and outbound ACLs.
The topic conditionals are:
<ul>
<li>\ref droelementtopic "<topic>" - tests for a specific topic name
of messages,
<li>\ref droelementpcrepattern "<pcre-pattern>" - matches a group of topics
according to a regular expression pattern,
<li>\ref droelementregexpattern "<regex-pattern>" - deprecated, use
\ref droelementpcrepattern "<pcre-pattern>" instead.
</ul>

Transport session conditionals only apply to inbound ACLs
(they are ignored for outbound).
The transport session conditionals are:
<ul>
<li>\ref droelementtransport "<transport>" - tests the transport
type of messages.
<li>\ref droelementsourceip "<source-ip>" - tests the IP address of the
source or proxy source of messages.
<li>\ref droelementmulticastgroup "<multicast-group>" - tests the destination
multicast group of LBT-RM messages.
<li>\ref droelementudpdestinationport "<udp-destination-port>" - tests the
destination port of LBT-RM messages.
<li>\ref droelementudpsourceport "<udp-source-port>" - tests the source port
of LBT-RM and LBT-RU messages.
<li>\ref droelementtcpsourceport "<tcp-source-port>" - tests the source port
of TCP messages.
<li>\ref droelementxportid "<xport-id>" - tests the transport ID of
LBT-IPC messages.
</ul>

Conditional elements are children of the \ref droelementace "<ace>" element.
If you place multiple conditions within an ACE,
the DRO performs an "and" operation with them. That is, all relevant conditions
in the ACE must be true for the ACE to be applied to a message.

A portal will silently ignore conditional elements that don't apply.
For example, if a transport conditional is used on an outbound ACL,
or if a UDP-based conditional is present and a TCP message is received.

<b>Reject by Default</b>

An implicit "reject all" is at the end of every ACL,
so the DRO rejects any topic not matched by any ACE.
When an ACL is configured for a portal,
rejection is the default behavior.

For example, to accept and forward only messages for topic ABC
and reject all others:
\code
        <acl>
          <inbound>
            <ace match="accept">
              <topic>ABC</topic>
            </ace>
          </inbound>
        </acl>
\endcode
No "reject" ACE is needed since rejection is the default.

In contrast, to accept all messages <i>except</i> for topic ABC:
\code
        <acl>
          <inbound>
            <ace match="reject">
              <topic>ABC</topic>
            </ace>
            <ace match="accept">
              <topic>.*</topic>
            </ace>
          </inbound>
        </acl>
\endcode
The second ACE is used as a "match all", which effectively changes the
default behavior to "accept".

<b>ACE Ordering</b>

Since the behavior for multiple ACEs is to test them in the order defined,
ACEs should be ordered from specific to general.

In the example below, a user named "user1" is assigned to the LAN1 TRD.
It is desired to forward all non-user-specific messages,
but restrict user-specific message to only that user.

By ordering the ACEs as shown, messages for USER.user1 will be forwarded
by the first ACE, but messages for USER.user2, etc. will be rejected due to
the second ACE. Messages for topics not starting with "USER." will be
forwarded by the third ACE.

\code
    <endpoint>
      <name>LAN1</name>
      <lbm-config>lan1.cfg</lbm-config>
      <domain-id>1</domain-id>
        <acl>
          <inbound>
            <ace match="accept">
              <topic>USER.user1</topic>
            </ace>
            <ace match="reject">
              <pcre-pattern>^USER\..*</pcre-pattern>
            </ace>
            <ace match="accept">
              <pcre-pattern>.*</pcre-pattern>
            </ace>
          </inbound>
        </acl>
    </endpoint>
\endcode

Note that the string in "<topic>USER.user1</topic>" is not a regular
expression pattern, and therefore does not need any special escaping or
meta characters.
The "<pcre-pattern>^USER\..*</pcre-pattern>" is a regular expression,
and therefore needs the "^" anchor and the "\." escape sequence.

\m4_s2 timersandintervals Timers and Intervals

The DRO offers a wide choice of timer and interval options
to fine tune its behavior and performance.
There are interactions and dependencies between some of these,
and if misconfigured, they may cause race or failure conditions.

This manual's description of configuration options
(see \ref xmlconfigurationreference),
includes identification of such relationships.
Please heed them.

\m4_s2 multicastimmediatemessagingconsiderations Multicast Immediate Messaging Considerations

Multicast Immediate Messages (MIMs) may pass through the DRO.
You cannot filter MIMs with Access Control Lists (ACL)-MIMs
are forwarded to all TRDs.
Informatica does not recommend using MIM for messaging traffic across
the DRO.
MIM is intended for short-lived topics and applications that cannot tolerate
a delay between source creation and the sending of the first message.
See also \ref multicastimmediatemessaging.

\m4_s2 persistenceovertheumrouter Persistence Over the DRO

The DRO supports UMP persistence by routing all necessary control and
retransmission channels along with transport and topic resolution traffic.
A typical implementation places the UMP persistent store in the same TRD as
its registered source, as shown in the following figure.

\image html persist_1.png
\image latex persist_1.png

The DRO also supports UMP implementations with the store located
in a receiver's TRD, as shown in the following figure.

\image html persist_2.png
\image latex persist_2.png

Note: For more reliable operation when using UMP with DROs,
Informatica recommends enabling OTR.

\m4_s2 latejoinandofftransportrecovery Late Join and Off-Transport Recovery

The DRO supports sources and receivers configured for Late Join
and/or Off-Transport Recovery (OTR).
Retransmission requests and subsequent retransmissions are conducted
across the entire path through the DRO network.
A DRO's proxy sources do not have Late-Join/OTR retention
buffers and hence, are not able to provide recovered messages.

\m4_s2 topicresolutionreliability Topic Resolution Reliability

Topic resolution can sometimes remain in a quiescent phase due to link
interruption, preventing needed re-subscription topic resolution activity.
Two ways you can address this are:

<ul>
<li>For isolated incidents,
call lbm_context_topic_resolution_request() (see example lbmtrreq.c).
This restarts the sustaining phase.
<li>For more chronic problems, such as a DRO link
(especially an endpoint link) over a WAN of questionable reliability,
consider configuring Topic resolution to stay in the sustaining phase
(options \ref resolveradvertisementminimumsustaindurationsource and
\ref resolverqueryminimumsustaindurationreceiver).
</ul>

\m4_s2 bosandeosbehaviorovertheumrouter BOS and EOS Behavior Over the DRO

Through a network of DROs, a topic traverses a separate session
for each link along its path.
Thus, the DRO reports BOS/EOSs based on the activity between the
proxy source transport and its associated receiver.
There is no end-to-end,
application-to-application reporting of the data path state.
Also, in the case of multiple topics being assigned to multiple sessions,
topics may find themselves with different session mates from hop to hop.
Of course, this all influences when, and for which transport session,
a topic's BOSs and EOSs are issued.

\m4_s2 umrouterreliableloss DRO Reliable Loss

The DRO can create a situation where a "reliable" transport (TCP
or LBT-IPC) can experience out-of-order message delivery.

The DRO can perform a "protocol conversion" function.
I.e. an originating source can use a UDP-based protocol (LBT-RM or LBT-RU),
but the proxy source for a remote receiver can use a "reliable"
protocol (TCP or LBT-IPC).
With a UDP-based protocol, messages can arrive to the DRO network
out of order, usually due to packet loss and recovery.
However, when those out-of-order messages are forwarded across a
"reliable" protocol (TCP or LBT-IPC), the receiver does not expect
the sequence number gap, and immediately declares the out-of-order messages
as unrecoverable loss.
This, in spite of the fact that the missing message arrives shortly
thereafter.

Starting in UM version 6.12, there are two new configuration options:
\ref transporttcpdrolossrecoverytimeoutreceiver and
\ref transportlbtipcdrolossrecoverytimeoutreceiver,
which modify the receiver's behavior.
Instead of declaring a gap immediately unrecoverable,
a delay is introduced which is similar to what a UDP-based receiver
uses to wait for lost and retransmitted datagrams.
If the missing message arrives within the delay time,
the messages are delivered to application without loss.

Be aware that this functionality is only used with "reliable" protocols
published by a DRO's proxy source.
If this delay feature is enabled, it will <em>not</em> apply to a "reliable"
protocol that is received directly from the originating source.

Note however that you can get genuine gaps in the "reliable" data stream
<i>without</i> recovery.
For example, an overloaded DRO can drop messages.
Or a DRO's proxy receiver can experience unrecoverable loss.
In that case, the delay will have to expire before the missing
messages are declared unrecoverable and subsequent data is delivered.

\attention The delay times default to 0, which retains the pre-6.12
behavior of immediately declaring sequence number gaps unrecoverable.
If you want this new behavior, you must configure the appropriate option.

\m4_s1 topologyconfigurationexamples Topology Configuration Examples

Following are example configurations for a variety of DRO topologies.
These are the topology examples presented \ref routingtopologies.

In a real-world situation, you would have DRO XML configuration files
with their portal interfaces referencing complete UM configuration files.
However, for these examples, the referred domain configuration files are
simplified to contain only information relevant to the applicable DRO.
As part of this simplification, domain configuration files show interfaces
for only one or two transport types.

Also, IP addresses are provided in some cases and omitted in other cases.
This is because initiator peer portals need to know the IP addresses (and
port numbers) of their corresponding acceptor portals to establish connections,
whereas endpoint portals communicate via topic resolution and thus,
do not need to know IP addresses.

\note Before designing any DRO implementations based on configurations
or examples other than the types presented in this document,
please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\m4_s2 directlinkconfiguration Direct Link Configuration

This example uses a DRO to connect two topic resolution domain LANs.

\image html cfg_direct_link.png
\image latex cfg_direct_link.png

\b TRD1 \b Configuration

This UM configuration file, trd1.cfg,
describes TRD1 and is referenced in the DRO configuration file.

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

This DRO configuration file defines two endpoint portals.
In the daemon section,
we have turned on monitoring for the all endpoint portals in the DRO.
The configuration specifies that all statistics be collected every 5 seconds
and uses the lbm transport module to send statistics to your monitoring
application, which runs in TRD1.
See also UM Concepts, Monitoring UMS.
The Web Monitor has also been turned on (port 15304)
to monitor the performance of the DRO.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<!-- G1 xml file- 2 endpoint portals -->
<tnw-gateway version="1.0">
  <daemon>
    <log type="console"/>
    <lbm-license-file>lic0014.txt</lbm-license-file>
    <monitor interval="5">
      <transport-module module="lbm" options="config=trd1.cfg"/>
    </monitor>
    <web-monitor>*:15304</web-monitor>
  </daemon>
  <portals>
    <endpoint>
      <name>G1-TRD1</name>
      <domain-id>1</domain-id>
      <lbm-config>trd1.cfg</lbm-config>
    </endpoint>
    <endpoint>
      <name>G1-TRD2</name>
      <domain-id>2</domain-id>
      <lbm-config>trd2.cfg</lbm-config>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

The configuration file trd2.cfg could look something like this.

\code
# Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\m4_s2 peerlinkconfiguration Peer Link Configuration

In cases where the DRO connection between two TRDs must tunnel
through a WAN or TCP/IP network, you can implement a DRO at each end,
as shown in the example below.

\image html cfg_single_link.png
\image latex cfg_single_link.png

\b TRD1 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

Following is an example of two companion peer portals (on different DROs)
configured via DRO XML configuration file for a TCP-only setup.
Note that one must be an initiator and the other, an acceptor.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
       <log type="console"/>
    </daemon>
    <portals>
       <endpoint>
          <name>G1-TRD1</name>
          <domain-id>1</domain-id>
          <lbm-config>TRD1.cfg</lbm-config>
       </endpoint>
       <peer>
          <name>G1-G2</name>
          <single-tcp>
             <interface>10.30.3.100</interface>
             <initiator>
                <address>10.30.3.102</address>
                <port>26123</port>
             </initiator>
          </single-tcp>
       </peer>
    </portals>
</tnw-gateway>
\endcode

\b G2 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G2-G1</name>
         <single-tcp>
           <interface>10.30.3.102</interface>
           <acceptor>
             <listen-port>26123</listen-port>
           </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G2-TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

\code
## LAN2 Configuration Options ##
context request_tcp_interface 10.33.3.0/24
context resolver_multicast_port 13965
\endcode

\m4_s2 transittrdlinkconfiguration Transit TRD Link Configuration

This example, like the previous one,
configures two localized DROs tunneling a connection between two TRDs,
however, the DROs in this example are tunneling through an
intermediate TRD.
This has the added effect of connecting three TRDs.

\image html cfg_transit_trd.png
\image latex cfg_transit_trd.png

\b TRD1 \b Configuration

\code
## TRD1 Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

Following is an example of two companion peer portals (on different DROs)
configured via DRO XML configuration file for a TCP-only setup.
Note that one must be an initiator and the other, an acceptor.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <endpoint>
         <name>G1-TRD1</name>
         <domain-id>1</domain-id>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
      <endpoint>
         <name>G1-TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

\code
## TRD2 Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\b G2 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <endpoint>
         <name>G2-TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
      <endpoint>
         <name>G2-TRD3</name>
         <domain-id>3</domain-id>
         <lbm-config>TRD3.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b TRD3 \b Configuration

\code
## TRD3 Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.3.37.85
\endcode

\m4_s2 parallellinksconfiguration Parallel Links Configuration

This example is similar in purpose to the single link, peer-to-peer example,
except that a second pair of DROs is added as a backup route.
You can set one of these as a secondary route by assigning a higher cost
to portals along the path.
In this case we set G3 and G4's portal costs to 5,
forcing the lower route to be selected only if the upper (G1, G2) route fails.

Also note that we have configured the peer portals for the
leftmost or odd-numbered DROs as initiators,
and the rightmost or even-numbered DRO peers as acceptors.

\image html cfg_parallel.png
\image latex cfg_parallel.png

\b TRD1 \b Configuration

\code
## TRD1 Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <endpoint>
         <name>G1-TRD1</name>
         <domain-id>1</domain-id>
         <cost>2</cost>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G1-G2</name>
         <cost>2</cost>
         <single-tcp>
            <interface>10.30.3.101</interface>
            <initiator>
               <address>10.30.3.102</address>
               <port>23745</port>
            </initiator>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b G2 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G2-G1</name>
         <cost>2</cost>
         <single-tcp>
            <interface>10.30.3.102</interface>
            <acceptor>
               <listen-port>23745</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G2-TRD2</name>
         <domain-id>2</domain-id>
         <cost>2</cost>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b G3 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <endpoint>
         <name>G3-TRD1</name>
         <domain-id>1</domain-id>
         <cost>5</cost>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G3-G4</name>
         <cost>5</cost>
         <single-tcp>
            <interface>10.30.3.103</interface>
            <initiator>
               <address>10.30.3.104</address>
               <port>23746</port>
            </initiator>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b G4 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G4-G3</name>
         <cost>5</cost>
         <single-tcp>
            <interface>10.30.3.104</interface>
            <acceptor>
               <listen-port>23746</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G4-TRD2</name>
         <domain-id>2</domain-id>
         <cost>5</cost>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

\code
## TRD2 Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\m4_s2 loopandspurconfiguration Loop and Spur Configuration

\image html cfg_loop_spur.png
\image latex cfg_loop_spur.png

\b TRD1 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G1_to_G3</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.27</address>
               <port>23801</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G1_to_G2</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.26</address>
               <port>23745</port>
            </initiator>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G1_to_TRD1</name>
         <domain-id>1</domain-id>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b G2 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G2_to_G4</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.28</address>
               <port>23632</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G2_to_G1</name>
         <single-tcp>
            <acceptor>
               <listen-port>23745</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G2_to_TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\b TRD3 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.3.37.85
\endcode

\b G3 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G3_to_G4</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.28</address>
               <port>23754</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G3_to_G1</name>
         <single-tcp>
            <acceptor>
               <listen-port>23801</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G3_to_TRD3</name>
         <domain-id>3</domain-id>
         <lbm-config>TRD3.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b G4 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G4_to_G3</name>
         <single-tcp>
            <acceptor>
               <listen-port>23754</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G4_to_TRD4</name>
         <domain-id>4</domain-id>
         <lbm-config>TRD4.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G4_to_G2</name>
         <single-tcp>
            <acceptor>
               <listen-port>23632</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G4_to_G5</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.29</address>
               <port>23739</port>
            </initiator>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b TRD4 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.4.37.85
\endcode

\b G5 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <endpoint>
         <name>G5_to_TRD5</name>
         <domain-id>5</domain-id>
         <lbm-config>TRD5.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G5_to_G4</name>
         <single-tcp>
            <acceptor>
               <listen-port>23739</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b TRD5 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.5.37.85
\endcode

\m4_s2 starconfiguration Star Configuration

This network consists of four TRDs.
Within each TRD, full multicast connectivity exists.
However, no multicast connectivity exists between the four TRDs.

\image html cfg_star.png
\image latex cfg_star.png

\b G1 \b Configuration

The configuration for this DRO also has transport statistics monitoring
and the WebMonitor turned on.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<!-- UM GW xml file- 3 endpoint portals -->
<tnw-gateway version="1.0">
  <daemon>
    <log type="console"/>
    <lbm-license-file>lic0014.txt</lbm-license-file>
    <monitor interval="5">
      <transport-module module="lbm" options="config=trd1.cfg"/>
    </monitor>
    <web-monitor>*:15304</web-monitor>
  </daemon>
  <portals>
    <endpoint>
      <name>G1_to_TRD1</name>
      <domain-id>1</domain-id>
      <lbm-config>trd1.cfg</lbm-config>
    </endpoint>
    <endpoint>
      <name>G1_to_TRD2</name>
      <domain-id>2</domain-id>
      <lbm-config>trd2.cfg</lbm-config>
    </endpoint>
    <endpoint>
      <name>G1_to_TRD3</name>
      <domain-id>3</domain-id>
      <lbm-config>trd3.cfg</lbm-config>
    </endpoint>
    <endpoint>
      <name>G1_to_TRD4</name>
      <domain-id>4</domain-id>
      <lbm-config>trd4.cfg</lbm-config>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode

\b TRD1 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b TRD2 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\b TRD3 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.3.37.85
\endcode

\b TRD4 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.4.37.85
\endcode

\m4_s2 meshconfiguration Mesh Configuration

The mesh topology utilizes many connections between many nodes,
to provide a variety of alternate routes.
However, meshes are not the best solution in many cases,
as unneeded complexity can increase the chance for configuration errors
or make it more difficult to trace problems.

\image html cfg_mesh.png
\image latex cfg_mesh.png

\b TRD1 \b Configuration

\code
### Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.1.37.85
\endcode

\b G1 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G1_to_G5</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.105</address>
               <port>23880</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G1_to_G4</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.104</address>
               <port>23801</port>
            </initiator>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G1_to_TRD1</name>
         <domain-id>1</domain-id>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
      <endpoint>
         <name>G1_to_TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G1_to_G2</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.102</address>
               <port>23745</port>
            </initiator>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b G2 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G2_to_G5</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.105</address>
               <port>23608</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G2_to_G4</name>
         <single-tcp>
            <acceptor>
               <listen-port>23831</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G2_to_G1</name>
         <single-tcp>
            <acceptor>
               <listen-port>23745</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G2_to_G3</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.103</address>
               <port>23632</port>
            </initiator>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G2_to_TRD2</name>
         <domain-id>2</domain-id>
         <lbm-config>TRD2.cfg</lbm-config>
      </endpoint>
    </portals>
</tnw-gateway>
\endcode

\b G3 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G3_to_G5</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.105</address>
               <port>23739</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G3_to_G4</name>
         <single-tcp>
            <acceptor>
               <listen-port>23754</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G3_to_G2</name>
         <single-tcp>
            <acceptor>
               <listen-port>23632</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b TRD2 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.2.37.85
\endcode

\b TRD3 \b Configuration

\code
## Global Configuration Options ##
context request_tcp_interface 10.29.3.0/24
context resolver_multicast_port 13965
context resolver_multicast_interface 10.29.3.0/24
context resolver_multicast_address 225.3.37.85
\endcode

\b G4 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G4_to_G5</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.105</address>
               <port>23580</port>
            </initiator>
         </single-tcp>
      </peer>
      <endpoint>
         <name>G4_to_TRD1</name>
         <domain-id>1</domain-id>
         <lbm-config>TRD1.cfg</lbm-config>
      </endpoint>
      <endpoint>
         <name>G4_to_TRD3</name>
         <domain-id>3</domain-id>
         <lbm-config>TRD3.cfg</lbm-config>
      </endpoint>
      <peer>
         <name>G4_to_G1</name>
         <single-tcp>
            <acceptor>
               <listen-port>23801</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G4_to_G3</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.103</address>
               <port>23754</port>
            </initiator>
         </single-tcp>
      </peer>
      <peer>
         <name>G4_to_G2</name>
         <single-tcp>
            <initiator>
               <address>55.55.10.102</address>
               <port>23831</port>
            </initiator>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\b G5 \b Configuration

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
    <daemon>
        <log type="console"/>
    </daemon>
    <portals>
      <peer>
         <name>G5_to_G4</name>
         <single-tcp>
            <acceptor>
               <listen-port>23580</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G5_to_G1</name>
         <single-tcp>
            <acceptor>
               <listen-port>23880</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G5_to_G3</name>
         <single-tcp>
            <acceptor>
               <listen-port>23739</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
      <peer>
         <name>G5_to_G2</name>
         <single-tcp>
            <acceptor>
               <listen-port>23608</listen-port>
            </acceptor>
         </single-tcp>
      </peer>
    </portals>
</tnw-gateway>
\endcode

\m4_s1 usingumconfigurationfileswiththeumrouter Using UM Configuration Files with the DRO

Within the DRO configuration file, the endpoint portal's `<lbm-config>`
element lets you import configurations from either a plain text or XML
UM configuration file.
However, using the XML type of UM configuration files provides the
following advantages over plain text UM configuration files:

<ul>
<li>You can apply UM attributes per topic and/or per context.
<li>You can apply attributes to all portals on a particular DRO using
a UM XML template (instead of individual portal settings).
<li>Using UM XML templates to set options for individual portals lets
the DRO process these settings in the `<daemon>` element instead of
within each portal's configuration.
</ul>

\m4_s2 settingindividualendpointoptions Setting Individual Endpoint Options

When setting endpoint options,
first name the context of each endpoint in the
DRO's XML configuration file.

\code
<portals>
  <endpoint>
    <name>Endpoint_1</name>
    <domain-id>1</domain-id>
    <source-context-name>G1_E1</source-context-name>
    <lbm-attributes>
      <option name="request_tcp_interface" scope="context" value="10.29.4.0/24"/>
    </lbm-attributes>
  </endpoint>
  <endpoint>
    <name>G1-TRD2</name>
    <domain-id>2</domain-id>
    <receiver-context-name>G1_E2</source-context-name>
    <lbm-attributes>
      <option name="request_tcp_interface" scope="context" value="10.29.5.0/24" />
    </lbm-attributes>
  </endpoint>
</portals>
\endcode

Then assign configuration templates to those contexts in the UM XML
configuration file.

\code
<application name="dro1" template="global">
  <contexts>
    <context name="G1_E1" template="G1-E1-options">
      <sources />
    </context>
    <context name="G1_E2" template="G1-E2-options">
      <sources />
    </context>
  </contexts>
</application>
\endcode

You specify the unique options for each of this DRO's two endpoints
in the UM XML configuration `<templates>` section used for G1-E1-options and
G1-E2-options.

\m4_s2 umrouterandumxmlconfigurationusecases DRO and UM XML Configuration Use Cases

One advantage of using UM XML configuration files with the DRO is
the ability to assign unique UM attributes to the topics and contexts used
for the proxy sources and receivers (which plain text UM configuration
files cannot do).
The following example shows how to assign a different LBTRM multicast
address to a source based on its topic.

Create a new UM XML configuration template for the desired topic name.

\code
<template name="AAA-template">
  <options type="source">
    <option name="transport_lbtrm_multicast_address"
    default-value="225.2.37.88"/>
  </options>
</template>
\endcode

Then include this template in the `<application>` element
associated with the DRO.

\code
<application name="dro1" template="global-options">
  <contexts>
    <context>
      <sources template="source-options">
        <topic topicname="AAA" template="AAA-template" />
      </sources>
    </context>
  </contexts>
</application>
\endcode

It is also possible to assign UM attributes directly in the `<application>` tag.
For example, the following specifies that a particular topic should use
an LBT-RU transport.

\code
<application name="dro1" template="dro1-common">
  <contexts>
    <context>
      <sources template="source-template">
        <topic topicname="LBTRU_TOPIC">
          <options type="source">
            <option name="transport" default-value="lbtru" />
            </options>
        </topic>
      </sources>
    </context>
  </contexts>
</application>
\endcode

\m4_s2 sampleconfiguration Sample Configuration

The following sample configuration incorporates many of the examples
mentioned above.
The DRO applies options to all UM objects created.
The UM XML configuration file overwrites these options for two specific topics.
The first topic, LBTRM_TOPIC, uses a different template to change its
transport from TCP to LBTRM, and to set an additional property.
The second topic, LBTRU_TOPIC,
also changes its transport from TCP to a new value.
However, its new attributes are applied directly in its associated topic tag,
instead of referencing a template.
In addition, this sample configuration assigns the rm-source template to all
sources and receivers associated with the context endpt_1.

\m4_s2 xmlumconfigurationfile XML UM Configuration File

\code
<?xml version="1.0" encoding="UTF-8" ?>
<um-configuration version="1.0">
  <templates>
    <template name="dro1-common">
      <options type="source">
        <option name="transport" default-value="tcp" />
      </options>
      <options type="context">
        <option name="request_tcp_interface" default-value="10.29.5.6" />
        <option name="transport_tcp_port_low" default-value="4400" />
        <option name="transport_tcp_port_high" default-value="4500" />
        <option name="resolver_multicast_address" default-value="225.2.37.88"/>
      </options>
    </template>
    <template name="rm-source">
      <options type="source">
        <option name="transport" default-value="lbtrm" />
        <option name="transport_lbtrm_multicast_address" default-value="225.2.37.89"/>
      </options>
    </template>
  </templates>
  <applications>
    <application name="dro1" template="dro1-common">
     <contexts>
        <context>
          <sources>
            <topic topicname="LBTRM_TOPIC" template="rm-source" />
            <topic topicname="LBTRU_TOPIC">
              <options type="source">
                <option name="transport" default-value="lbtru" />
                <option name="resolver_unicast_daemon" default-value="10.29.5.1:1234" />
              </options>
            </topic>
          </sources>
        </context>
        <context name="endpt_1">
          <sources template="rm-source"/>
        </context>
      </contexts>
    </application>
  </applications>
</um-configuration>
\endcode

\m4_s2 xmlumrouterconfigurationfile XML DRO Configuration File

This DRO uses the above XML UM configuration file, sample-config.xml,
to set its UM options.
It has three endpoints, one of which has the context endpt_1.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
  <daemon>
    <log type="console"/>
    <xml-config>sample-config.xml</xml-config>
  </daemon>
  <portals>
    <endpoint>
      <name>Endpoint_1</name>
      <domain-id>1</domain-id>
      <lbm-attributes>
        <option name="context_name" scope="context" value="endpt_1" />
        <option name="request_tcp_interface" scope="context"
        value="10.29.4.0/24"/>
      </lbm-attributes>
    </endpoint>
    <endpoint>
      <name>Endpoint_2</name>
      <domain-id>2</domain-id>
      <lbm-attributes>
        <option name="request_tcp_interface" scope="context"
        value="10.29.5.0/24"/>
      </lbm-attributes>
    </endpoint>
    <endpoint>
      <name>Endpoint_3</name>
      <domain-id>3</domain-id>
      <lbm-attributes>
        <option name="request_tcp_interface" scope="context"
        value="10.29.6.0/24"/>
      </lbm-attributes>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode

\m4_s1 runningtheumrouterdaemon Running the DRO Daemon

To run the DRO, ensure the following:

<ul>
<li>Library environment variable paths are set correctly (LD_LIBRARY_PATH)
<li>The license environment variable LBM_LICENSE_FILENAME points to a
valid DRO license file.
<li>The configuration file is error free.
</ul>

Typically, you run the DRO with one configuration file argument,
for example:

\code
tnwgd gw1-config.xml
\endcode
(FYI: "tnwgd" stands for "Twenty Nine West Gateway Daemon",
a historical name for the DRO.)

The DRO logs version information on startup.
The following is an example of this information:

\code
Version 6.0 Build: Sep 26 2012, 00:31:33 (UMS 6.0 [UMP-6.0] [UMQ-6.0] [64-bit] Build: Sep 26 2012, 00:27:17 ( DEBUG license LBT-RM LBT-RU LBT-IPC LBT-RDMA ) WC[PCRE 7.4 2007-09-21, regex, appcb] HRT[gettimeofday()])
\endcode

\m4_s1 dronattransit DRO NAT Transit

Some networks make use of a \ref glossarynat "NAT router" to map one
IP address space onto another.
If your network architecture includes LANs that are bridged with
a NAT device, UM receivers will usually not be able to
connect directly to UM sources across the NAT.
Sources send Topic Resolution advertisements containing their local
IP addresses and ports, but receivers on the other side of the NAT
cannot access those sources using those local addresses/ports.
They must use alternate addresses/ports, which the NAT forwards according
to the NAT's configuration.

The recommended method of transiting a NAT is using two DROs connected via
a \ref peerlinkconfiguration "peer link".
The UM components in one network are organized as one
\ref topicresolutiondomain "TRD" and the components in the other network
are organized as a separate TRD.

There is an alternative method of transiting a NAT with UM
\ref networkaddresstranslationnat "using an lbmrd".
This method reduces latency but has significant
\ref lbmrdnatrestrictions "restrictions".

\m4_s2 dronattcppeer DRO NAT: TCP Peer

The simplest way to transit a NAT is to configure the DROs with
\ref droelementsingletcp.
One DRO is configured to be the \ref droelementinitiator "initiator" and the
other is the \ref droelementacceptor "acceptor".

Many NAT designs restrict which network can initiate TCP connections across
the NAT.
The initiator DRO should be placed on the side that supports outgoing
connections and configured for the IP address and port that the NAT
router recognizes and forwards to the acceptor DRO.
This may or may not be the IP address and port of the actual host running
the acceptor DRO; contact your network support group for details.

\m4_s2 dronattcpudppeer DRO NAT: UDP Peer

DROs are sometimes configured to add
\ref udppeerlink "UDP-based data transport".
The TCP link is still used for command and control,
so all the points made \ref dronattcppeer "above" still apply.
In addition, the NAT must allow forwarding of bi-directional UDP traffic
without modifying the destination port numbers.

Here's the sequence of events UM uses to establish communication:
<ol>
<li>The initiator DRO uses the configured address:port to initiate its TCP
connection.
Once established, the initiator sends DRO the UDP port it's
accepting data on.

<li>The acceptor DRO accepts the TCP connection, saves the UDP port
of the initiator, and sends back it's own UDP port.
The acceptor also examines the established TCP connection to determine the
IP address of the initiator, and saves that.
But note that due to the NAT, the IP address it determines will typically
not be the initiator's host IP.
Rather, it's an IP address of the NAT device, and the NAT will forward packets to
the actual host running the initiator.

<li>The initiator receives the acceptor's UDP port and saves it.

<li>Now, when the initiator wants to send UDP data to the acceptor,
it uses the configured IP and the saved UDP port as the UDP packet's
destination IP/port.

<li>When the acceptor wants to send UDP data to the initiator,
it uses the saved IP and UDP port.
</ol>

Thus, for both the initiator and the acceptor, the configured UDP port
is both used to locally bind the UDP socket,
and used by the remote DRO as the UDP destination port.
Thus, the NAT must not modify the destination port of UDP packets.

Some NAT designs do not expect this UDP behavior.
Rather they perform a similar form of dynamic port allocation where a
packet's source port is modified, and the networking software is
expected to examine the source port and use it for outgoing packets.
UM does not do that.

The NAT should be configured with static port mappings for all DRO
peer links expected.
If this is not practical, then UDP peer links may not be usable.
<a href="https://ultramessaging.github.io/UM_Support.html">Contact UM Support</a>.

\m4_pg umroutermonitoring DRO Monitoring

See \ref monitoring for an overview of monitoring an Ultra Messaging
network.

It is important to the health and stability of a UM network to
monitor the operation of DROs (if any).
This monitoring should include real-time automated detection of
problems that will produce a timely alert to operations staff.

Three types of data should be monitored:
<ul>
<li>\ref dromonitoringlogs "Log file".
<li>\ref dromonitoringumlibrarystats "UM library statistics" (context, source, receiver, wildcard receiver, event queue).
<li>\ref dromonitoringdaemonstats "Daemon statistics" (similar data to the \ref umrouterwebmonitor).
</ul>

For UM library stats and daemon stats,
the monitoring messages contain an "application ID".
For UM applications, this is a user-specified name
intended to identify the individual component/instance,
and is supplied by the option \ref monitorappidcontext.

However, in the DRO,
the application ID is NOT controlled by the "monitor-appid" option,
and is instead used to identify not only the specific DRO,
but also the portal within the DRO that is supplying the stats.

In the case of the DRO's daemon stats, the application ID is
set to the \ref droelementname located within the
\ref droelementdaemon.
For example, a DRO configured with:
\code
<tnw-gateway version="1.0">
  <daemon>
    <name>dro1</name>
    ...
\endcode
The daemon stats will have the application ID "dro1".

In the case of UM library stats (context, transport, event queue),
the application ID is constructed as follows:
<br>
`  Gateway_Portal_`<b><i>portalname</i></b>`_`<b><i>portalcontext</i></b>
<br>
Where <b><i>portalname</i></b> is set to the \ref droelementname
located within the \ref droelementendpoint,
and <b><i>portalcontext</i></b> is set to either "rcv_ctx" or "src_ctx".
For example, a DRO configured with:
\code
  ...
  <portals>
    <endpoint>
      <name>TRD1</name>
      ...
\endcode
The UM library stats will have the application ID `"Gateway_Portal_TRD1_rcv_ctx"`
and `"Gateway_Portal_TRD1_src_ctx"`.

\m4_s1 dromonitoringlogs DRO Monitoring: Logs

Ideally, log file monitoring would support the following:
<ul>
<li>Archive all log messages for all DROs for at least a week, preferably a month.
<li>Provide rapid access to operations staff to view the latest log messages from a DRO.
<li>Periodic scans of the log file to detect errors and raise alerts to operations staff.
</ul>

Regarding log file scanning, messages in the DRO's log file contain a
severity indicator in square brackets. For example:
\verbatim
[2022-11-01 13:28:51.720796] [information] Gwd-9574-01: RecalcTrigger:LINK CAME UP:Version = 1:NodeId = 1
\endverbatim
Informatica recommends alerting operations staff for messages of severity
[WARNING], [ERROR], [CRITICAL], [ALERT], and [EMERGENCY].

It would also be useful to have a set of exceptions for specific messages
you wish to ignore.

There are many third party real-time log file analysis tools available.
A discussion of possible tools is beyond the scope of UM documentation.

\m4_s1 dromonitoringumlibrarystats DRO Monitoring: UM Library Stats

The DRO communicates with applications using Ultra Messaging
protocols, and therefore makes use of the UM library.
It is just as important to monitor the UM library statistics for
the DRO as it is for applications.

There are two data formats for UM library stats:
<ul>
<li>Protobufs - recommended.
<li>CSV - deprecated. Informatica recommends migrating to protobufs.
</ul>

For example, here is an excerpt from a sample DRO configuration file that
shows how automatic monitoring is enabled:
\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
  <daemon>
    <name>dro1</name>
    ...
    <monitor interval="600">
      <transport-module module="lbm"/>
      <format-module module="pb"/>
    </monitor>
    <xml-config>um.xml</xml-config>
...
\endcode

Here is an excerpt from a sample "um.xml":
\code
<?xml version="1.0" encoding="UTF-8" ?>
<um-configuration version="1.0">
  <templates>
    ...
    <template name="mon_ctx">
      <options type="context">
        <option name="resolver_unicast_daemon" default-value="10.29.3.101:12801"/>
        <option name="default_interface" default-value="10.29.3.0/24"/>
        <option name="mim_incoming_address" default-value="0.0.0.0"/>
        ...
      </options>
      <options type="source">
        <option name="transport" default-value="tcp"/>
      </options>
    </template>
    ...
  </templates>

  <applications>
    ...
    <application name="tnwgd">  <!-- DRO -->
      <contexts>
        <context name="TRD1" template="um_common,res_trd1">
          ...
        </context>
        <context name="TRD2" template="um_common,res_trd2">
          ...
        </context>
        <context name="29west_statistics_context" template="mon_ctx">
          <sources/>
        </context>
      </contexts>
    </application>
    ....
\endcode

<b>Notes:</b>

<ol>

<li>The \ref droelementformatmodule value "pb"
selects the protobuf format and is available for the
DRO in UM version 6.14 and beyond.
Selecting this format implicitly enables the inclusion of the
DRO's daemon stats (see below).

<li>For a list of possible protobuf messages for the DRO,
see the "dro_mon.proto" file at \ref exampledro_mon_proto.

<li>The \ref droelementmonitor enables automatic monitoring
and defines the statistics sampling period.
In the above example,
600 seconds (10 minutes) is chosen somewhat arbitrarily.
Shorter times produce more data, but not much additional benefit.
However, UM networks with many thousands of applications may need
a longer interval (perhaps 30 or 60 minutes) to maintain a reasonable
load on the network and monitoring data storage.

<li>When automatic monitoring is enabled,
it creates a context named "29west_statistics_context".
It is configured with the "mon_ctx" template,
which sets options for the monitoring data TRD.
(Alternatively, you can configure the monitoring context using
\ref monitortransportoptscontext.)
When possible, Informatica recommends directing monitoring data to
an administrative network, separate from the application data network.
This prevents monitoring data from interfering with application data
latency or throughput.
In this example, the monitoring context is configured to use an
interface matching `10.29.3.0/24`.

<li>In this example,
the monitoring data \ref topicresolutiondescription "TRD" uses \ref unicasttopicresolution.
The \ref lbmrdmanpage "lbmrd" daemon is running on host 10.29.3.101, port 12001.

<li>The monitoring data is sent out via UM using the TCP transport.

<li>These settings were chosen to conform to the recommendations
in \ref automaticmonitoring.

</ol>

For a full demonstration of monitoring, see:
https://github.com/UltraMessaging/mcs_demo

\m4_s1 dromonitoringdaemonstats DRO Monitoring: Daemon Stats

The daemon statistics for the DRO represent a superset of the
information presented on the \ref umrouterwebmonitor.

There are two data formats for the DRO to send its daemon stats:
<ul>
<li><b>Protobufs</b> - recommended.  
<li><b>Binary</b> - deprecated. Informatica recommends migrating to protobufs.
For information on the deprecated binary formatted daemon stats,
see \ref umrouterdaemonstatistics.
</ul>

The recommended way to enable DRO daemon stats is by
enabling UM library stats using the DRO's \ref droelementmonitor "<monitor>"
element with \ref droelementformatmodule "<format-module module=\"pb\">".
For example, here's an excerpt from a DRO configuration file from
https://github.com/UltraMessaging/mcs_demo file
<a href="https://github.com/UltraMessaging/mcs_demo/blob/main/um.xml">um.xml</a>:
\verbatim
    <monitor interval="600">
      <transport-module module="lbm"/>
      <format-module module="pb"/>
    </monitor>
\endverbatim

The protobufs format is accepted by the \ref monitoringcollectorservicemcs
and the "lbmmon" example applications:
\ref examplelbmmon_c and \ref examplelbmmon_java.

For a list of possible protobuf messages for the DRO,
see the "dro_mon.proto" file at \ref exampledro_mon_proto.

For a full demonstration of monitoring, including DRO daemon stats, see:
https://github.com/UltraMessaging/mcs_demo

See also \ref dromonitoringumlibrarystats.

\m4_s1 umrouterwebmonitor DRO Web Monitor

\note The DRO web monitor functionality is deprecated
in favor of \ref monitoringcollectorservicemcs "MCS".
We do not plan to remove existing web monitor functionality,
and will continue to support it in its current state.
But we do not plan to enhance the web monitor in the future.

The built-in web monitor (configured in the `tnwgd` XML configuration file;
see \ref xmlconfigurationreference)
provides valuable statistics about the DRO and its portals, for which,
the Web Monitor separates into receive statistics and send statistics.
The Web Monitor provides a page for each endpoint and peer portal.

\warning The DRO's web monitor is not designed to be a highly-secure
feature.
Anybody with access to the network can access the web monitor pages.

Users are expected to prevent unauthorized access to the web
monitor through normal firewalling methods.
Users who are unable to limit access to a level consistent with their
overall security needs should disable the DRO web monitor
(using \ref droelementwebmonitor "<web-monitor>").
See \ref webmonsecurity for more information.

\m4_s2 mainpage Main Page

This page displays general information about the DRO,
and also provides the following links to more detailed statistical
and configuration information.

\par \b UM \b Router \b Configuration
Displays the DRO XML configuration file used by this DRO.

\par \b Portals
Displays portal statistics and information, one portal per page.
The Portals page allows you to link to any of the Peer or Endpoint
portals configured for the DRO.

\par \b Topology \b Info
This links to a page that displays DRO network connectivity
information from the perspective of this DRO.

\par \b Path \b Info
This lets you query and display a hop path that messages will take
between any two TRDs.

On some platforms, the Main page may include a link (GNU malloc info)
to a memory allocation display page that displays the following:

\par \b arena
Non-mmapped space allocated (bytes)

\par \b ordblks
Number of free chunks

\par \b hblks
Number of mmapped regions

\par \b hblkhd
Space allocated in mmapped regions (bytes)

\par \b uordblks
Total allocated space (bytes)

\par \b fordblks
Total free space (bytes)

\m4_s2 endpointportalpage Endpoint Portal Page

The Endpoint Portal Page displays Receive and Send statistics for the
selected endpoint portal.
Receive statistics pertain to messages entering the portal from its
connected TRD. Send statistics pertain to messages sent out to the TRD.

Click on any of the links at the top of the page to review configuration
option values for the portal's UM topic resolution domain.
The two columns provide different units of measure for a given statistic type,
where the first column is typically in fragments or messages
(depending on the statistic type), and the second column is in bytes.

<br>
<b>Endpoint Portal <i>name</i></b>

\par \b Domain \b ID
The ID for the Topic Resolution Domain (TRD) to which this portal is connected.

\par \b Portal \b Cost
The cost value assigned to this portal.

\par \b Local \b Interest
Totals (listed below) for topics and patterns in this portal's
interest list that originated from receivers in the immediately adjacent TRD.

\par \b Topics
Of the local interest total, the number of topics.

\par \b PCRE \b patterns
Of the local interest total,
the number of wildcard patterns, using PCRE pattern matching.

\par \b REGEX \b patterns
Of the local interest total, the number of wildcard patterns,
using REGEX pattern matching.

\par \b Remote \b Interest
Totals (listed below) for topics and patterns in this portal's
interest list that originated from receivers beyond and downstream
from the immediately adjacent TRD.

\par \b Topics
Of the remote interest total, the number of topics.

\par \b PCRE \b patterns
Of the remote interest total, the number of wildcard patterns,
using PCRE pattern matching.

\par \b REGEX \b patterns
Of the remote interest total, the number of wildcard patterns,
using REGEX pattern matching.

\par \b Proxy \b Receivers
The number of proxy receivers active in this portal.

\par \b Receiver \b Topics
The number of topics in which the other portals in the DRO have
detected current interest and summarily propagated to this portal.

\par \b Receiver \b PCRE \b patterns
The number of wildcard patterns, using PCRE pattern matching,
in which the other portals in the DRO have detected current
interest and summarily propagated to this portal.

\par \b Receiver \b REGEX \b patterns
The number of wildcard patterns, using REGEX pattern matching,
in which the other portals in the DRO have detected current interest
and summarily propagated to this portal.

\par \b Proxy \b Sources
The number of proxy sources active in this portal.

<br>
<b>Endpoint Receive Statistics</b>

\par \b Transport \b topic \b fragments/bytes \b received
The total transport-based topic-related traffic of messages containing user
data received by this portal from a TRD.
The first column counts the number of fragments
(or whole messages for messages that were not fragmented).

\par \b Transport \b topic \b request \b fragments/bytes \b received
Topic messages received that are request messages, i.e.,
messages send via lbm_send_request*() rather than lbm_src_send*().

\par \b Transport \b topic \b control \b msgs/bytes \b received
The total transport-based topic-related traffic received by this portal
from a TRD.
These are supervisory messages, which include TSNIs, SRIs., etc.
The first column counts the number of messages.

\par \b Immediate \b topic \b fragments/bytes \b received
The total number of Multicast Immediate Messaging (MIM) messages
or message fragments, and bytes (second column), that have a topic,
received at this portal.

\par \b Immediate \b topic \b request \b fragments/bytes \b received
Of the MIM topic messages received,
this is the amount of those that are requests.

\par \b Immediate \b topicless \b fragments/bytes \b received
The total number of MIM messages or message fragments,
and bytes (second column), with null topics, received by his portal.

\par \b Immediate \b topicless \b request \b fragments/bytes \b received
Of the MIM topicless messages received,
this is the amount of those that are requests.

\par \b Unicast \b data \b messages/bytes \b received
The total number of Unicast Immediate Messaging (UIM) messages (and bytes,
second column) containing user data, received by this portal.

\par \b Duplicate \b unicast \b data \b messages/bytes \b dropped
UIM data messages discarded because they were duplicates of messages
already received.

\par \b Unicast \b data \b messages/bytes \b received \b with \b no \b stream \b info
UIM data messages discarded because they were from an earlier,
incompatible version of UM.
This counter should stay at 0; otherwise,
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\par \b Unicast \b data \b messages/bytes \b received \b with \b no \b route \b to \b destination
UIM data messages that are on a wrong path,
possibly due to a route recalculation.
This counter should stay at 0,
though it may increment a few messages at the time of a topology change.

\par \b Unicast \b control \b messages/bytes \b received
The total number of Unicast Immediate Messaging (UIM) supervisory
(non-data) messages (and bytes, second column) received by this portal.

\par \b Duplicate \b unicast \b control \b messages/bytes \b dropped
Supervisory UIMs dropped because they were duplicates of messages
already received.

\par \b Unicast \b control \b messages/bytes \b received \b with \b no \b stream \b info
Supervisory UIMs dropped because they were from an earlier,
incompatible version of UM.
This counter should stay at 0; otherwise,
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\par \b Unicast \b control \b messages/bytes \b received \b with \b no \b route \b to \b destination
Supervisory UIM messages that are on a wrong path,
possibly due to a route recalculation.
This counter should stay at 0,
though it may increment a few messages at the time of a topology change.

<br>
<b>Endpoint Send Statistics</b>

\par \b Transport \b topic \b fragments/bytes \b forwarded
The total transport-based topic-related traffic forwarded to this portal
from other portals in this DRO.
This could include user messages, TSNIs, SRIs, etc.
The first column counts the number of fragments (or whole messages for messages that were not fragmented).

\par \b Transport \b topic \b fragments/bytes \b sent
Of the transport topic traffic forwarded,
this is the amount of traffic sent out to the TRD.

\par \b Transport \b topic \b request \b fragments/bytes \b sent
Of the messages sent, this is the amount of those that are requests.

\par \b Duplicate \b transport \b topic \b fragments/bytes \b dropped
Of the messages forwarded to this portal,
this is the total of those that were discarded because they were
duplicates of messages already received.

\par \b Transport \b topic \b fragments/bytes \b dropped \b due \b to \b blocking
Of the messages forwarded to this portal,
this is the amount of those that were discarded because they
were blocked from sending, and were unable to be buffered.
Message rates on other portals probably exceeded the rate controller
limit on this portal.

\par \b Transport \b topic \b fragments/bytes \b dropped \b due \b to \b error
Of the messages forwarded to this portal,
this is the total of those that were discarded due to an
application or network connection failure.

\par \b Transport \b topic \b fragments/bytes \b dropped \b due \b to \b fragment \b size \b error
Of the messages forwarded to this portal,
this is the total of those that were discarded possibly because
of a configuration error.
If this count is not at or near 0, verify that maximum datagram
size for all transports is the same throughout the network.

\par \b Immediate \b topic \b fragments/bytes \b forwarded
The total number of Multicast Immediate Messaging (MIM)
messages or message fragments, and bytes (second column),
forwarded to this portal from other portals in this DRO.

\par \b Immediate \b topic \b fragments/bytes \b sent
Of the MIM topic messages forwarded to this portal,
this is the amount of traffic sent out to the TRD.

\par \b Immediate \b topic \b request \b fragments \b sent
Of the MIM topic messages sent, this is the amount of those that are requests.

\par \b Immediate \b topic \b fragments/bytes \b dropped \b due \b to \b blocking
Of the MIM topic messages forwarded to this portal,
this is the amount of those that were discarded because they were blocked
from sending, and were unable to be buffered.
Message rates on other portals probably exceeded the rate controller
limit on this portal.

\par \b Immediate \b topic \b fragments/bytes \b dropped \b due \b to \b error
Of the MIM topic messages forwarded to this portal,
those that were discarded due to an application or network connection failure.

\par \b Immediate \b topic \b fragments/bytes \b dropped \b due \b to \b fragment \b size \b error
Of the MIM topic messages forwarded to this portal,
those that were dropped possibly because of a configuration error.
If this count is not at or near 0, verify that maximum datagram size
for all transports is the same throughout the network.

\par \b Immediate \b topicless \b fragments/bytes \b forwarded
The total number of Multicast Immediate Messaging (MIM) messages or
message fragments, and bytes (second column), with null topics,
forwarded to this portal from other portals in this DRO.

\par \b Immediate \b topicless \b fragments/bytes \b sent
Of the MIM topicless messages forwarded to this portal,
this is the amount of traffic sent out to the TRD.

\par \b Immediate \b topicless \b request \b fragments \b sent
Of the MIM topicless messages sent,
this is the amount of those that are requests.

\par \b Immediate \b topicless \b fragments/bytes \b dropped \b due \b to \b blocking
Of the MIM topicless messages forwarded to this portal,
this is the amount of those that were discarded because they were blocked
from sending, and were unable to be buffered.
Message rates on other portals probably exceeded the rate controller
limit on this portal.

\par \b Immediate \b topicless \b fragments/bytes \b dropped \b due \b to \b error
Of the MIM topicless messages forwarded to this portal,
those that were discarded due to an application or network connection failure.

\par \b Immediate \b topicless \b fragments/bytes \b dropped \b due \b to \b fragment \b size \b error
Of the MIM topicless messages forwarded to this portal,
those that were dropped possibly because of a configuration error.
If this count is not at or near 0, verify that maximum datagram size
for all transports is the same throughout the network.

\par \b Unicast \b messages/bytes \b forwarded
The total number of Unicast Immediate Messaging (UIM) messages
(and bytes, second column), both control and containing user data,
forwarded to this portal.

\par \b Unicast \b messages/bytes \b sent
Of the UIM data messages forwarded to this portal,
this is the amount of traffic sent out to the TRD.

\par \b Unicast \b messages/bytes \b dropped \b due \b to \b error
Of the UIM data messages forwarded to this portal,
those that were discarded due to an application or network connection failure.

\par \b Current/maximum \b data \b bytes \b enqueued \b (limit: \b n)
For bytes in this portal's send buffer (due to a blocking send),
the first column is a snapshot of the current amount,
and the second column is a high-water mark.
The displayed limit (n) is the configuration value for option <max-queue>.

\m4_s2 peerportalpage Peer Portal Page

This page allows you to see Receive and Send statistics for the selected
peer portal.
Click on any of the links at the top of the page to review configuration
option values for the portal's UM topic resolution domain.

The peer portal page displays the following statistics:

<br>
<b>Peer Portal <i>name</i></b>

\par \b Portal \b Cost
The cost value assigned to this portal.

\par \b Interest
Totals (listed below) for topics and patterns in this portal's
interest list that originated from receivers beyond and downstream
from the immediately adjacent DRO.

\par \b Topics
Of the interest total, the number of topics.

\par \b PCRE \b patterns
Of the interest total, the number of wildcard patterns,
using PCRE pattern matching.

\par \b REGEX \b patterns
Of the interest total, the number of wildcard patterns,
using REGEX pattern matching.

\par \b Proxy \b Receivers
The number of proxy receivers active in this portal.

\par \b Receiver \b topics
All topics in which the other portals in the DRO have detected
current interest and summarily propagated to this portal.

\par \b Receiver \b PCRE \b patterns
All wildcard patterns, using PCRE pattern matching,
in which the other portals in the DRO have detected current
interest and summarily propagated to this portal.

\par \b Receiver \b REGEX \b patterns
All wildcard patterns, using REGEX pattern matching,
in which the other portals in the DRO have detected current
interest and summarily propagated to this portal.

\par \b Proxy \b Sources
The number of proxy sources active in this portal.

<br>
<b>Peer Receive Statistics</b>

\par \b Data \b messages/bytes \b received
The total of messages containing data received at this portal.
The first column counts the number of fragments (or whole messages
for messages that were not fragmented).

\par \b Transport \b topic \b fragment \b data \b messages/bytes \b received
The total of user-data messages received on any topic resolved through
this portal.
The first column counts the number of fragments
(or whole messages for messages that were not fragmented).

\par \b Transport \b topic \b fragment \b data \b messages/bytes \b received \b with \b unknown \b source
Topic messages received whose source this DRO has not seen before.

\par \b Transport \b topic \b request \b fragment \b data \b messages/bytes \b received
These are topic messages received that are request messages, i.e.,
messages send via lbm_send_request*() rather than lbm_src_send*().

\par \b Transport \b topic \b request \b fragment \b data \b messages/bytes \b received \b with \b unknown \b source
Of the request messages received, the topic messages received whose
source this DRO has not seen before.

\par \b Immediate \b topic \b fragments/bytes \b received
The total number of Multicast Immediate Messaging (MIM) messages or message
fragments, and bytes (second column), that have a topic,
received by all proxy receivers at this portal.

Immediate topic request fragments/bytes received
Of the MIM topic messages received,
this is the total of those that are requests.

\par \b Immediate \b topicless \b fragments/bytes \b received
The total number of MIM messages or message fragments, and bytes (second
column), with null topics, received by all proxy receivers at this portal.

\par \b Immediate \b topicless \b request \b fragments/bytes \b received
Of the MIM topicless messages received,
this is the total of those that are requests.

\par \b Unicast \b data \b messages/bytes \b received
The total number of Unicast Immediate Messaging (UIM) messages (and bytes,
second column) containing user data, received by this portal.

\par \b Unicast \b data \b messages/bytes \b received \b with \b no \b stream \b information
UIM data messages discarded because they were from an earlier,
incompatible version of UM.
This counter should stay at 0; otherwise,
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\par \b Unicast \b data \b messages/bytes \b received \b with \b no \b route \b to \b destination
UIM data messages that are on a wrong path, possibly due to a route
recalculation.
This counter should stay at 0,
though it may increment a few messages at the time of a topology change.

\par \b Control \b messages/bytes \b received
The total of supervisory messages (containing no data) received at this portal.

\par \b Transport \b topic \b control \b messages/bytes \b received
Of the control messages received,
those that are transport/topic based (such as TSNIs, SRIs., etc.).

\par \b Transport \b topic \b control \b messages/bytes \b received \b with \b unknown \b source
Of the transport/topic control messages received whose source this
DRO has not seen before.

\par \b Unicast \b control \b messages/bytes \b received
The total number of Unicast Immediate Messaging (UIM) supervisory (non-data)
messages (and bytes, second column) received by this portal.

\par \b Retransmission \b requests/bytes \b received
Supervisory UIMs that are requests for retransmission of lost (or Late Join)
messages.

\par \b Control \b messages/bytes \b received \b with \b no \b stream \b info
Supervisory UIMs discarded because they were from an earlier,
incompatible version of UM.
This counter should stay at 0; otherwise,
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

\par \b Control \b messages/bytes \b received \b with \b no \b route \b to \b destination
Supervisory UIM messages that are on a wrong path,
possibly due to a route recalculation.

\par \b Gateway \b control \b messages/bytes \b received
The total of DRO-only,
peer-to-peer supervisory messages received at this portal.

\par \b Unhandled \b control \b messages/bytes \b received
Supervisory UIMs discarded because, though they are well-formed,
they have no valid action request.
This counter should stay at 0; otherwise,
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

<br>
<b>Peer Send Statistics</b>

\par \b Transport \b topic \b fragments/bytes \b forwarded
The total transport-based topic-related traffic forwarded to this portal
from other portals in this DRO.
This could include user messages, TSNIs, SRIs., etc.
The first column counts the number of fragments (or whole messages for messages that were not fragmented).

\par \b Transport \b topic \b fragments/bytes \b sent
Of transport topic messages forwarded to this portal,
the amount of traffic sent to the adjacent DRO.

\par \b Transport \b topic \b request \b fragments/bytes \b sent
Of transport topic messages sent, those that were request messages.

\par \b Transport \b topic \b fragments/bytes \b dropped \b (duplicate)
Of transport topic messages forwarded to this portal,
messages discarded because they were duplicates of messages already received.

\par \b Transport \b topic \b fragments/bytes \b dropped \b (blocking)
Of transport topic messages forwarded to this portal,
this is the amount of those that were discarded because they were blocked
from sending, probably due to TCP flow control, and were unable to be buffered.
The DRO's XML configuration file may need to be adjusted.

\par \b Transport \b topic \b fragments/bytes \b dropped \b (not \b operational)
Of transport topic messages forwarded to this portal,
messages discarded because the peer link is down.

\par \b Transport \b topic \b fragments/bytes \b dropped \b (queue \b failure)
Of transport topic messages forwarded to this portal,
messages discarded due to a memory allocation failure.

\par \b Unicast \b messages/bytes \b forwarded
The total number of supervisory (no data payloads) Unicast Immediate Messaging
(UIM) messages (and bytes, second column) forwarded to this portal from
other portals in this DRO.
These messages can be either control (supervisory) messages or
contain user data.

\par \b Unicast \b messages/bytes \b sent
Of the UIMs forwarded to this portal,
the amount of traffic sent to the adjacent DRO.

\par \b Unicast \b messages/bytes \b dropped \b (blocking)
Of the UIMs forwarded to this portal, this is the amount of those that
were discarded because they were blocked from sending, probably due to
TCP flow control, and were unable to be buffered.
The DRO's XML configuration file may need to be adjusted.

\par \b Unicast \b messages/bytes \b dropped \b (not \b operational)
Of the UIMs forwarded to this portal, messages discarded because
the peer link is down.

\par \b Unicast \b messages/bytes \b dropped \b (queue \b failure)
Of the UIMs forwarded to this portal,
messages discarded due to a memory allocation failure.

\par \b Gateway \b control \b messages/bytes \b sent
The total number of DRO supervisory messages
(and bytes, second column), generated at this portal.

Gateway control messages/bytes sent
Of the DRO supervisory messages generated,
the number sent to the adjacent DRO.

Gateway control messages/bytes dropped (blocking)
The amount of DRO supervisory messages that were discarded
because they were blocked from sending, probably due to TCP flow control,
and were unable to be buffered.
The DRO's XML configuration file may need to be adjusted.

\par \b Gateway \b control \b messages/bytes \b dropped \b (not \b operational)
The amount of DRO supervisory messages that were discarded because
the peer link was down.

\par \b Gateway \b control \b messages/bytes \b dropped \b (queue \b failure)
The amount of DRO supervisory messages that were discarded due
to a memory allocation failure.

\par \b Batches
The number of times messages were batched.

\par \b Minimum \b messages/bytes \b per \b batch
The lowest recorded number of messages in a batch,
and the number of bytes in that batch.

\par \b Average \b messages/bytes \b per \b batch
The average number of messages in a batch,
and the number of bytes in that average batch.

\par \b Maximum \b messages/bytes \b per \b batch
The highest recorded number of messages in a batch,
and the number of bytes in that batch.

\par \b Current/maximum \b data \b bytes \b enqueued
For bytes in this portal's send buffer (due to a blocking send),
the first column is a snapshot of the current amount, and the second
column is a high-water mark.
The displayed limit is the configuration value for option `<max-queue>`.

\par \b Keepalive/RTT \b samples
The number of keepalive messages that have been set to the other
DRO's portal and responded to.

\par \b Minimum \b RTT \b (microseconds)
Of the keepalives sent and responded to,
the lowest recorded round-trip time.

\par \b Mean \b RTT \b (microseconds)
Of the keepalives sent and responded to,
the mean recorded round-trip time.

\par \b Maximum \b RTT \b (microseconds)
Of the keepalives sent and responded to,
the highest recorded round-trip time.

\par \b Last \b keepalive \b responded \b to
The send timestamp (date and time) of the last sent keepalive
message that was responded to.

\m4_s2 topologyinfopage Topology Info Page

This page allows you to see DRO network connectivity information
from the perspective of this DRO.
The <i>Other DROs</i> section (below) provides information in the same
format as is used for the local DRO.

\par \b Local \b UM \b Router \b Name
The DRO name as assigned via configuration.

\par \b Local \b UM \b Router \b ID
A unique value that the DRO assigns to itself automatically.

\par \b Self \b Version
A configuration version for this DRO,
as seen collectively by the DRO network.

\par \b Topology \b Signature
An identifier for the "map" of this DRO network's routes. This value should be the same for all DROs.

\par \b Last \b recalc \b duration
The amount of time in seconds that it took this DRO to perform
its most recent route recalculation.

\par \b Graph \b Version
The number of times this DRO has updated its view of the topology.

\par \b UM \b Router \b Count
The number of DROs in this DRO network.

\par \b Topic \b Resolution \b Domain \b Count
The number of TRDs in this DRO network.

<br>
<b>Portal (endpoint or peer)</b>

This display is repeated for each portal of this DRO.

\par \b Portal \b Name
The portal's name as assigned via configuration.

\par \b Adjacent \b Domain/UM \b Router \b ID
For an endpoint portal,
this is the configured <domain-id> for the connected TRD.
For a peer portal, this is an automatically assigned unique
identifier for the connected DRO.

\par \b Cost
This portal's configured cost.

\par \b Last \b interest \b recalc \b duration
The amount of time in seconds that it took this DRO to perform a
recalculation that resulted in an update to the interest status for this portal.

\par \b Last \b proxy \b receiver \b recalc \b duration
The amount of time in seconds that it took this DRO to perform
recalculation that resulted in an update to the status of proxy receivers
(create, maintain, or destroy) for this portal.

<br>
<b>Other DROs</b>

This display is repeated for each other DRO in this DRO's network.

\par \b UM \b Router \b Name
The DRO name as assigned via configuration.

\par \b UM \b Router \b ID
A unique value that the DRO assigns to itself automatically.

\par \b Version
A configuration version for the DRO,
as seen collectively by the DRO network.

\par \b Topology \b Signature
An identifier for the "map" of this DRO network's routes.
This value should be the same for all DROs.

\par \b Last \b Activity \b n \b seconds \b ago
How long since the last time this local DRO received a route info
packet from the designated "other" DRO.

\par \b Adjacent \b Domain \b ID
The configured ID of one of this "other" DRO's connected TRD,
plus the cost assigned to the associate endpoint portal.
If there are more than one endpoint portals in the DRO,
this line is repeated for each.

\par \b Adjacent \b UM \b Router \b ID
The automatically assigned ID of one of this "other" DRO's
connected DRO, plus the cost assigned to the associate peer portal.
If there are more than one peer portals in the DRO,
this line is repeated for each.

\m4_s2 pathinfo Path Info

The Path Info page lets you query and display a hop path that messages
will take between any two TRDs that you enter into the Domain ID 1 and
Domain ID 2 text boxes.
Fill in the boxes and click the Calculate Shortest Path button,
and you see the following fields:

\par \b Hop \b Count
The number of hops from none node to the next along the displayed route,
where a node can be either a DRO or a TRD.

\par \b Aggregate \b Cost
A sum of the cost values of all portals along the displayed path.

\par \b Path
A display of the DRO and TRD hops listed in route order from the
starting TRD to the ending TRD.

\m4_s1 umrouterlogmessages DRO Log Messages

The DRO daemon generates log messages that are used to monitor its
health and operation.
You can configure these to be directed to "console" (standard output),
"syslog", or a specified log "file", via the \ref droelementlog "<log>"
configuration element.
Normally "console" is only used during testing, as a persistent log file
is preferred for production use.
The DRO does not over-write log files on startup, but instead
appends them.

\m4_s2 umrouterrollinglogs DRO Rolling Logs

To prevent unbounded disk file growth, the DRO supports rolling
log files.
When the log file rolls, the file is renamed according to the model:
<br>&nbsp;&nbsp;<i>CONFIGUREDNAME</i><tt>_</tt><i>PID</i><tt>.</tt><i>DATE</i><tt>.</tt><i>SEQNUM</i>
<br>where:
<ul>
<li><i>CONFIGUREDNAME</i> - Root name of log file, as configured by user.
<li><i>PID</i> - Process ID of the DRO daemon process.
<li><i>DATE</i> - Date that the log file was rolled, in YYYY-MM-DD format.
<li><i>SEQNUM</i> - Sequence number, starting at 1 when the process starts,
and incrementing each time the log file rolls.
</ul>
For example: `umrouterlog_9867.2017-08-20.2`

The user can configure when the log file is eligible to roll over by
either or both of two criteria: size and frequency.
The size criterion is in millions of bytes.
The frequency criterion can be daily or hourly.
Once one or both criteria are met, the next message written to the log
will trigger a roll operation.
These criteria are supplied as attributes to the \ref droelementlog "<log>"
configuration element.
<!-- editor's note: needed "<log>" to prevent Doxygen from attempting to
  -- interpret the XML tag after the reference substitution. -->

If both criteria are supplied, then the first one to be reached will trigger
a roll.
For example, consider the setting:
\code
  <log type="file" size="23" frequency="daily">dro.log</log>
\endcode
Let say that the log file grows at 1 million bytes per hour.
At 11:00 pm, the log file will reach 23 million bytes, and will roll.
Then, at 12:00 midnight, the log file will roll again, even though it is
only 1 million bytes in size.

\note The rolling logs cannot be configured to automatically overwrite
old logs.
Thus, the amount of disk space consumed by log files will grow without
bound.
The user must implement a desired process of archiving or deleting
older log files according to the user's preference.

\m4_s2 importantumrouterlogmessages Important DRO Log Messages

<b>Connection Failure Messages</b>

\code
peer portal [name] failed to connect to peer at [IP:port] via [interface] [err]: reason
peer portal [name] failed to accept connection (accept) [err]: reason
\endcode

<b>Lost Connection Messages</b>

\code
peer portal [name] lost connection to peer at [IP:port] via [interface]
peer portal [name] connection destroyed due to socket failure
peer portal [name] detected dropped inbound connection (read) [err]: reason
peer portal [name] detected dropped inbound connection (zero-len read)
\endcode

<b>Endpoint Messages</b>

If a UMP store is adjacent to the DRO,
and the DRO has been restarted, you typically see messages of the form:

\code
endpoint portal [name] has no forwarding entry for destination ctxinst [string], dropping msg (lbmc cntl ume)
\endcode

These messages are normal, and cease when the DRO has established
the forwarding information for the given context.

<b>Peer Messages</b>

\code
Acceptor: peer portal [name] received connection from [IP:port]
Initiator: peer portal [name] connected to [IP:port ]
\endcode

\m4_s1 umroutertransportstats DRO Transport Stats

Using the `<monitor>` element in a DRO's XML configuration file
and the UMS Monitoring feature,
you can monitor the transport activity between the DRO and its
Topic Resolution Domain.
The configuration also provides Context and Event Queue statistics.
The statistics output identifies individual portals by name.

\m4_pg manpagesforumrouter Man Pages for DRO

UM Message Routing services are provided by the DRO daemon (DRO).

There are two executables for the DRO, each with it's own man page:
<ul>
<li>\ref tnwgdmanpage - Unix and Windows command-line interface.
<li>\ref tnwgdsmanpage - Windows service interface.
</ul>

(Note: "tnwg" stands for "Twenty Nine West Gateway", an older name for the DRO.)

\m4_s1 tnwgdmanpage Tnwgd Man Page

Unix and Windows command-line interface.

\code
m4_include([[[tnwgd.usage]]])
\endcode

\par \b Description
The `tnwgd` command runs the DRO.
It can be run interactively from a shell or command prompt,
or from a script or batch file.
(For use as a Windows Service, see \ref tnwgdsmanpage.)

\par
The <b>"configfile"</b> parameter is required and specifies the file path
for the DRO's XML configuration file.
See \ref xmlconfigurationreference for configuration details.

\par
The <b>"-f"</b> option directs a Unix-based `tnwgd` to fork a child process
which detaches from the controlling terminal.
The `tnwgd` command normally remains attached to the controlling
terminal and runs until interrupted.
With "-f", the `tnwgd` command exits back to the shell,
and the forked child continues running in the background.

\par
The <b>"-d"</b> option dumps (prints) the DRO's XML DTD to standard output.
After dumping the DTD, `tnwgd` exits.
See \ref umrouterconfigurationdtd for the DTD with comments removed.

\par
The <b>"-u"</b> option tells the DRO to format its
log file timestamps as UTC.

\par
The <b>"-v"</b> option validates the XML structure of the given configuration file
against the DRO's XML DTD.
After validating the configuration file's XML structure,
`tnwgd` exits with status 0 for no errors,
or non-zero if errors were found.
For example:
\code
tnwgd -v /um/dro_cfg.xml
\endcode

\par
Note that valid XML structure does not guarantee that the configuration
file is completely correct.
It must be tested on a running DRO.

\par
The <b>"-h"</b> option prints the man page and exits.

\par \b Exit \b Status
The exit status from `tnwgd` is 0 for success and some non-zero value for failure.

\m4_s1 tnwgdsmanpage Tnwgds Man Page

Windows service interface.

See \ref umdaemonsaswindowsservices for general information about UM
daemons as Windows Services.

\code
m4_include([[[tnwgds.usage]]])
\endcode

\par \b Description
The `tnwgds` command has two functions:
<ul>
<li>First, it lets the user supply Windows Service operating parameters,
which the command saves into the Windows registry.
Those operating parameters are subsequently used by the DRO Service.
For details on setting Windows Service operating parameters,
see \ref configurethewindowsservice.
<li>Second, it provides Windows with the DRO executable to run
as a Service.
</ul>

\par
The <b>"configfile"</b> parameter provides the file path
for the DRO's XML configuration file.
It is supplied in conjunction with the "-v" option or the "-s config" option
(see below).
See \ref xmlconfigurationreference for configuration details.

\par
Note that valid XML structure does not guarantee that the configuration
file is completely correct.
It must be tested on a running DRO.

\par
For <b>"-s install"</b> see \ref installthewindowsservice.

\par
For <b>"-s remove"</b> see \ref removethewindowsservice.

\par
For <b>"-s config"</b>, <b>"-e"</b>, <b>"-E"</b>, and <b>"-U"</b>,
see \ref configurethewindowsservice.

\par
The <b>"-d"</b> option dumps (prints) the DRO's XML DTD to standard output.
After dumping the DTD, `tnwgds` exits.

\par
The <b>"-v"</b> option validates the XML structure of the given configuration file
against the DRO's XML DTD.
After validating the configuration file's XML structure,
`tnwgd` exits with status 0 for no errors,
or non-zero if errors were found.
For example:
\code
tnwgds -v c:\um\dro_cfg.xml
\endcode

\par
Note that valid XML structure does not guarantee that the configuration
file is completely correct.
It must be tested on a running DRO.

\par
The <b>"-h"</b> option prints the man page and exits.

\par \b Exit \b Status
The exit status from `tnwgd` is 0 for success and some non-zero value for failure.

\attention Do not use the task manager or the "kill" command
to stop a UM daemon running as a Windows service.
Use the Windows service control panel to stop the service.

\m4_pg xmlconfigurationreference DRO Configuration Reference

For controlling/configuring each DRO,
you use a XML DRO configuration file,
which also contains references to UM configuration files to extract needed
information about the TRDs interfaced by endpoint portals.

An overview of the file format can be seen in the
\ref umrouterconfigurationdtd.

An XML DRO configuration file follows standard XML conventions.
Element declarations or a pointer to a DTD file are not needed,
as these are handled by the DRO.

\m4_s1 filestructure File Structure

An XML DRO configuration file generally comprises two primary elements:
`<daemon>` and `<portals>`.
Organized and contained within these are option value assignments.
`<daemon>` sub-containers let you set options global to the DRO.
`<portals>` sub-containers let you configure each portal in
the DRO individually.

In general, the order of the elements is important.
Please refer to the examples and ensure proper element ordering.

XML DRO configuration files use the high-level structure shown in
the following example.
This example includes only some container elements, and only some options.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<tnw-gateway version="1.0">
  <daemon>
    <log type="console"/>
    <uid>0</uid>
    <gid>0</gid>
    <pidfile>/path/file.pid</pidfile>
    <lbm-license-file>/path/file.lic</lbm-license-file>
    <topicmap/>
    <patternmap/>
    <monitor>
      <transport-module/>
      <format-module/>
    </monitor>
    <web-monitor>*:21000</web-monitor>
    <propagation-delay/>
    <xml-config>sample-config.xml</xml-config>
  </daemon>
  <portals>
    <endpoint>
      <name>Endpoint_1</name>
      <domain-id>1</domain-id>
      <cost>1</cost>
      <lbm-config>endpoint2.cfg</lbm-config>
      <lbm-attributes>
        <option name="context_name" scope="context" value="endpt_1" />
      </lbm-attributes>
      <acl>
        <inbound>
          <ace match="accept">
            <topic>ABC123</topic>
            <pcre-pattern >pattern</pcre-pattern >
            <regex-pattern >pattern</regex-pattern >
            <transport/>
            <source-ip/>
            <multicast-group/>
            <udp-source-port/>
            <udp-destination-port/>
            <tcp-source-port/>
            <xport-id/>
          </ace>
        </inbound>
        <outbound>
          <ace match="accept">
            <topic>ABC123</topic>
            <pcre-pattern >pattern</pcre-pattern >
            <regex-pattern >pattern</regex-pattern >
            <transport/>
            <source-ip/>
            <multicast-group/>
            <udp-source-port/>
            <udp-destination-port/>
            <tcp-source-port/>
            <xport-id/>
          </ace>
        </outbound>
      </acl>
    </endpoint>
    <peer>
      <name>Peer_1</name>
      <cost>1</cost>
      <single-tcp>
        <interface>
        <receive-buffer>
        <send-buffer>
        <keepalive>
        <nodelay>
        <initiator>
          <address>
          <port>
        </initiator>
        <acceptor>
          <listen-port>
        </acceptor>
      </single-tcp>
      <max-queue>
      <max-datagram>
      <batching>
        <min-length>
        <batch-interval>
      </batching>
      <lbm-config>peer1.cfg</lbm-config>
      <lbm-attributes>
        <option name="name" scope="scope" value="value" />
      </lbm-attributes>
      <acl> (see above)
      <topic-purge>
      <topic-interest-generate>
      <topic-domain-activity>
      <pattern-purge>
      <pattern-interest-generate>
      <pattern-domain-activity>
      <topic-use-check/>
      <pattern-use-check>
      <source-context-name>
      <receiver-context-name>
      <sqn-window>
      <context-query>
      <gateway-keepalive>
    </peer>
  </portals>
</tnw-gateway>
\endcode

\m4_s1 mergingmultipledroxmlconfigurationfiles Share/Merge DRO XML Files with XInclude

The XInclude mechanism can be used to merge or share XML files for UM library
configuration, Store configuration, and DRO configuration.
This is typically done to avoid duplicating groups of configuration options in
multiple places.

To include an external file from a DRO configuration file, use the following syntax:

\code
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="FILEPATH" />
\endcode

Where FILEPATH can be a local file name,
or a network path starting with "http:" or "ftp:".
For example:
\code
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="/um/conf/TRD1.xml" />
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="http://myweb.mydomain.com/umconf/TRD1.xml" />
<xi:include xmlns:xi="http://www.w3.org/2003/XInclude" href="ftp://myftp.mydomain.com/umconf/TRD1.xml" />
\endcode

Note that secure forms of network paths ("https:" or "sftp:") are not supported.

Files to be included must be formatted such that all elements are enclosed
in a single container element.

Example of an <b>invalid</b> file:

\code
  <pcre-pattern>global/.*</pcre-pattern>
  <pcre-pattern>price/us/.*</pcre-pattern>
  <topic>health_check</topic>
  ...
\endcode

Example of <b>valid</b> file:

\code
<ace match="accept">
  <pcre-pattern>global/.*</pcre-pattern>
  <pcre-pattern>price/us/.*</pcre-pattern>
  <topic>health_check</topic>
  ...
</ace>
\endcode

\m4_s2 commondroxincludeusecase Common DRO XInclude Use Case

DRO configuration files do not support templates.
It is common that groups of configuration options
need to be repeated across many DRO configurations.

For example consider the DRO configuration
file "dro1_conf.xml":

\code
...
  <endpoint>
    <name>...</name>
...
    <acl>
      <inbound>
        <ace match="accept">
          <pcre-pattern>global/.*</pcre-pattern>
          <pcre-pattern>price/us/.*</pcre-pattern>
          <topic>health_check</topic>
          ...
        </ace>
      </inbound>
    </acl>
  </endpoint>
...
\endcode

If this same ACL needs to be applied to many different DROs,
it can be a lot of repeated content across every DRO's configuration file.

The XInclude feature can be used to reduce duplicate content by
creating a second file "dro_ace.xml":

\code
<ace match="accept">
  <pcre-pattern>global/.*</pcre-pattern>
  <pcre-pattern>price/us/.*</pcre-pattern>
  <topic>health_check</topic>
  ...
</ace>
\endcode

Now "dro1_conf.xml" (and others) can be coded as:

\code
...
  <endpoint>
    <name>...</name>
...
    <acl>
      <inbound>
        <xi:include xmlns:xi="http://www.w3.org/2001/XInclude" href="./dro_ace.xml" />
      </inbound>
    </acl>
  </endpoint>
...
\endcode

\m4_s1 elementsreference Elements Reference

m4_ifdef([[[comment]]], [[[
# Convert the following text into XML documentation.
]]])m4_dnl
m4_syscmd([[[cat <<__EOF__ >dro_config_descr.txt
# Descriptions and examples of IDs defined in lbm.xsd
# Inside this section of the document (until the EOF), all back quote
# characters need to be escaped with backslash. This is because the 
# text is passed to the shell as a "here-is" document, which does
# shell substitution.

# Name added to each section title
%component Router

# anchor prefix is for link names.
%anchor_prefix droelement

# List the top-level elements to doc.
%top tnw-gateway

###

Container for all options residing in the XML DRO configuration file.
This is the top-level element.
%descr tnw-gateway

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
  </daemon>
  <portals>
    ...
  </portals>
</tnw-gateway>
\endcode
%example tnw-gateway

The version of the DTD, which is currently.
(This is not the product version.)
%descr tnw-gateway.version

Current version of DTD.
%descr tnw-gateway.version.1.0

(no default; must be specified)
%default tnw-gateway.version

###

Container for all endpoint and peer portal configuration information.
%descr portals

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
  </daemon>
  <portals>
    <endpoint>
      ...
    </endpoint>
    ...
  </portals>
</tnw-gateway>
\endcode
%example portals

###

Container element for all configuration options of a single peer portal.
%descr peer

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
  </daemon>
  <portals>
    <peer>
      ...
    </peer>
    ...
  </portals>
</tnw-gateway>
\endcode
%example peer

###

DEPRECATED:
Configures the rate at which Daemon Statistics messages are published.
See \ref daemonstatistics for general information on Daemon Statistics.

Informatica requests users to migrate to using the UM configuration file 
to enable automatic monitoring with Protocol Buffer monitoring format for 
Store and DRO by setting \ref monitorformatcontext to "pb".
See \ref automaticmonitoring.
%descr publishing-interval

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    <daemon-monitor topic="umrouter.1">
      <lbm-config>/path/umrouter_monitor.cfg</lbm-config>
      <publishing-interval>
        <group name="default" ivl="5"/>
        <group name="gateway-config" ivl="30"/>
        <group name="portal-config" ivl="30"/>
      </publishing-interval>
      ...
    </daemon-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example publishing-interval

Configures the rate at which one particular grouping of Daemon Statistics
messages are published.
See \ref daemonstatistics for general information on Daemon Statistics.
%descr group

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    <daemon-monitor topic="umrouter.1">
      <lbm-config>/path/umrouter_monitor.cfg</lbm-config>
      <publishing-interval>
        <group name="default" ivl="5"/>
        <group name="gateway-config" ivl="30"/>
        <group name="portal-config" ivl="30"/>
      </publishing-interval>
      ...
    </daemon-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example group

Name of statistics group being configured.
%descr group.name

(no default; must be specified)
%default group.name

Sets a default interval for all message types.
%descr group.name.default

Sets the interval for messages of type
\ref tnwg_dstat_gatewaycfg_msg_t.
%descr group.name.gateway-config

Sets the interval for messages of types
\ref tnwg_rm_stat_grp_msg_t.
%descr group.name.route-manager-topology

Sets the interval for messages of type
\ref tnwg_dstat_mallinfo_msg_t.
%descr group.name.malloc-info

Sets the interval for messages of type
\ref tnwg_pcfg_stat_grp_msg_t.
%descr group.name.portal-config

Sets the interval for messages of type
\ref tnwg_dstat_portalstats_msg_t
%descr group.name.portal-stats

Time, in seconds, between publishing the statistics group being configured.
%descr group.ivl

(no default; must be specified)
%default group.ivl

###

Contains parameters for the keepalive signals sent from this peer portal.
This is a DRO-level keepalive, not to be confused with the
TCP-level \ref droelementkeepalive "<keepalive>" element.
%descr gateway-keepalive

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <gateway-keepalive idle="no" interval="1000"/>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example gateway-keepalive

Determines if DRO keepalives should be sent only
if no traffic has been sent or received in the last interval.
%descr gateway-keepalive.idle

Send only if no traffic has been exchanged.
%descr gateway-keepalive.idle.yes

Send always, even of traffic has been exchanged.
%descr gateway-keepalive.idle.no

yes
%default gateway-keepalive.idle

Minimum interval, in milliseconds, between keepalive messages sent.
Informatica recommends setting this to 2000 or greater.
A value of 0 (zero) disables keepalives.
%descr gateway-keepalive.interval

5000
%default gateway-keepalive.interval

Maximum time, in milliseconds, a peer can receive nothing from the
companion before determining the connection is dead and disconnecting.
We recommend setting this to 3 times the interval value.
%descr gateway-keepalive.timeout

15000
%default gateway-keepalive.timeout

###

Determines timing characteristics for context name queries generated at
this portal.
%descr context-query

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <context-query periodic-interval="25000" max-contexts="15" interval="180" timeout="875"/>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example context-query

Interval (in milliseconds) between groups of context queries.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr context-query.interval

200
%default context-query.interval

Maximum number of contexts for which queries are generated at one time.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr context-query.max-contexts

20
%default context-query.max-contexts

Interval (in milliseconds) at which context queries are generated.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr context-query.periodic-interval

300000
%default context-query.periodic-interval

Minimum time (in seconds) a context query must be unanswered
before it is removed for the portal.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr context-query.timeout

900
%default context-query.timeout

###

Specifies the portal's awareness of received message sequence numbers,
for the purpose of detecting duplicates.
%descr sqn-window

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <sqn-window size="1024" increment="512"/>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example sqn-window

Determines the minimum increment, in topic (fragment) sequence numbers,
by which the sequence number window is moved when the window size
(below) is exceeded.
Must be a multiple of 8, an even divisor of the window size,
and less the window size.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr sqn-window.increment

2048
%default sqn-window.increment

Determines the maximum number of topic (fragment) sequence numbers
maintained in the window, for any given source.
Must be a multiple of 8.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr sqn-window.size

16384
%default sqn-window.size

###

Specifies the portal receiver context name.
%descr receiver-context-name

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <receiver-context-name>RcvContext01</source-context-name>
    </endpoint>                 
  </portals>
</tnw-gateway>
\endcode
%example receiver-context-name

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr receiver-context-name.xml:space

Trim whitespace.
%descr receiver-context-name.xml:space.default

Retain whitespace exactly as entered.
%descr receiver-context-name.xml:space.preserve

\b default
%default receiver-context-name.xml:space

Specifies the portal source context name.
%descr source-context-name

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <source-context-name>SourceContext01</source-context-name>
    </endpoint>                 
  </portals>
</tnw-gateway>
\endcode
%example source-context-name

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr source-context-name.xml:space

Trim whitespace.
%descr source-context-name.xml:space.default

Retain whitespace exactly as entered.
%descr source-context-name.xml:space.preserve

\b default
%default source-context-name.xml:space

###

Checks for interest in patterns at periodic intervals.
<b>This element is deprecated and has no function.</b>
%descr pattern-use-check

%example pattern-use-check

The interval (in milliseconds) at which source pattern are checked to
determine if there is no more interest.
<b>This element is deprecated and has no function.</b>
%descr pattern-use-check.periodic-interval

300000
%default pattern-use-check.periodic-interval

###

Checks for interest in topics at periodic intervals.
<b>This element is deprecated and has no function.</b>
%descr topic-use-check

%example topic-use-check

The interval (in milliseconds) at which source topics are checked to
determine if there is no more interest.
<b>This element is deprecated and has no function.</b>
%descr topic-use-check.periodic-interval

300000
%default topic-use-check.periodic-interval

###

Determines how long a domain remains quiescent until it is determined inactive.
<b>This element is deprecated and has no function.</b>
%descr pattern-domain-activity

%example pattern-domain-activity

Minimum time (in seconds) domain interest for a pattern must be refreshed
before interest is removed for that domain.
<b>This element is deprecated and has no function.</b>
%descr pattern-domain-activity.timeout

900
%default pattern-domain-activity.timeout

###

Determines timing characteristics for interest message generation at this
portal.
<b>This element is deprecated and has no function.</b>
%descr pattern-interest-generate

%example pattern-interest-generate

Interval (in milliseconds) between groups of patterns.
<b>This element is deprecated and has no function.</b>
%descr pattern-interest-generate.interval

200
%default pattern-interest-generate.interval

Maximum patterns for which interest is generated at one time.
<b>This element is deprecated and has no function.</b>
%descr pattern-interest-generate.max-patterns

300000
%default pattern-interest-generate.max-patterns

Interval (in milliseconds) at which pattern interest is generated.
<b>This element is deprecated and has no function.</b>
%descr pattern-interest-generate.periodic-interval

300000
%default pattern-interest-generate.periodic-interval

###

Determines when this portal's proxy receivers can purge pattern.
<b>This element is deprecated and has no function.</b>
%descr pattern-purge

%example pattern-purge

Interval (in milliseconds) at which receiver patterns are checked to
determine if they can be purged.
<b>This element is deprecated and has no function.</b>
%descr pattern-purge.periodic-interval

6000
%default pattern-purge.periodic-interval

###

Determines how long a domain remains quiescent until it is determined inactive.
<b>This element is deprecated and has no function.</b>
%descr topic-domain-activity

%example topic-domain-activity

Minimum time (in seconds) domain interest for a topic must be refreshed
before interest is removed for that domain.
<b>This element is deprecated and has no function.</b>
%descr topic-domain-activity.timeout

900
%default topic-domain-activity.timeout

###

Determines timing characteristics for interest message generation at
this portal.
<b>This element is deprecated and has no function.</b>
%descr topic-interest-generate

%example topic-interest-generate

Interval (in milliseconds) between groups of topics.
<b>This element is deprecated and has no function.</b>
%descr topic-interest-generate.interval

200
%default topic-interest-generate.interval

Maximum topics for which interest is generated at one time.
<b>This element is deprecated and has no function.</b>
%descr topic-interest-generate.max-topics

20
%default topic-interest-generate.max-topics

Interval (in milliseconds) at which topic interest is generated.
<b>This element is deprecated and has no function.</b>
%descr topic-interest-generate.periodic-interval

300000
%default topic-interest-generate.periodic-interval

###

Determines when this portal's proxy receivers can purge topics.
<b>This element is deprecated and has no function.</b>
%descr topic-purge

%example topic-purge

Interval (in milliseconds) at which receiver topics are checked to
determine if they can be purged.
<b>This element is deprecated and has no function.</b>
%descr topic-purge.periodic-interval

6000
%default topic-purge.periodic-interval

###

Contains elements (inbound and outbound ACEs) that specify how an ACL
(Access Control List) filters messages.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr acl

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <acl>
        <inbound>
          <ace>
            <topic>AAA</topic>
          </ace>
        </inbound>
      </acl>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example acl

###

Container for ACE elements, to separate outbound ACEs from inbound ACEs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr outbound

\b Example:

Only forward messages for topics AAA and ABA.
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <acl>
        <outbound>
          <ace>
            <pcre-pattern>^A[AB]A$</pcre-pattern>
          </ace>
        </outbound>
      </acl>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example outbound

###

Within an inbound or outbound ACL, you can have one or more "<ace>" elements.
Each ACE (Access Control Entry) lets you match and accept or reject
messages based on access control conditional elements,
which are the elements contained within an "<ace>" element.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr ace

\b Example:
\code
<tnw-gateway version="1.0">
  <portals>
    <endpoint>
      <name>LAN1</name>
      <lbm-config>lan1.cfg</lbm-config>
      <domain-id>1</domain-id>
        <acl>
          <inbound>
            <ace match="accept">
              <topic>ABC</topic>
            </ace>
            <ace match="accept">
              <topic>DEF</topic>
              <transport value=lbt-rm comparison=eq/>
            </ace>
            <ace match="accept">
              <topic>GHI</topic>
            </ace>
          </inbound>
        </acl>
    </endpoint>
    ...
\endcode
%example ace

This required attribute determines what to do with matched messages.
%descr ace.match

Pass the message.
%descr ace.match.accept

Block the message.
%descr ace.match.reject

(no default; must be specified)
%default ace.match

###

Defines a condition used in an ACE.
Specifically, this matches the message's transport ID number
(see \ref transportlbtipcidsource).
This applies only to LBT-IPC transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr xport-id

\b Example:
\code
            <ace match="accept">
              <xport-id comparison="equal" value="1234"/>
            </ace>
\endcode
%example xport-id

Defines a match condition.
%descr xport-id.comparison

(no default; must be specified)
%default xport-id.comparison

Matches if equal.
%descr xport-id.comparison.eq

Matches if equal.
%descr xport-id.comparison.equal

Matches if not equal.
%descr xport-id.comparison.ne

Matches if not equal.
%descr xport-id.comparison.notequal

Matches if less than.
%descr xport-id.comparison.lt

Matches if less than.
%descr xport-id.comparison.lessthan

Matches if less than or equal to.
%descr xport-id.comparison.le

Matches if less than or equal to.
%descr xport-id.comparison.lessthanequal

Matches if greater than.
%descr xport-id.comparison.gt

Matches if greater than.
%descr xport-id.comparison.greaterthan

Matches if greater than or equal to.
%descr xport-id.comparison.ge

Matches if greater than or equal to.
%descr xport-id.comparison.greaterthanequal

The xport ID number to be compared.
%descr xport-id.value

(no default; must be specified)
%default xport-id.value

###

Defines a condition used in an ACE.
Specifically, this matches the message's TCP source port number
(see \ref transporttcpportsource).
This applies only to TCP transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr tcp-source-port

\b Example:
\code
            <ace match="accept">
              <tcp-source-port comparison="equal" value="1234"/>
            </ace>
\endcode
%example tcp-source-port

Defines a match condition.
%descr tcp-source-port.comparison

(no default; must be specified)
%default tcp-source-port.comparison

Matches if equal.
%descr tcp-source-port.comparison.eq

Matches if equal.
%descr tcp-source-port.comparison.equal

Matches if not equal.
%descr tcp-source-port.comparison.ne

Matches if not equal.
%descr tcp-source-port.comparison.notequal

Matches if less than.
%descr tcp-source-port.comparison.lt

Matches if less than.
%descr tcp-source-port.comparison.lessthan

Matches if less than or equal to.
%descr tcp-source-port.comparison.le

Matches if less than or equal to.
%descr tcp-source-port.comparison.lessthanequal

Matches if greater than.
%descr tcp-source-port.comparison.gt

Matches if greater than.
%descr tcp-source-port.comparison.greaterthan

Matches if greater than or equal to.
%descr tcp-source-port.comparison.ge

Matches if greater than or equal to.
%descr tcp-source-port.comparison.greaterthanequal

The xport ID number to be compared.
%descr tcp-source-port.value

(no default; must be specified)
%default tcp-source-port.value

###

Defines a condition used in an ACE.
Specifically, this matches the message's UDP destination port number
(see \ref transportlbtrmdestinationportsource).
This applies only to LBT-RM transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr udp-destination-port

\b Example:
\code
            <ace match="accept">
              <udp-destination-port comparison="equal" value="1234"/>
            </ace>
\endcode
%example udp-destination-port

Defines a match condition.
%descr udp-destination-port.comparison

(no default; must be specified)
%default udp-destination-port.comparison

Matches if equal.
%descr udp-destination-port.comparison.eq

Matches if equal.
%descr udp-destination-port.comparison.equal

Matches if not equal.
%descr udp-destination-port.comparison.ne

Matches if not equal.
%descr udp-destination-port.comparison.notequal

Matches if less than.
%descr udp-destination-port.comparison.lt

Matches if less than.
%descr udp-destination-port.comparison.lessthan

Matches if less than or equal to.
%descr udp-destination-port.comparison.le

Matches if less than or equal to.
%descr udp-destination-port.comparison.lessthanequal

Matches if greater than.
%descr udp-destination-port.comparison.gt

Matches if greater than.
%descr udp-destination-port.comparison.greaterthan

Matches if greater than or equal to.
%descr udp-destination-port.comparison.ge

Matches if greater than or equal to.
%descr udp-destination-port.comparison.greaterthanequal

The xport ID number to be compared.
%descr udp-destination-port.value

(no default; must be specified)
%default udp-destination-port.value

###

Defines a condition used in an ACE.
Specifically, matches the message's UDP source port number
(see \ref transportlbtrmsourceportlowcontext and \ref transportlbtruportsource).
This applies only to LBT-RM and LBT-RU transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr udp-source-port

\b Example:
\code
            <ace match="accept">
              <udp-source-port comparison="equal" value="1234"/>
            </ace>
\endcode
%example udp-source-port

Defines a match condition.
%descr udp-source-port.comparison

(no default; must be specified)
%default udp-source-port.comparison

Matches if equal.
%descr udp-source-port.comparison.eq

Matches if equal.
%descr udp-source-port.comparison.equal

Matches if not equal.
%descr udp-source-port.comparison.ne

Matches if not equal.
%descr udp-source-port.comparison.notequal

Matches if less than.
%descr udp-source-port.comparison.lt

Matches if less than.
%descr udp-source-port.comparison.lessthan

Matches if less than or equal to.
%descr udp-source-port.comparison.le

Matches if less than or equal to.
%descr udp-source-port.comparison.lessthanequal

Matches if greater than.
%descr udp-source-port.comparison.gt

Matches if greater than.
%descr udp-source-port.comparison.greaterthan

Matches if greater than or equal to.
%descr udp-source-port.comparison.ge

Matches if greater than or equal to.
%descr udp-source-port.comparison.greaterthanequal

The xport ID number to be compared.
%descr udp-source-port.value

(no default; must be specified)
%default udp-source-port.value

###

Defines a condition used in an ACE.
Specifically, this matches the message's multicast group address
(see \ref transportlbtrmmulticastaddresssource).
This applies only to LBT-RM transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr multicast-group

\b Example:
\code
            <ace match="accept">
              <multicast-group comparison="equal" value="1234"/>
            </ace>
\endcode
%example multicast-group

Defines a match condition.
%descr multicast-group.comparison

(no default; must be specified)
%default multicast-group.comparison

Matches if equal.
%descr multicast-group.comparison.eq

Matches if equal.
%descr multicast-group.comparison.equal

Matches if not equal.
%descr multicast-group.comparison.ne

Matches if not equal.
%descr multicast-group.comparison.notequal

Matches if less than.
%descr multicast-group.comparison.lt

Matches if less than.
%descr multicast-group.comparison.lessthan

Matches if less than or equal to.
%descr multicast-group.comparison.le

Matches if less than or equal to.
%descr multicast-group.comparison.lessthanequal

Matches if greater than.
%descr multicast-group.comparison.gt

Matches if greater than.
%descr multicast-group.comparison.greaterthan

Matches if greater than or equal to.
%descr multicast-group.comparison.ge

Matches if greater than or equal to.
%descr multicast-group.comparison.greaterthanequal

The xport ID number to be compared.
%descr multicast-group.value

(no default; must be specified)
%default multicast-group.value

###

Defines a condition used in an ACE.
Specifically, this matches the message's source IP address.
This applies only to TCP, LBT-RM, and LBT-RU transports.

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr source-ip

\b Example:
\code
            <ace match="accept">
              <source-ip comparison="equal" value="1234"/>
            </ace>
\endcode
%example source-ip

Defines a match condition.
%descr source-ip.comparison

(no default; must be specified)
%default source-ip.comparison

Matches if equal.
%descr source-ip.comparison.eq

Matches if equal.
%descr source-ip.comparison.equal

Matches if not equal.
%descr source-ip.comparison.ne

Matches if not equal.
%descr source-ip.comparison.notequal

Matches if less than.
%descr source-ip.comparison.lt

Matches if less than.
%descr source-ip.comparison.lessthan

Matches if less than or equal to.
%descr source-ip.comparison.le

Matches if less than or equal to.
%descr source-ip.comparison.lessthanequal

Matches if greater than.
%descr source-ip.comparison.gt

Matches if greater than.
%descr source-ip.comparison.greaterthan

Matches if greater than or equal to.
%descr source-ip.comparison.ge

Matches if greater than or equal to.
%descr source-ip.comparison.greaterthanequal

The xport ID number to be compared.
%descr source-ip.value

(no default; must be specified)
%default source-ip.value

###

Defines a condition used in an ACE.
Specifically, this matches a UM transport type
(see \ref transportsource).

\note The message's originating source might be remote
(i.e. not be in this DRO portal's TRD).
In that case, this condition matches the TRD-local proxy source's
characteristic, not the originating source.

This conditional element can only be used in inbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr transport

\b Example:
\code
            <ace match="accept">
              <transport comparison="equal" value="lbtrm"/>
            </ace>
\endcode
%example transport

Defines a match condition.
%descr transport.comparison

Matches if equal.
%descr transport.comparison.eq

Matches if equal.
%descr transport.comparison.equal

Matches if not equal.
%descr transport.comparison.ne

Matches if not equal.
%descr transport.comparison.notequal

(no default; must be specified)
%default transport.comparison

The transport type to be matched.
%descr transport.value

TCP transport.
%descr transport.value.tcp

LBT-RM transport.
%descr transport.value.lbt-rm

LBT-RM transport.
%descr transport.value.lbtrm

LBT-RU transport.
%descr transport.value.lbt-ru

LBT-RU transport.
%descr transport.value.lbtru

IPC transport.
%descr transport.value.lbt-ipc

IPC transport.
%descr transport.value.lbtipc

(no default; must be specified)
%default transport.value

###

Defines a condition used in an ACE.
Specifically, this is a match pattern for one or more topics
using a POSIX regular expression.

<b>This element is deprecated.
Please use \ref droelementpcrepattern "<pcre-pattern>" </b>.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr regex-pattern

%example regex-pattern

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr regex-pattern.xml:space

Trim whitespace.
%descr regex-pattern.xml:space.default

Retain whitespace exactly as entered.
%descr regex-pattern.xml:space.preserve

\b default
%default regex-pattern.xml:space

###

Defines a condition used in an ACE.
Specifically, this is a match pattern for one or more topics
using a Perl Compatible Regular Expression (PCRE).

This conditional element can be use in both inbound and outbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr pcre-pattern

\b Example \b 1:

This example will match patterns "ABC", "ABC789", and "ABC".
It will not match "abc" or "123ABC".
\code
            <ace match="accept">
              <pcre-pattern>
                ^ABC.*
              </pcre-pattern>
            </ace>
\endcode

\b Example \b 2:

In this example, match any topic that has one or more spaces anywhere in the
topic name.
Note that the "xml:space" attribute defaults to "default", which
trims leading and trailing spaces.
Therefore that attribute must set to "preserve", and the pattern must be
combined onto a single line (to avoid newlines in the pattern):
\code
            <ace match="accept">
              <pcre-pattern xml:space="preserve"> </pcre-pattern>
            </ace>
\endcode

%example pcre-pattern

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr pcre-pattern.xml:space

Trim whitespace.
%descr pcre-pattern.xml:space.default

Retain whitespace exactly as entered.
%descr pcre-pattern.xml:space.preserve

\b default
%default pcre-pattern.xml:space

###

Defines a condition used in an ACE.
Specifically, this matches a topic name.

This conditional element can be use in both inbound and outbound ACLs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr topic

\b Example \b 1:

Accept messages for topic "ABC":
\code
            <ace match="accept">
              <topic>ABC</topic>
            </ace>
\endcode

\b Example \b 2:

To match a topic name that includes a trailing space, you must use
the change the xml:space attribute value:
\code
            <ace match="accept">
              <topic xml:space="preserve">ABC </topic>
            </ace>
\endcode
%example topic

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr topic.xml:space

Trim whitespace.
%descr topic.xml:space.default

Retain whitespace exactly as entered.
%descr topic.xml:space.preserve

\b default
%default topic.xml:space

###

Container for ACE elements, to separate inbound ACEs from outbound ACEs.

See \ref accesscontrollistsacl for information on how ACLs work.
%descr inbound

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <acl>
        <inbound>
          <ace>
            <topic>AAA</topic>
          </ace>
        </inbound>
      </acl>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example inbound

###

Container for individual UM-option-setting elements.
It lets you set individual UM attributes without referencing a UM
configuration file.
These values override any values set via files referenced by
\ref droelementlbmconfig "<lbm-config>".

\note Due to the order in which configuration options are processed,
options specified in <lbm-attributes> do <b>not</b> override defaults set
in \ref droelementxmlconfig "<xml-config>".
UM XML configuration files are flexible enough to allow proper
overriding of common templates using named contexts.
See \ref droelementreceivercontextname "<receiver-context-name>"
and \ref droelementsourcecontextname "<source-context-name>".
%descr lbm-attributes

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <name>E2</name>
      <domain-id>1</domain-id>
      <lbm-attributes>
        <option scope="context" name="request_tcp_interface" value="10.28.5.5" />
        <option scope="context" name="response_tcp_interface" value="127.0.0.1" />
      </lbm-attributes>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example lbm-attributes

###

Lets you set an individual UM configuration option without referencing a
UM configuration file.
This value overrides any values set via files referenced by
\ref droelementlbmconfig "<lbm-config>".

\note Some UM options specify interfaces,
which can be done by supplying the device name of the interface.
Special care must be taken when supplying device names.
See \ref interfacedevicenamesandxml for details.
%descr option

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <name>E2</name>
      <domain-id>1</domain-id>
      <lbm-attributes>
        <option scope="context" name="request_tcp_interface" value="10.28.5.5" />
        <option scope="context" name="response_tcp_interface" value="127.0.0.1" />
      </lbm-attributes>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example option

The type of object to which an option can apply.
%descr option.scope

Receiver option.
%descr option.scope.receiver

Source option.
%descr option.scope.source

Context option.
%descr option.scope.context

Wildcard Receiver option.
%descr option.scope.wildcard_receiver

Event queue option.
%descr option.scope.event_queue

(no default; must be specified)
%default option.scope

The name of the option.
%descr option.name

(no default; must be specified)
%default option.name

The value for the option.
%descr option.value

(no default; must be specified)
%default option.value

###

Specifies the UM configuration file that contains configuration options
associated with this portal.

Note that as of UM version 6.13,
if one or more errors are discovered in the UM configuration file,
the errors are written to the log file and the DRO continues running.
I.e. errors in the UM configuration file are treated as warnings.
See \ref configurationerrorhandling for an explanation.
%descr lbm-config

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <name>E2</name>
      <domain-id>1</domain-id>
      <lbm-config>/path/endpoint2.cfg</lbm-config>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example lbm-config

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr lbm-config.xml:space

Trim whitespace.
%descr lbm-config.xml:space.default

Retain whitespace exactly as entered.
%descr lbm-config.xml:space.preserve

\b default
%default lbm-config.xml:space

###

Contains batching size and timing parameters for peer link implicit batching.
This applies to data messages only:
the DRO sends control messages immediately
(flushing any batched data messages).
Note: worst-case latency can be dramatically reduced by combining
batching with \ref droelementsmartbatch "<smart-batch>".
%descr batching

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <peer>
      <batching>
        <min-length>4096</min-length>
        <batch-interval>500</batch-interval>
      </batching>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example batching

###

Specifies the maximum interval (in milliseconds)
between when the first message of a batch is queued until the batch is sent.
A message stays in the batch queue until this value or
\ref droelementminlength "<min-length>" is met or exceeded
(whichever occurs first).
The minimum allowed value is 3 milliseconds.

If not specified, it defaults to 200 milliseconds.
%descr batch-interval

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <batching>
        <min-length>4096</min-length>
        <batch-interval>500</batch-interval>
      </batching>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example batch-interval

###

Specifies the minimum length of a set of batched messages.
When the total length of the batched messages reaches or exceeds this value,
the batch is sent.

If not specified, it defaults to 8192 bytes.
%descr min-length

\b Example:
\code
<tnw-gateway version="1.0">
  ... 
  <portals>
    <peer>
      <batching>
        <min-length>4096</min-length>
        <batch-interval>500</batch-interval>
      </batching>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example min-length

###

Specifies the maximum datagram size a peer portal will allow the
\ref droelementbatching "peer link batcher" to construct.

Note that this does not actually limit the size of the datagrams
that can transit the peer link, it only limits the batching.
For example, if this element is set to 4,000 and a series of
1K messages are sent, approximately 4 messages will be batched
(depending on overhead) and forwarded across the peer link.
However, if an 8K message is sent, it will be forwarded
across the peer link as an 8K datagram.

Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.

If not specified, it defaults to 65500,
which is also the maximum allowable value.
%descr max-datagram

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <max-datagram>50000</max-datagram>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example max-datagram

###

Enables the smart batching algorithm used by the DRO when
forwarding messages from one portal to another.
Possible values are 0 (disable) and 1 (enable).

If not specified, it defaults to 0 (disabled).

In general, batching algorithms are used to increase throughput,
but many such algorithms can produce latency outliers.
The Smart Batching algorithm is designed to ensure low latencies by
flushing the batching buffer when no more messages are waiting to be sent
out the portal.

Smart batching works with both endpoint and peer portals.
For endpoint portals, a UM configuration file may be provided to set
the implicit_batching_minimum_length (source) option to a large value.
For peer portals, the \ref droelementbatching "<batching>" element
may be used to set the \ref droelementminlength "<min-length>" to a
large value.
In either case, large values are recommended and will not produce
significant latency outliers.

%descr smart-batch

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <peer>
      <smart-batch>1</smart-batch>
      <batching>
        <min-length>4096</min-length>
      </batching>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example smart-batch

###

Sets the maximum buffer size in bytes for blocking messages.

If not specified, this defaults to 1000000 bytes.
%descr max-queue

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <max-queue>500000</max-queue>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example max-queue

###

Sets the maximum buffer size in bytes for UIM messages.

If not specified, it defaults to 0 which implements legacy uim-queue-size behavior of 10% of queue-size.
%descr uim-max-queue

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <uim-max-queue>500000</max-queue>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example uim-max-queue

###

Used with \ref drohotlinks feature.

Range: 0-65535
If not specified, it defaults to 1.
Route group numbers can be re-used in different TRDs.
%descr route-group

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <hotlink-index>1</hotlink-index>
      <route-group>1</route-group>
      <route-group>2</route-group>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example route-group


###

Used with \ref drohotlinks feature.

Range: 0-65535
If not specified, it defaults to 0 (do not participate in hotlink).
Every DRO operating in hotlink mode must have a unique hotlink index
value within a given TRD.
Index values can be reused in different TRDs.
%descr hotlink-index

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <hotlink-index>0</hotlink-index>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example hotlink-index

Sets the time in milliseconds to wait after a source is detected as deleted
before deleting the proxy source.
Applies to both endpoint and peer portals.

Sources can be detected as being deleted by an EOS event at an endpoint
portal, or by a route map change.
Note that a route map change could be due to failure of a DRO or link
within a network.

If not specified, source-deletion-delay defaults to 1000 milliseconds.
%descr source-deletion-delay

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <source-deletion-delay>2000</source-deletion-delay>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example source-deletion-delay

###

Enables the \ref receivemultipledatagrams feature for
the \ref udppeerlink and specifies the maximum number
of datagrams to read at a time.

See \ref multiplereceivemaximumdatagramscontext
for more details.

Note that each peer portal of a DRO that uses a
UDP peer link has an independent setting for
multiple-receive-max-datagrams.
I.e. different portals can have different
values configured.

If not specified, the default value is 0,
which disables receiving multiple datagrams.

For high-throughput applications,
Informatica recommends setting this between
10 and 100
(larger values will consume more memory).
%descr multiple-receive-max-datagrams

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <multiple-receive-max-datagrams>
          0
        </multiple-receive-max-datagrams>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example multiple-receive-max-datagrams

###

Sets the coalesce threshold for the \ref udppeerlink.

Corresponds to \ref transportlbtrucoalescethresholdsource.

This should normally be left at its default (15).
%descr coalesce-threshold

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <coalesce-threshold>15</coalesce-threshold>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example coalesce-threshold

###

Controls the \ref udppeerlink memory buffer used to retransmit
datagrams that are lost/dropped.
This element has no base value,
but has several attributes that control the transmission window.
%descr transmission-window

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <transmission-window size="25165824" limit="0"/>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example transmission-window

#

Number of bytes of user message data to store in the
transmission window,
not including internal overhead bytes.

Corresponds to \ref transportlbtrutransmissionwindowsizesource.
%descr transmission-window.size

25165824
%default transmission-window.size

#

Limit on memory used by transmission window,
including internal overhead bytes.
Value of 0 indicates no limit (but the
"size" attribute imposes its own limit).

Corresponds to \ref transportlbtrutransmissionwindowlimitsource.
%descr transmission-window.limit

0
%default transmission-window.limit

###

Controls the rate limiter for the \ref udppeerlink.
This element has no base value,
but has several attributes that control the rate limiter.

Note that each peer portal of a DRO that uses a
UDP peer link has an independent rate limiter.
I.e. traffic sent on one peer link does not count
against the rate limiter for a different peer link.
%descr peer-rate-limit

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <peer-rate-limit data="10000000" retransmit="5000000" interval="100"/>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example peer-rate-limit

#

Maximum transmission rate (in bits per second) for the UDP
data sent by this peer portal, including internal overhead bytes.

Corresponds to \ref transportlbtrudataratelimitcontext.
%descr peer-rate-limit.data

10000000
%default peer-rate-limit.data

#

Maximum transmission rate (in bits per second) for the UDP
data re-sent by this peer portal, including internal overhead bytes.
Data is re-sent if it is lost and the peer requests retransmission
by sending NAKs.

Corresponds to \ref transportlbtruretransmitratelimitcontext.
%descr peer-rate-limit.retransmit

5000000
%default peer-rate-limit.retransmit

#

Period (in milliseconds) that the UDP peer link rate limiter runs.

Corresponds to \ref transportlbtrurateintervalcontext.
%descr peer-rate-limit.interval

100
%default peer-rate-limit.interval

###

Controls the algorithms used to repair lost
datagrams for the \ref udppeerlink.
This element has no base value,
but has several attributes that control the
NAK algorithms.
%descr nak-handling

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <nak-handling initial-backoff-interval="0" backoff-interval="200"
            suppress-interval="1000" generation-interval="10000"
            ignore-interval="100" send-naks="yes"/>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example nak-handling

#

The interval in milliseconds between the detection of loss
and the transmission of the first NAK.

Corresponds to \ref transportlbtrunakinitialbackoffintervalreceiver.
%descr nak-handling.initial-backoff-interval

0
%default nak-handling.initial-backoff-interval

#

The maximum interval in milliseconds between NAKs
for a given datagram, after the first NAK.

Corresponds to \ref transportlbtrunakbackoffintervalreceiver.
%descr nak-handling.backoff-interval

200
%default nak-handling.backoff-interval

#

The time in milliseconds that peer link receiver will suppress sending a NAK
for a given missing datagram after an NCF is received from the peer.

Corresponds to \ref transportlbtrunaksuppressintervalreceiver.
%descr nak-handling.suppress-interval

1000
%default nak-handling.suppress-interval

#

The maximum time in milliseconds that a lost datagram may be
outstanding before the datagram is declared unrecoverable.

Corresponds to \ref transportlbtrunakgenerationintervalreceiver.
%descr nak-handling.generation-interval

10000
%default nak-handling.generation-interval

#

The interval in milliseconds that a sender will ignore
additional NAKs after a retransmission is sent.

Corresponds to \ref transportlbtruignoreintervalsource.
%descr nak-handling.ignore-interval

100
%default nak-handling.ignore-interval

#

Controls the sending of NAKs for missing packets.

Corresponds to \ref transportlbtrusendnaksreceiver.
%descr nak-handling.send-naks

Send NAKs to recover missing packets.
%descr nak-handling.send-naks.yes

Do not send NAKs to recover missing packets.
(Missing packets will not be recovered.)
%descr nak-handling.send-naks.no

yes
%default nak-handling.send-naks

###

Controls the sending of session (keep alive) messages
for the \ref udppeerlink.
This element has no base value,
but has several attributes that control the session messages.
%descr session-message

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <session-message min-interval="200" max-interval="10000" activity-timeout="60000"/>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example session-message

#

The minimum time in milliseconds between session messages.

Corresponds to \ref transportlbtrusmminimumintervalsource.
%descr session-message.min-interval

200
%default session-message.min-interval

#

The maximum time in milliseconds between session messages.

Corresponds to \ref transportlbtrusmmaximumintervalsource.
%descr session-message.max-interval

10000
%default session-message.max-interval

#

The time in milliseconds during which a lack of messages
(data or session) indicates that the connection is
terminated.

Corresponds to \ref transportlbtruactivitytimeoutreceiver.
%descr session-message.activity-timeout

60000
%default session-message.activity-timeout

###


%descr connect

Controls the algorithms used to establish
a connection for the \ref udppeerlink.
This element has no base value,
but has several attributes that control the
connection algorithms.

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        ...
        <connect attempt-interval="200" max-attempts="10"/>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example connect

#

Time, in milliseconds, between connect retry attempts.
%descr connect.attempt-interval

200
%default connect.attempt-interval

#

Number of times the UDP link will be retried
before the portal gives up and re-initializes.
Note that when the portal re-initializes,
the initiator will again try to start both
the TCP and the UDP links.
%descr connect.max-attempts

10
%default connect.max-attempts

###

Enables the \ref udppeerlink functionality.

Adds a UDP-based protocol, similar to \ref transportlbtru,
to the peer link for message data.
Note that the \ref droelementsingletcp "TCP peer link" is still needed
for command and control of the peer link.

At a minimum you must configure the port number
using \ref droelementport.
Note that the port number supplied under "<udp>"
is independent from the port number supplied
under \ref droelementsingletcp "<single-tcp>".
%descr udp

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        ...
      </single-tcp>
      <udp>
        <port>12000</port>
        ...
      </udp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example udp

###

Contains elements for a peer portal's tcp settings,
when configuring the peer.

Note: the term "single-tcp" is an unfortunate artifact from earlier versions
of UM that also supported a dual TCP peer link.
That feature was eliminated,
leaving "single-tcp" as the only available type of peer link.
The name "single-tcp" does not imply "tcp-only";
the optional \ref droelementudp is available under <single-tcp>.
%descr single-tcp

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <interface>10.28.5.5/24</interface>
        <acceptor>
          <listen-port>23746</listen-port>
        </acceptor>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example single-tcp

###

Contains the listen port address of the corresponding acceptor peer portal
on another DRO, to which this peer is connected.
This element is used in single-tcp peer configurations.
%descr acceptor

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <acceptor>
          <listen-port>25000</port>
        </acceptor>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example acceptor

###

Contains port number on which an acceptor peer portal listens for
connections from the initiating peer portal.
There is no default for the port number,
the initiating peer portal configuration must specify this port as its
initiator port.
%descr listen-port

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <acceptor>
          <listen-port>46000</listen-port>
        </acceptor>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example listen-port

###

Contains the IP address and the port of the corresponding acceptor peer
portal on another DRO, to which this peer is connected.
This element is used in single-tcp peer configurations.
%descr initiator

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <initiator>
          <address>10.28.3.91</address>
          <port>25000</port>
        </initiator>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example initiator

The time interval, in milliseconds, to wait before reconnecting to
the companion portal if this connection is interrupted.
%descr initiator.reconnect-interval

5000
%default initiator.reconnect-interval

###

Used by the peer link for both \ref droelementsingletcp "<single-tcp>"
and the optional \ref droelementudp "<udp>" elements.

For TCP, contains the IP port used by the initiator to
connect to the acceptor portal's \ref droelementlistenport.

For UDP, contains the IP port that the portal uses for
both incoming and outgoing data.

The TCP and UDP ports are independent of each other.

(As of UM version 6.10, dual TCP (\ref droelementtcp "<tcp>") is no
longer supported.
Please use \ref droelementsingletcp "<single-tcp>" instead.)
%descr port

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <initiator>
          <address>10.28.3.91</address>
          <port>25000</port>
        </initiator>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example port

###

Contains the IP address of the acceptor peer portal on another DRO,
to which this initiator peer is connected via "single TCP".
(As of UM version 6.10, dual TCP (\ref droelementtcp "<tcp>") is no
longer supported.
Please use \ref droelementsingletcp "<single-tcp>" instead.)
%descr address

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <initiator>
          <address>10.28.3.91</address>
          <port>25000</port>
        </initiator>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example address

###

Contains elements to configure TCP-only peer link encryption.
%descr tls

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <certificate>test.crt<certificate>
          <certificate-key>test.key<certificate-key>
          <certificate-key-password>
            CorrectHorseBatteryStaple
          </certificate-key-password>
          <trusted-certificates>peers.crt<trusted-certificates>
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example tls

###

Defines the list of one or more (comma separated) names of cipher suites
that the context will accept.
See OpenSSL's <a href="https://www.openssl.org/docs/manmaster/man1/openssl-ciphers.html#CIPHER-SUITE-NAMES">Cipher Suite Names</a>
for the full list of suite names.
When configuring UM, use the OpenSSL names (with dashes),
*not* the IANA names (with underscores).

If more than one suite name is supplied,
they should be in descending order of preference.
When a remote context negotiates encrypted TCP,
the two sides must find a cipher suite in common,
otherwise the connection will be canceled.

The default is highly secure and is recommended.
%descr cipher-suites

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <cipher-suites>TLS_DHE_RSA_WITH_AES_256_GCM_SHA384<cipher-suites>
          ...
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example cipher-suites

###

Specifies the path to a file containing one or more OpenSSL-compatible
PEM-formatted TLS client certificates and certificate authorities.
If this element is not supplied, the default behavior is to use the
system-level trusted certificates and certificate authorities
(operating-system dependent).
The TLS server uses these trusted certificates to verify the identity of
connecting clients.
If a client connects and presents a certificate which is not in the
server's trusted certificates file, the connection will be canceled.
%descr trusted-certificates

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <trusted-certificates>peers.crt<trusted-certificates>
          ...
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example trusted-certificates

###

Specifies the passphrase needed to decrypt the server private key file
specified by \ref droelementcertificatekey "<certificate-key>".
%descr certificate-key-password

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <certificate-key-password>
            CorrectHorseBatteryStaple
          </certificate-key-password>
          ...
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example certificate-key-password

###

Specifies the path to a file containing the private key associated with the
"server" certificate specified by \ref droelementcertificate "<certificate>".
Note that this private key must be protected from intruders.
For that reason, when the certificate and private key files are generated,
the private key file is typically encrypted with a passphrase.
The passphrase is supplied using
\ref droelementcertificatekeypassword "<certificate-key-password>".
%descr certificate-key

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <certificate-key>test.key<certificate-key>
          ...
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example certificate-key

###

Specifies the path to a file containing an OpenSSL-compatible PEM-formatted
certificate that will be presented as the TLS server certificate when a TLS
connection is established by a client.
%descr certificate

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <tls>
          <certificate>test.crt<certificate>
          ...
        </tls>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example certificate

###

Enables compression and sets the desired data compression algorithm for the
TCP-only peer link.
Currently, only LZ4 lossless data compression is supported.

If not specified, no compression is used.
%descr compression

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <compression>LZ4</compression>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example compression

###

Enables setting the TCP_NODELAY socket option on the peer link.
Setting TCP_NODELAY disables Nagle's algorithm,
which somewhat decreases the efficiency and throughput of TCP,
but decreases the latency of individual messages.

By default, TCP_NODELAY is not set (maximizes efficiency).
%descr nodelay

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <nodelay/>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example nodelay

###

When present, enables a TCP keepalive signal transmission, which is
disabled by default.
%descr keepalive

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <peer>
      <single-tcp>
        <keepalive/>
      . . .
      . . .
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example keepalive

###

Contains the size of the send-side socket buffer.

The default value depends on the parent element:
<ul>
<li>For \ref droelementsingletcp, the default is 0,
which allows the OS to do TCP autotuning.
If not specified, the DRO uses the system default size.
<li>For \ref droelementudp, the default is 1048576.
</ul>
%descr send-buffer

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <send-buffer>128000</send-buffer>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example send-buffer

###

Contains the size of the receive-side socket buffer.

The default value depends on the parent element:
<ul>
<li>For \ref droelementsingletcp, the default is 0,
which allows the OS to do TCP autotuning.
If not specified, the DRO uses the system default size.
<li>For \ref droelementudp, the default is 8388608.
</ul>
%descr receive-buffer

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <receive-buffer>128000</receive-buffer>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example receive-buffer

###

Contains the IP host or network address for this peer portal,
specified in dotted-decimal or CIDR format.
%descr interface

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <peer>
      <single-tcp>
        <interface>10.28.5.5/24</interface>
        ...
      </single-tcp>
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example interface

###

<b>DEPRECATED AND ELIMINATED AS OF UM 6.10. DO NOT USE.</b>
Contains elements for a peer portal's "dual TCP" settings.
(As of UM version 6.10, dual TCP (\ref droelementtcp "<tcp>") is no
longer supported.
Please use \ref droelementsingletcp "<single-tcp>" instead.)
%descr tcp

%example tcp

###

<b>DEPRECATED AND ELIMINATED AS OF UM 6.10. DO NOT USE.</b>
Contains the IP address and the port of the companion peer portal on
another DRO, to which this peer is connected via "dual TCP".
(As of UM version 6.10, dual TCP (\ref droelementtcp "<tcp>") is no
longer supported.
Please use \ref droelementsingletcp "<single-tcp>" instead.)
%descr companion

%example companion

%descr companion.reconnect-interval

%default companion.reconnect-interval

###

Sets the size of the peer portal's source map.
This normally does not need to be modified, but if very large numbers of
topics are being used, a larger value might improve efficiency.
%descr sourcemap

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <peer>
      <sourcemap size="131072"/>
      . . .
      . . .
    </peer>
  </portals>
</tnw-gateway>
\endcode
%example sourcemap

Number of entries in the source map.
Value must be a power of 2 (e.g., 1024, 2048, ...).
%descr sourcemap.size

131072
%default sourcemap.size

###

Assigns a positive non-zero integer cost to the portal.

If not specified, it defaults to 1.
See \ref forwardingcosts.
%descr cost

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <cost>25</cost>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example cost

###

Lets you set a name for this DRO
(do not duplicate for any other known DROs),
or for the name of an endpoint or peer portal.
Each portal name must be unique within the DRO.

If not specified, no name is assigned.
%descr name

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    <name>DRO1</name>
  </daemon>
  <portals>
    <endpoint>
      <name>endpoint1</name>
      ...
    </endpoint>
  </portals>
  ...
</tnw-gateway>
\endcode
%example name

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr name.xml:space

Trim whitespace.
%descr name.xml:space.default

Retain whitespace exactly as entered.
%descr name.xml:space.preserve

\b default
%default name.xml:space

###

Container element for all configuration options of a single endpoint portal.
%descr endpoint

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
  ...
  </daemon>
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <cost>1</cost>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example endpoint

###

Determines timings and limits for determination of continued pattern
interest at this portal.
%descr remote-pattern

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <remote-pattern check-interval="80000" max-patterns="80" timeout="250000"/>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example remote-pattern

Interval (in milliseconds) between checking individual patterns for
continued interest.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-pattern.check-interval

90000
%default remote-pattern.check-interval

Maximum number of patterns to check at a time.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-pattern.max-patterns

100
%default remote-pattern.max-patterns

Minimum time (in milliseconds) remote interest for a pattern must be
refreshed before interest is removed for that domain.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-pattern.timeout

300000
%default remote-pattern.timeout

###

Determines timings and limits for determination of continued topic
interest at this portal.
%descr remote-topic

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <endpoint>
      <remote-topic check-interval="80000" max-topics="80" timeout="250000"/>
    </endpoint>                 
  </portals>
</tnw-gateway>
\endcode
%example remote-topic

Interval (in milliseconds) between checking individual topics for
continued interest.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-topic.check-interval

90000
%default remote-topic.check-interval

Maximum number of topics to check at a time.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-topic.max-topics

100
%default remote-topic.max-topics

Minimum time (in milliseconds) remote interest for a topic must be
refreshed before interest is removed for that domain.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr remote-topic.timeout

300000
%default remote-topic.timeout

###

<b>DEPRECATED AND ELIMINATED. DO NOT USE.</b>
Determines how Late Join is handled by this endpoint portal.
%descr late-join

%example late-join

%descr late-join.forward

%descr late-join.forward.yes

%descr late-join.forward.no

%default late-join.forward

%descr late-join.provide

%descr late-join.provide.source

%descr late-join.provide.always

%descr late-join.provide.never

%default late-join.provide

###

Container for DRO topic resolution behavior options.
%descr topic-resolution

\b Example:
\code
<tnw-gateway version="1.0">
      . . .
      . . .
  <portals>
    <endpoint>
      <topic-resolution>
        <initial-request>
          <rate-limit/>
        </initial-request>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example topic-resolution

###

Sets interval and duration for initial topic resolution requests.
%descr initial-request

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <initial-request duration="15" periodic-interval="800"/>
        </topic-use-query>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example initial-request

The minimum duration for which the initial topic resolution requests are sent.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr initial-request.duration

10
%default initial-request.duration

The interval at which the initial topic resolution requests are sent.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr initial-request.periodic-interval

1000
%default initial-request.periodic-interval

###

Sets maximum and minimum limits for the interval between periodic domain
route messages being sent for each remote domain that the portal is servicing.
%descr domain-route

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <domain-route min-interval="100" max-interval="1000">
          <rate-limit bps="0" objects-per-second="50"/>
        </domain-route>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example domain-route

The minimum interval, in milliseconds, between domain route messages being sent for each domain.
%descr domain-route.min-interval

100
%default domain-route.min-interval

The maximum interval, in milliseconds,
between domain route messages being sent for each domain.
%descr domain-route.max-interval

1000
%default domain-route.max-interval

###

Sets rate limits for topic resolution data sent over the network.

You can set rate limits individually for each of the
topic resolution message types (see children elements).
%descr rate-limit

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <topic-use-query max="6" periodic-interval="250000" timeout="4000"/>
          <rate-limit bps="550000" objects-per-second="0"/>
        </topic-use-query>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example rate-limit

The limit in Bits per Second that data will be sent on the network.
A value of 0 disables limiting by bits per second.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr rate-limit.bps

\b "500000" (For use queries and interest messages)
<br>\b "0" (For domain route messages)
%default rate-limit.bps

The limit in Objects per Second that data will be sent on the network.
A value of 0 disables limiting by objects per second.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr rate-limit.objects-per-second

\b "500" (For use queries)
<br>\b "0" (For interest messages)
<br>\b "50" (For domain route messages)
%default rate-limit.objects-per-second

###

Sets parameters for when and how often this endpoint portal sends pattern
interest messages
%descr remote-pattern-interest

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <remote-pattern-interest min-interval="1000" max-interval="90000">
          <rate-limit/>
        </remote-pattern-interest>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example remote-pattern-interest

The minimum interval, in milliseconds, between pattern interest messages
being sent for each pattern the portal has interest in.
%descr remote-pattern-interest.min-interval

1000
%default remote-pattern-interest.min-interval

The maximum interval, in milliseconds, between pattern interest messages
being sent for each pattern the portal has interest in.
%descr remote-pattern-interest.max-interval

60000
%default remote-pattern-interest.max-interval

###

Sets parameters for when and how often this endpoint portal sends topic
interest messages.
%descr remote-topic-interest

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <remote-topic-interest min-interval="1000" max-interval="90000">
          <rate-limit/>
        </remote-topic-interest>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example remote-topic-interest

The minimum interval, in milliseconds, between topic interest messages
being sent for each topic the portal has interest in.
%descr remote-topic-interest.min-interval

1000
%default remote-topic-interest.min-interval

The maximum interval, in milliseconds, between topic interest messages
being sent for each topic the portal has interest in.
%descr remote-topic-interest.max-interval

60000
%default remote-topic-interest.max-interval

###

Sets parameters for when and how often this endpoint portal sends pattern
use queries.
%descr pattern-use-query

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <pattern-use-query max="6" periodic-interval="250000" timeout="4000">
          <rate-limit/>
        </topic-use-query>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example pattern-use-query

Maximum number of pattern use queries to send for a given pattern,
each separated by the timeout value before giving up and removing the topic
from the topic list.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr pattern-use-query.max

5
%default pattern-use-query.max

The interval, in milliseconds, between periodic pattern use queries being
sent for each pattern the portal has interest in.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr pattern-use-query.periodic-interval

300000
%default pattern-use-query.periodic-interval

The maximum time, in milliseconds, to wait for a pattern use response.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr pattern-use-query.timeout

3000
%default pattern-use-query.timeout

###

Sets parameters for when and how often this endpoint portal sends topic
use queries.
%descr topic-use-query

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <topic-resolution>
        <topic-use-query max="6" periodic-interval="250000" timeout="4000">
          <rate-limit/>
        </topic-use-query>
      </topic-resolution>
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example topic-use-query

Maximum number of topic use queries to send for a given topic,
each separated by the timeout value before giving up and removing the topic
from the topic list.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr topic-use-query.max

5
%default topic-use-query.max

The interval, in milliseconds, between periodic topic use queries being
sent for each topic the portal has interest in.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr topic-use-query.periodic-interval

300000
%default topic-use-query.periodic-interval

The maximum time, in milliseconds, to wait for a topic use response.
Before changing the value of this option, please
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>.
%descr topic-use-query.timeout

3000
%default topic-use-query.timeout

###

Identifies the TRD for this endpoint portal.
It must be unique within the DRO (which means that for any TRD,
you can assign only one endpoint portal per DRO).
Also, all endpoints interfacing a given TRD must have the same
\`<domain-id>\` value.

There is no default, it must be supplied.
%descr domain-id

\b Example:
\code
<tnw-gateway version="1.0">
  ...
  <portals>
    <endpoint>
      <name>E1</name>
      <domain-id>1</domain-id>
      <cost>1</cost>
      ...
    </endpoint>
  </portals>
</tnw-gateway>
\endcode
%example domain-id

###

Container for options common to the entire DRO process.
%descr daemon

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
  </daemon>
  ...
</tnw-gateway>
\endcode
%example daemon

###

Lets you set timing parameters for DRO rerouting route calculation
behavior.
%descr route-recalculation

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <route-recalculation backoff-interval="5000" warning-interval="10000"/>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example route-recalculation

How long, in milliseconds, the DRO waits after the last detected
change in topology before initiating a route recalculation.
%descr route-recalculation.backoff-interval

5000
%default route-recalculation.backoff-interval

How long, in milliseconds, the DRO waits before warning that a
route recalculation is being held up due to a non-converging topology.
%descr route-recalculation.warning-interval

10000
%default route-recalculation.warning-interval

###

Lets you set control parameters for DRO initial route setup
(or reroute) behavior.
%descr route-info

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <route-info propagation-interval="1000" check-interval="750" timeout="4000" max-hop-count="100"/>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example route-info

The time interval between route information messages that the
DRO sends to other DRO.
%descr route-info.propagation-interval

1000
%default route-info.propagation-interval

How often the DRO checks to see if a route information message needs
to be sent, a DRO has timed out, and/or the routes need to
be recalculated.
%descr route-info.check-interval

750
%default route-info.check-interval

How long a DRO waits after receiving no route information messages
from another DRO before determining that that DRO is out of
service or unreachable.
%descr route-info.timeout

4000
%default route-info.timeout

The maximum number of DROs a route information message can traverse
before being discarded.
%descr route-info.max-hop-count

100
%default route-info.max-hop-count

###

Specifies the UM XML configuration file.
%descr xml-config

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <xml-config>configfile.xml</xml-config>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example xml-config

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr xml-config.xml:space

Trim whitespace.
%descr xml-config.xml:space.default

Retain whitespace exactly as entered.
%descr xml-config.xml:space.preserve

\b default
%default xml-config.xml:space

###

<b>DEPRECATED AND ELIMINATED. DO NOT USE.</b>
Specifies the difference between the shortest and longest propagation
delays in the network.
%descr propagation-delay

%example propagation-delay

%descr propagation-delay.delta

%default propagation-delay.delta

###

DEPRECATED:
Configures the Daemon Statistics feature.
See \ref daemonstatistics for general information on Daemon Statistics.

Informatica requests users to migrate to using the UM configuration file 
to enable automatic monitoring with Protocol Buffer monitoring format for 
Store and DRO by setting \ref monitorformatcontext to "pb".
See \ref automaticmonitoring.
%descr daemon-monitor

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <daemon-monitor topic="umrouter.1">
      <lbm-config>/path/umrouter_monitor.cfg</lbm-config>
      <publishing-interval>
        ...
      </publishing-interval>
      <remote-snapshot-request allow="1"/>
      <remote-config-changes-request allow="0"/>
    </daemon-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example daemon-monitor

Topic name to use for publishing Daemon Statistics.
%descr daemon-monitor.topic

tnwgd.monitor
%default daemon-monitor.topic

###

Configures whether the DRO will respond to monitoring apps requests
to change the rate at which Daemon Statistics messages are published.
See \ref daemonstatistics for general information on Daemon Statistics.
%descr remote-config-changes-request

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <daemon-monitor topic="umrouter.1">
      <lbm-config>/path/umrouter_monitor.cfg</lbm-config>
      <publishing-interval>
        ...
      </publishing-interval>
      <remote-snapshot-request allow="1"/>
      <remote-config-changes-request allow="0"/>
    </daemon-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example remote-config-changes-request

Enable or disable change requests.
%descr remote-config-changes-request.allow

Respond to change requests.
%descr remote-config-changes-request.allow.1

Ignore change requests.
%descr remote-config-changes-request.allow.0

0
%default remote-config-changes-request.allow

###

Configures whether the DRO will respond to monitoring apps requests
to send on-demand snapshots of daemon statistics.
See \ref daemonstatistics for general information on Daemon Statistics.
%descr remote-snapshot-request

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <daemon-monitor topic="umrouter.1">
      <lbm-config>/path/umrouter_monitor.cfg</lbm-config>
      <publishing-interval>
        ...
      </publishing-interval>
      <remote-snapshot-request allow="1"/>
      <remote-config-changes-request allow="0"/>
    </daemon-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example remote-snapshot-request

Enable or disable snapshot requests.
%descr remote-snapshot-request.allow

Ignore snapshot requests.
%descr remote-snapshot-request.allow.0

Respond to snapshot requests.
%descr remote-snapshot-request.allow.1

0
%default remote-snapshot-request.allow

###

Identifies the address for the web monitor, in the form of interface:port.
You can use "*" to specify the local host.

Omit this element to disable the web monitor.

See \ref webmonsecurity for important security information.
%descr web-monitor

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <web-monitor>*:21001</web-monitor>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example web-monitor

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr web-monitor.xml:space

Trim whitespace.
%descr web-monitor.xml:space.default

Retain whitespace exactly as entered.
%descr web-monitor.xml:space.preserve

\b default
%default web-monitor.xml:space

###

Container for UM Transport monitoring configuration elements.
%descr monitor

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <monitor interval="30">
      <transport-module module="lbm" options="config=/cfgs/TD1.cfg;topic=stats"/>
      <format-module options="config=/cfgs/TD1.cfg;separator=|"/>
    </monitor>  
  </daemon>
  ...
</tnw-gateway>
\endcode
%example monitor

Monitoring interval, in seconds.
0 disables monitoring.
%descr monitor.interval

0
%default monitor.interval

###

Provides specifics about the monitoring format module.
%descr format-module

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <monitor interval="30">
      <transport-module module="lbm" options="config=/cfgs/TD1.cfg;topic=stats"/>
      <format-module options="separator=|"/>
    </monitor>  
  </daemon>
  ...
</tnw-gateway>
\endcode
%example format-module

Selects the message formatting module.

See \ref monitoringformats.
%descr format-module.module

csv
%default format-module.module

Comma-separated values.
%descr format-module.module.csv

Google Protocol Buffers.
%descr format-module.module.pb

Option string to be passed to the formatting module.
Available option is \b "separator" (defaults to comma).
%descr format-module.options

(if omitted, no options are passed to the formatting module)
%default format-module.options

###

Specifies characteristics about the monitoring transport module used.
%descr transport-module

\b Example \b 1:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <monitor interval=30>
      <transport-module module="lbm" options="config=/cfgs/TD1.cfg;topic=stats"/>
      <format-module options="config=/cfgs/TD1.cfg;separator=|"/>
    </monitor>  
  </daemon>
  ...
</tnw-gateway>
\endcode

\b Example \b 2:

Monitoring configuration options can be supplied directly in the XML.
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <monitor interval=30>
      <transport-module module="lbm"
        options="config=/cfgs/TD1.cfg;context|request_tcp_interface=192.168.135.131"/>
      <format-module options="config=/cfgs/TD1.cfg;separator=|"/>
    </monitor>  
  </daemon>
  ...
</tnw-gateway>
\endcode
%example transport-module

Selects the message transport module.
%descr transport-module.module

Publish messages via standard UM source.
%descr transport-module.module.lbm

Publish messages via standard UM source with special settings
intended for the UM SNMP agent.
%descr transport-module.module.lbmsnmp

Publish messages as simple UDP datagrams.
%descr transport-module.module.udp

lbm
%default transport-module.module

Option string to be passed to the transport module.
Available options are \b "config" (configuration file pathname) and
\b "topic" (the topic name to use for sending and receiving statistics;
defaults to "/29west/statistics").
%descr transport-module.options

(if omitted, no options are passed to the transport module)
%default transport-module.options

###

Determines characteristics of the internal topic resolution maps
for wildcard patterns.
%descr patternmap

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <patternmap hash-function="murmur2" size="131111">
  </daemon>
  ...
</tnw-gateway>
\endcode
%example patternmap

Topic resolution hash function to use.
Informatica recommends the default.
See \ref resolverstringhashfunctioncontext for more information.
%descr patternmap.hash-function

UM's original hash function.
May be better for certain specialized topic names.
%descr patternmap.hash-function.classic

The Dan Bernstein algorithm from comp.lang.c.
May be better for topic names have a changing prefix with a constant suffix. 
%descr patternmap.hash-function.djb2

Sdbm database library (used in Berkeley DB).
May be better for certain specialized topic names.
%descr patternmap.hash-function.sdbm

Good all-around hash function by Austin Appleby.
%descr patternmap.hash-function.murmur2

murmur2
%default patternmap.hash-function

Number of buckets in hash table.
Should be a prime number.
%descr patternmap.size

131111
%default patternmap.size

###

Determines characteristics of the internal topic resolution maps
for topic names.
%descr topicmap

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <topicmap hash-function="murmur2" size="131111">
  </daemon>
  ...
</tnw-gateway>
\endcode
%example topicmap

Topic resolution hash function to use.
Informatica recommends the default.
See \ref resolverstringhashfunctioncontext for more information.
%descr topicmap.hash-function

UM's original hash function.
May be better for certain specialized topic names.
%descr topicmap.hash-function.classic

The Dan Bernstein algorithm from comp.lang.c.
May be better for topic names have a changing prefix with a constant suffix. 
%descr topicmap.hash-function.djb2

Sdbm database library (used in Berkeley DB).
May be better for certain specialized topic names.
%descr topicmap.hash-function.sdbm

Good all-around hash function by Austin Appleby.
%descr topicmap.hash-function.murmur2

murmur2
%default topicmap.hash-function

Number of buckets in hash table.
Should be a prime number.
%descr topicmap.size

131111
%default topicmap.size


###

Specifies the UM license file's pathname.
%descr lbm-license-file

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
      . . .
    <lbm-license-file>lic0014.txt</lbm-license-file>
      . . .
  </daemon>
      . . .
      . . .
</tnw-gateway>
\endcode
%example lbm-license-file

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr lbm-license-file.xml:space

Trim whitespace.
%descr lbm-license-file.xml:space.default

Retain whitespace exactly as entered.
%descr lbm-license-file.xml:space.preserve

\b default
%default lbm-license-file.xml:space

###

Contains the pathname for daemon process ID (PID) file.
%descr pidfile

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <pidfile>\var\run\dro01.pid</pidfile>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example pidfile

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr pidfile.xml:space

Trim whitespace.
%descr pidfile.xml:space.default

Retain whitespace exactly as entered.
%descr pidfile.xml:space.preserve

\b default
%default pidfile.xml:space

###

Specifies a Group ID (GID) for daemon process (if run as root).
%descr gid

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <gid>1234</gid>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example gid

###

Specifies a User ID (UID) for the daemon process (if run as root).
%descr uid

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <uid>5555</uid>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example uid

###

Specifies the destination for DRO log messages.
If you set the type for "file",
use this element to contain the full pathname.
%descr log

\b Example:
\code
<tnw-gateway version="1.0">
  <daemon>
    ...
    <log type="syslog"/>
  </daemon>
  ...
</tnw-gateway>
\endcode
%example log

Method of writing logs.
%descr log.type

Write log to disk file.
%descr log.type.file

Write log to Unix "syslog".
%descr log.type.syslog

Write log to standard out.
%descr log.type.console

console
%default log.type

Number of millions of bytes of file size to roll log file.
E.g. a value of 1 rolls after 1000000 bytes.
Maximum value is 4000.
Value of 0 disables rolling by file size.
Only applies for type="file".
%descr log.size

0
%default log.size

Frequency by which to roll log file.
Only applies for type="file".
%descr log.frequency

Roll log file at midnight.
%descr log.frequency.daily

Roll log file after approximately an hour,
but is not exact and can drift significantly over a period of time.
%descr log.frequency.hourly

Do not roll log file.
%descr log.frequency.disable

For Informatica internal use only.
Do not use.
%descr log.frequency.test

disable
%default log.frequency

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr log.xml:space

Trim whitespace.
%descr log.xml:space.default

Retain whitespace exactly as entered.
%descr log.xml:space.preserve

\b default
%default log.xml:space

__EOF__
]]])m4_dnl
m4_esyscmd([[[../share/xsd_doc.pl -d dro_config_descr.txt dro.xsd]]])m4_dnl

\m4_s1 umrouterconfigurationdtd DRO Configuration DTD

Here is the XML configuration DTD with the comments removed.
To see the DTD with comments included, enter `tnwgd --dump-dtd`.

\code
m4_include([[[dro.dtd]]])
\endcode

\m4_pg umrouterdaemonstatistics DRO Binary Daemon Statistics

\note The C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

See \ref exampleprotocolfiles for the protocol buffer definition files.

\m4_s1 umrouterdaemonstatisticsstructures DRO Daemon Statistics Structures

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

The different message types are:

<ul>
<li> \ref TNWG_DSTATTYPE_MALLINFO
<li> \ref TNWG_DSTATTYPE_GATEWAYCFG
<li> \ref TNWG_DSTATTYPE_PORTCFG
<li> \ref TNWG_DSTATTYPE_RM_LOCAL
<li> \ref TNWG_DSTATTYPE_RM_PORTAL
<li> \ref TNWG_DSTATTYPE_RM_OTHERGW
<li> \ref TNWG_DSTATTYPE_RM_OTHERGW_NBR
<li> \ref TNWG_DSTATTYPE_PORTSTAT
</ul>

Each one has a specific structure associated with it, as detailed in
the file tnwgdmonmsgs.h.

Note that message types ending with "CFG" are in the config category.
All others are in the stats category.
See \ref daemonstatisticsstructures for information on how the two 
categories are handled differently.

\m4_s2 umrouterdaemonstatisticsbyteswapping DRO Daemon Statistics Byte Swapping

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

A monitoring application receiving these messages must detect if there
is an endian mismatch (see \ref daemonstatisticsbinarydata).
The header structure \ref tnwg_dstat_msg_hdr_t contains a 16-bit field
named `magic` which is set equal to \ref LBM_TNWG_DAEMON_MAGIC.
The receiving application should compare it to \ref LBM_TNWG_DAEMON_MAGIC
and \ref LBM_TNWG_DAEMON_ANTIMAGIC.
Anything else would represent a serious problem.

If the receiving app sees:
\code
  magic == LBM_TNWG_DAEMON_MAGIC
\endcode
then it can simply access the binary fields directly.
However, if it sees:
\code
  magic == LBM_TNWG_DAEMON_ANTIMAGIC
\endcode
then <i>most</i> (but not all) binary fields need to be byte-swapped.
See \ref exampletnwgdmon_c for an example,
paying special attention to the macros `COND_SWAPxx` (which
<i>conditionally</i> swaps based on the magic test) and the functions
`byte_swapXX()` (which performs the byte swapping).

\m4_s2 umrouterdaemonstatisticsstructuresstringbuffers DRO Daemon Statistics String Buffers

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

DRO Daemon Statistics data structures sometimes contain string buffers.
Strings in these data structures are always null-terminated.
These messages are generally sent as fixed-length equal to the sizes of
the structures, and therefore include all of the declared bytes of
the string fields, even if the contained string uses fewer bytes than declared.
For example, the structure \ref tnwg_dstat_record_hdr_t contains the field
\ref tnwg_dstat_record_hdr_t_stct::portal_name which is a `char` array
of size `TNWG_DSTAT_MAX_PORTAL_NAME_LEN`.
If `portal_name` is set to "p1", then only 3 bytes of the buffer are used
(including the null string terminator).
However, all `TNWG_DSTAT_MAX_PORTAL_NAME_LEN` bytes will be sent in the
\ref TNWG_DSTATTYPE_RM_PORTAL message type.

Contrast this with \ref storedaemonstatisticsstructuresstringbuffers.

There are two exceptions to this rule: \ref TNWG_DSTATTYPE_PORTCFG and
\ref TNWG_DSTATTYPE_GATEWAYCFG.

The \ref TNWG_DSTATTYPE_PORTCFG message is of type
\ref tnwg_pcfg_stat_grp_msg_t and has the field
\ref tnwg_pcfg_stat_grp_msg_t_stct::data.
This field is a variable-length string buffer which contains
one or more null-terminated strings.
The total length of the \ref TNWG_DSTATTYPE_PORTCFG message is the sum
of the length of its sub-structures plus the number of bytes of string
data (characters plus string-terminating nulls).
The number of strings in \ref tnwg_pcfg_stat_grp_msg_t_stct::data is given by
tnwg_pcfg_stat_grp_msg_t_stct::rechdr->num_options.
The monitoring application must step through the string buffer that many
times to find each string.
For an example of how to do this, see \ref exampletnwgdmon_c
in the code following, "`case TNWG_DSTATTYPE_PORTCFG:`".

The \ref TNWG_DSTATTYPE_GATEWAYCFG message is of type
\ref tnwg_dstat_gatewaycfg_msg_t and has the field
\ref tnwg_dstat_gatewaycfg_msg_t_stct::data.
This field is a variable-length string buffer which contains exactly
one null-terminated string.
This string contains the entirety of the DRO's configuration file.
The individual lines contain the normal line-ending character(s).
The total length of the \ref TNWG_DSTATTYPE_GATEWAYCFG message is the
length of its sub-structure plus the number of bytes of string
data (characters plus string-terminating nulls).

\m4_s1 umrouterdaemonstatisticsconfiguration DRO Daemon Statistics Configuration

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

There are three places in the DRO configuration file that
Daemon Statistics are configured:
<ul>
<li>The \ref droelementdaemonmonitor "<daemon-monitor>" element inside the
\ref droelementdaemon "<daemon>" definition.
Configures all aspects of the DRO Daemon Statistics feature,
including publishing intervals.
<li>The \ref droelementpublishinginterval "<publishing-interval>"
element inside the \ref droelementpeer "<peer>" definition.
Configures only the publishing intervals on a peer portal basis.
<li>The \ref droelementpublishinginterval "<publishing-interval>" element
inside the \ref droelementendpoint "<endpoint>" definition.
Configures only the publishing intervals on an endpoint portal basis.
</ul>

Here is an example of configuring daemon statistics.

\code
<?xml version="1.0" encoding="UTF-8" ?>
<!-- G1 xml file- 2 endpoint portals -->
<tnw-gateway version="1.0">
  <daemon>
    ...
    <publishing-interval>
      <group name="default" ivl="3"/>
      <group name="gateway-config" ivl="120"/>
      <group name="portal-config" ivl="120"/>
    </publishing-interval>
    <remote-snapshot-request allow="1"/>
    <remote-config-changes-request allow="1"/>
  </daemon>
  <portals>
    <endpoint>
      <name>G1-TRD1</name>
      ...
      <publishing-interval>
        <group name="default" ivl="6"/>
        <group name="gateway-config" ivl="120"/>
        <group name="portal-config" ivl="120"/>
      </publishing-interval>
    </endpoint>
    ...
  </portals>
</tnw-gateway>
\endcode

In this example, all stats-type messages are (conditionally) published on a
3-second interval, except those of portal G1-TRD1, which are published
(conditionally) on a 6-second interval.
All config-type messages are published (unconditionally) on a 120-second interval.

\m4_s1 umrouterdaemoncontrolrequests DRO Daemon Control Requests

The DRO Daemon supports a monitoring application to send a specific
set of requests to control the operation of Daemon Statistics.
The \ref droelementremotesnapshotrequest "<remote-snapshot-request>"
and \ref droelementremoteconfigchangesrequest "<remote-config-changes-request>"
configuration elements control whether the DRO enables the
\ref daemoncontroller operation  (defaults to disabled).

\warning If misused,
the Daemon Control Requests feature allows a user to interfere with
the messaging infrastructure in potentially disruptive ways.
By default, this feature is disabled.
However, especially if you have enabled
\ref umeelementremoteconfigchangesrequest,
Informatica recommends \ref securingdaemoncontrolrequests.

If enabled, the monitoring application can send a command message to the
DRO in the form of a topicless unicast immediate "request" message
(see lbm_unicast_immediate_request() with NULL for topic).
The format of the message is a simple ascii string, with or without null
termination.
Due to the simple format of the message, no data structure is defined for it.

When the DRO receives and validates the command, it sends a UM response
message back to the requesting application containing a status message (which
is <i>not</i> null-terminated).
If the status was OK, the DRO also performs the requested action.

\m4_s2 umrouterdaemoncontrolrequestaddressing DRO Daemon Control Request Addressing

Since Daemon Control Requests are sent as UIM messages,
you must use a target string to address the request to the desired
DRO Process.
The general form of a UIM target address is described in \ref uimaddressing,
but is illustrated by this example:
\verbatim
TCP:10.29.3.46:12009
\endverbatim
where 10.29.3.46:12009 is the IP and Port of the Daemon Control context
UIM port.
These are typically configured using the \ref requesttcpinterfacecontext and
\ref requesttcpportcontext options in the UM configuration file
specified by the \ref droelementlbmconfig contained within the
\ref droelementdaemonmonitor.

\m4_s2 umrouterdaemoncontrolrequesttypes DRO Control Request Types

The example program \ref exampletnwgdcmd_c
demonstrates the correct way to send the messages and receive the responses.

<b>REQUEST TYPES ENABLED BY
\ref droelementremotesnapshotrequest "<remote-snapshot-request>":</b>

\par `version`
The DRO returns in its command response the value of 
\ref LBM_UMESTORE_DMON_VERSION.
No daemon statistics messages are published.

\par `snap mallinfo`
The DRO immediately publishes the memory allocation usage message of type
\ref TNWG_DSTATTYPE_MALLINFO.

\par `snap pstat`
The DRO immediately publishes the portal statistics message(s) of type
\ref TNWG_DSTATTYPE_PORTSTAT.

\par `snap ri`
The DRO immediately publishes the route information message(s) of types
\ref TNWG_DSTATTYPE_RM_LOCAL, \ref TNWG_DSTATTYPE_RM_PORTAL
\ref TNWG_DSTATTYPE_RM_OTHERGW, and \ref TNWG_DSTATTYPE_RM_OTHERGW_NBR.

\par `snap gcfg`
The DRO immediately publishes the gateway configuration message
\ref TNWG_DSTATTYPE_GATEWAYCFG.

\par `snap pcfg`
The DRO immediately publishes the portal configuration  message(s)
\ref TNWG_DSTATTYPE_PORTCFG.

<b>REQUEST TYPES ENABLED BY
\ref droelementremoteconfigchangesrequest "<remote-config-changes-request>":</b>

\par `mallinfo N`
Set the publishing interval for memory allocation usage.
<br>For example: `mallinfo 5`

\par `ri N`
Set the publishing interval for the route information messages.
<br>For example: `ri 5`

\par `gcfg N`
Set the publishing interval for the gateway configuration message.
<br>For example: `gcfg 5`

\par `pstat N`
Set the publishing interval for the portal statistics messages.
This command can be preceded by a portal name in double quote marks to
only set the publishing interval for that portal.
<br>For example: `"G1-TRD1" pstat 5`

\par `pcfg N`
Set the publishing interval for the portal configuration messages.
This command can be preceded by a portal name in double quote marks to
only set the publishing interval for that portal.
<br>For example: `"G1-TRD1" pcfg 5`

\m4_pg umrouterglossary DRO Glossary

\par \b Access \b Control \b List \b (ACL)
A portal configuration you can use to filter out messages based on
a variety of criteria.

\par \b forwarding \b cost
A value assigned to a portal to help determine best-path routing selection.

\par \b UM \b Router \b keepalive
Control messages exchanged between DROs to confirm that
DROs are still running.

\par \b Interest \b Message
Control messages exchanged between DROs to confirm that DROs
are still running.

\par \b Originating \b Transport \b ID \b (OTID)
Unique identifier of a message's transport session at the originating source.

\par \b portal
A TCP/IP interface (socket) on a DRO through which the DRO
passes data. Endpoint portals interface TRDs,
and peer portals interface peer portals of other DROs.

\par \b Topic \b Resolution \b Domain \b (TRD)
The realm of UDP multicast or unicast connectivity that allows
UM topic resolution to occur.
Blocking of this UDP connectivity (for example,
by a firewall or a restrictive WAN link) defines a TRD's boundaries.
Contexts within a TRD must have the same topic resolution configuration
option settings (multicast group IP address/port and
resolver interface full or CIDR address).

\par \b Use \b Query
A periodic control message distributed to all members of a TRD to verify the
continued presence of receivers for a given topic or pattern.

\par \b web \b monitor
A web-based real-time DRO statistics and configuration display.

\m4_pg comparisontopre60umgateway Comparison to Pre-6.0 UM Gateway

With the release of Ultra Messaging 6.0, the UM Gateway feature is
discontinued and replaced by the Ultra Messaging Dynamic Routing Option
(also referred to as the DRO).

The DRO's primary improvement over the UM Gateway is its ability to
intelligently select efficient traffic routes from multiple path choices on
a dynamic topic-by-topic basis.

\note This release of the DRO is not backward compatible with
earlier versions of the UM Gateway in the sense that you cannot have
DROs and UM Gateways in the same network.

\m4_s1 addedfeaturesanddifferences Added Features and Differences

In addition to routing functionality, the following are features of the DRO that were not provided in the UM Gateway:

<ul>
<li>Multi-path, ring, or mesh topologies
<li>Interoperability with MIM and Persistence (see UM Feature Compatibility
for complete feature interoperability information)
<li>Ability to restart the DRO within a transport's activity
timeout period
<li>Reduced topic resolution traffic via more efficient use of Use
Queries and Use Query Responses
<li>The default value for the portal `<cost>` is 1 (one). 0 (zero) is not
a valid cost value.
<li>The DRO daemon (tnwgd) logs version information on startup.
<li>Compression and/or encryption may be applied to TCP-only peer links.
</ul>

The following configuration options exist in the DRO but not the UM
Gateway. See \ref xmlconfigurationreference
for more information on these options.

<ul>
<li> `<name>` (as a `<daemon>` child)
<li> `<route-info>`
<li> `<route-recalculation>`
<li> `<source-deletion-delay>`
<li> `<max-queue>`
<li> `<remote-topic-interest>`
<li> `<remote-pattern-interest>`
<li> `<rate-limit>`
<li> `<domain-route>`
<li> `<remote-topic>`
<li> `<remote-pattern>`
<li> `<sourcemap>`
<li> `<compression>`
<li> `<tls>`
</ul>

\m4_eof
