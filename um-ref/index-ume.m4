m4_define(`m4_title', `Guide for Persistence') m4_dnl
m4_define(`m4_first_sect', `Introduction') m4_dnl
m4_define(`m4_pdf_name', `UM_Guide_for_Persistence=en.pdf') m4_dnl
m4_include(`initial.m4')

This document describes the Persistence functionality of the UMP and UMQ
products.

For policies and procedures related to Ultra Messaging Technical Support,
see <a href="https://ultramessaging.github.io/UM_Support.html">UM Support</a>.

m4_include([[[copyright.m4]]])

m4_include([[[legal.m4]]])

This document assumes familiarity with the
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../Design/index.html">UM Concepts Guide</a>.

See \ref umglossary for Ultra Messaging terminology, abbreviations, and
acronyms.

\m4_pg persistenceoverview Persistence Overview

Ultra Messaging provides two different qualities of service (QOS) levels,
related to likelihood of successful message delivery:
streaming and persistence.

<b>Streaming</b>

Streaming is the basic QOS level for UM.
With Streaming, a published message will be delivered to a receiver reliably
if the following requirements are met:

<ul>
<li>the publisher and subscriber are both running,
<li>the message was published <i>after</i> the subscriber has had enough time
to discover and join the publisher's data stream
(note that UM's \ref latejoin feature which somewhat relaxes this
requirement), and
<li>the data link between the publisher and subscriber has a low-enough
error rate that any lost data has time to be recovered by the Transport
protocol within the time allotted for that recovery.
</ul>

With Streaming, if a subscriber exits mid-stream (either intentionally or
by failure), when that subscriber restarts, it typically cannot recover
the messages that were sent during its absence.

<b>Persistence</b>

The higher QOS available for UM is Persistence, by which messages can be
delivered even in cases where one or more of the above requirements cannot
be met.
For example, if a publisher sends a message and then exits, and after that
a subscriber starts, Persistence is required for that message to be
delivered.

UM's Persistence functionality is implemented by components called "Stores"
obtaining copies of published messages and keeping them for a period of
time so that receivers can recover messages if necessary.

A "Store Process" contains one or more independent "Store instances",
where an "instance" is an independent, addressable, and configurable
component.
See \ref storeprocessesandinstances for more detail.

Store instances are used by persistent subscribers to recover messages that
cannot be recovered from the source by the transport protocol.
For example,
messages published prior to the subscriber joining the transport can be
recovered from a Store instance.
After a period of overload or network outage that leads to loss of live
messages,
the subscriber uses a Store instance to recover messages that could not be
recovered by the transport protocol.

With Persistence, if a subscriber exits mid-stream (either intentionally or
by failure), when that subscriber restarts, it will automatically recover
the messages sent during its absence.

A system using UM Persistence comprises any number of sources, receivers,
and Persistent Stores.
Ultra Messaging's unique design provides Parallel Persistence,
which refers to the ability of Store instances to run
independently of sources and receivers and in parallel with messaging.
The Store does not interfere with message delivery to
receiving applications.

This document is oriented mostly to programmers.
See also the Operations Guide chapters
\ref persistentstoreumestored, \ref persistentstorecrashed,
\ref persistentsendingproblems, and \ref umpersistentstorelogmessages.

\note The UMS product offers streaming QOS.
The UMP and UMQ products offer both streaming and persistence QOS.

\m4_pg persistenceconcepts Persistence Concepts

In discussing Persistence, we refer to specific recovery from the failures
of sources, receivers, and Persistent Stores.

<ul>
<li>Failed sources can restart and resume sending data from the point at which
they stopped.
<li>Receivers can recover from failure and begin receiving data from the point
immediately prior to failure.
This process is sometimes called durable subscription.
<li>Persistent Stores can also be restarted and continue providing persistence to
the sources and receivers that they serve.
</ul>

The user can choose between two different persistence modes:

<ul>
<li>Source-paced Persistence (SPP) - default mode - the rate of message
consumption by receivers does not constrain the rate a source can send.
The Store instance writes all messages to storage, and messages
are retained until they are overwritten when the allocated storage is filled.
See \ref persistencenormaloperation.
<li>Receiver-paced Persistence (RPP) - optional mode - the rate of message
consumption by receivers <i>does</i> constrain the rate a source can send.
The Store instance only writes message to non-volatile storage if one or more
required RPP receivers is absent or slow in consuming the messages. Messages are
deleted from the Store instance once all receivers have consumed the
RPP message.
See \ref receiverpacedpersistenceoperations.
</ul>

\m4_s1 persistentstoreconcept Persistent Store Concept

UM uses a daemon program known as the Store to persist source (publisher) and
receiver (subscriber) state.
A Store instance can persist state in memory as well as on disk.
State is persisted on a per-topic, per-source basis by the Store.
Along with each publisher's state is a message cache containing the full
message contents of recently-sent messages by the source.

The purpose of the Store is to allow receivers to recover messages that
the receiver was not able to get directly from the source.

The Store is an independent component, not part of the source.
If a persistent publisher fails,
that source's messages are maintained by the Store according to
configurable retention policies.

Note that the design of UM's persistence allows a maximum of
2,147,483,647 messages (2**31 - 1) to be persisted.

Stores can be \ref umecfgrepositorytype "configured" to be disk-based or memory-only.
A disk-based Store uses memory as temporary storage while messages
are written to disk.
Memory-only Stores only hold messages in memory.
The memory-only Stores have higher throughput,
while disk-based Stores have greater message capacity.

Note that most UM deployments only use disk-based Stores.
Most of this document is written with that assumption.

\m4_s1 persistenceconfigurationconcept Persistence Configuration Concept

It is important to remember the different kinds of configuration.
<ul>
<li>Applications create UM objects (contexts, sources, receivers)
using the UM library.
Those objects must be configured to control their operation and behavior
using <b>"LBM configuration options"</b>.
An application typically uses an <b>"LBM configuration file"</b> in either
XML or flat format.
For full details on LBM configuration options, see
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../Config/index.html">UM Configuration Guide</a>
<li>A Store Process is configured using a <b>"Store configuration file"</b>
in XML format.
For full details on Store configuration files,
see \ref configurationreferenceforumestored.
<li>A Store Process also internally creates UM objects (contexts, sources,
receivers) using the UM library.
The Store's objects must also be configured using one or
more LBM configuration files.
</ul>

So Stores need two kinds of configuration files: Store configuration files
and LBM configuration files.
Applications only need LBM configuration files.

\m4_s1 registrationidentifierconcept Registration Identifier Concept

UM persistence identifies sources and receivers with Registration Identifiers,
also called Registration IDs or RegIDs.
A RegID is a 32-bit number that uniquely identifies a source or a receiver to
a Store instance.
This means that RegIDs are also specific to a Store instance and can be reused
between individual Store instances, if needed.
No two active sources or receivers can share a RegID or use the same RegID at
the same time.
This point is critical: since UM enables your application to use and handle
RegIDs very freely, you must use RegIDs carefully to avoid destructive results.

While RegIDs can be managed directly by applications,
Informatica recommends the use of Session IDs instead.
See \ref managingregidswithsessionids.

\m4_s1 deliveryconfirmationconcept Delivery Confirmation Concept

A persistent receiver provides confirmation (acknowledgement) to the
Store instance as it consumes (processes) messages.
This is fundamental to the design of UM persistence.

The receiver can optionally provide this confirmation (acknowledgment) to the
persistent source.
These confirmations are turned off by default, but can be requested through
either or both two LBM configuration options:
<ul>
<li>\ref umeconfirmeddeliverynotificationsource - deliver a source event
to the application indicating message consumption.
<li>\ref umeretentionuniqueconfirmationssource - include receiver consumption
as part of source flight size calculation.
</ul>
These two options are unrelated to each other, except that they both
request the receiver to send delivery confirmations.
Note that when either or both of the options are set, the persistent
source <i>requests</i> that the persistent receiver supply delivery
confirmations.
The persistent receiver has the option to decline the request by setting
the option \ref umeallowconfirmeddeliveryreceiver to 0.

\note \ref smartsources do not support either form of delivery confirmation.

The latter LBM option, \ref umeretentionuniqueconfirmationssource,
can provide a form of receiver-pacing; the source will not be allowed
to exceed \ref persistenceflightsize beyond receiving applications.
For more information, see: \ref confirmeddelivery

\m4_s1 releasepolicy Retention Policy

Sources and Persistent Stores retain messages in memory according to a
set of rules collectively called the retention policy.
The rules specify when UM will remove a message from memory,
an action called "reclaiming"
(because the memory is reclaimed from the buffer).
Note that reclaiming a message from memory does not mean the message
can no longer be recovered.
The opposite is true - a message is reclaimed from memory only after
it is stable on the Stores.

A message must satisfy every rule before it can be reclaimed.
Conversely, any message not complying with all rules will not be reclaimed.
A source or Store instance retains messages in memory until its retention policy
dictates the message may be removed.
Sources and Stores use slightly different retention policies based on their
individual roles.

For more information, see \ref sourcemessageretentionandrelease.

\m4_s1 messagestabilityconcept Message Stability Concept

Sources send messages to both receivers and to Store instances.
Messages become stable once the message has been persisted at the Store or
a set of Stores, and those Stores acknowledge stability to the sources.
Since it takes time to write messages to disk and signal stability,
the source is allowed to continue sending messages while waiting for
stability acknowledgements.
Any messages sent but not yet acknowledged are said to be <i>"in flight"</i>.
The number of in-flight messages is normally limited.
For more information, see \ref persistenceflightsize.

In addition, UM informs the application when messages are stabilized.
Until that stability acknowledgement is received, the source can not
assume the messages will be successfully delivered.
The message stability acknowledgement is vital to ensuring that
messages will not be lost.
For more information, see \ref sourcemessageretentionandrelease.

\m4_s1 quorumconsensusstorefailover Quorum/Consensus Store Failover

Typically, multiple Store instances are deployed as a
group for redundant operation.
In this configuration, one or more Stores (or the hosts they run on) can fail
without impacting the message flow from sources to receivers, as long as a
<i>quorum</i> of the configured Stores is operational.
UM defines a quorum as a majority of the configured Stores.
E.g. if 3 Store instances are configured,
messaging can continue as long as at least 2 are operational.
If 5 Store instances are configured, messaging can continue if at least 3 are
operational.
(Quorum/Consensus requires an odd number of Store instances in the QC group.)

Sources define the QC group by the LBM configuration option \ref umestoresource,
one for each Store in the group.

\m4_pg persistencearchitecture Persistence Architecture

As shown in the diagram, UM provides messaging functionality as well as
persistent operation.

\image html persistent_architecture.png
\image latex persistent_architecture.png

The highlights of this architecture are:

<ul>
<li>Sources communicate with Store instances
<li>Receivers communicate with Store instances
<li>Sources communicate with receivers
</ul>

Note that the Store is not supported on all platforms.
For example, while Solaris supports persistent clients (source and
receiver), you cannot run a Store on an Solaris system.
However, an Solaris-based client can interoperate with a Store
running an any other supported platform.

\m4_s1 persistentstorearchitecture Persistent Store Architecture

The `umestored` program (the final "d" stands for "daemon") runs the Store Process.
You can configure multiple Store instances per Store Process using the
\ref umeelementstore
in the Store configuration file.
See \ref configurationreferenceforumestored.
Individual Store instances can use separate disk cache and disk state
directories and be configured to persist messages for multiple sources (topics),
which are referred to as "source repositories".
Each Store Process has an optional Web Monitor for statistics monitoring.
See \ref storewebmonitor.

\image html store_architecture.png
\image latex store_architecture.png

\m4_s2 storeprocessesandinstances Store Processes and Instances

When the Store Process is started on a host,
the process is known as the "Store Process".
That Store Process contains one or more "Store instances".
A Store instance is an independent, addressable, and configurable
component.
Each Store instance is implemented with a set of interacting program threads.
The threads of one Instance do not interact or contend with the threads
of other Instances in the same Process.

There is very little difference between running one Store Process with
two Store instances compared to two Store Processes with one Store instance
each.
They function and perform mostly the same.
The reasons for choosing one over the other have mostly to do with
operational convenience.
For example, running fewer processes on a host is sometimes easier to manage.
So operational simplicity suggests combining multiple Store instances into
a single Store Process.

On the other hand, there are times when it is desired to shut down
a Store instance.
But Store instances cannot be shut down individually;
an entire Store Process must be shut down.
For example: as message rates increase,
you may find that the host's CPU consumption is getting too high.
You might want to migrate half of the Store instances to a different host.
But if all your Store instances are in one Store Process,
it is more disruptive perform the migration since it requires shutting
down the entire process and re-configuring.
So operational flexibility suggests assigning each desired Store instance
to its own Store Process.

One specific case where a single Store Process with multiple Store
Instances is generally preferred:
using the Store Process as a Windows Service.
There is no simple way to run multiple copies of the Store Windows Service.

\m4_s2 sourcerepositories Source Repositories

Within a Store instance,
you configure repositories for individual topics,
and each can have its own set of \ref umeelementtopic "<topic>" options
that affect the repository's type, size, liveness behavior, among other options.
If you have multiple sources sending on the same topic,
the Store instance creates a separate repository for each source.
UM uses the repository options configured for the topic to apply to each
source's repository.

For example, if you specify 48 MB for the size of the repository and have 10 sources sending
on the topic, the Store instance requires 480 MB of storage for that topic.

A repository can be configured as one of the following types:

<ul>
<li>memory - the repository maintain both state and data only in memory, not disk.
<li>disk - the repository maintains state and data on disk,
but also uses a memory cache.
</ul>

There is also a repository type called "no-cache",
which is deprecated and will be removed in a future UM version.
The "no-cache" repository maintains state (last sequence numbers published
and consumed) but does not maintain message content.
It is deprecated due to lack of compelling use cases.

Note that the Store instances within a Store Process can have different
repository types.

\m4_s2 repositorythresholdsandlimits Repository Thresholds and Limits

The Store is designed to retain messages in case they are needed for
future recovery.
Of course, it is not possible to extend this retention to infinity,
so the Store must be configured with policies regarding the
removal of messages.
There are three possible policies that can be established:

<ol>
<li>Repository size limit (required)
<li>Message age limit (optional, for source-paced persistence).
<li>Consumption by all required receivers (for receiver-paced persistence).
</ol>

In all cases,
the repository's size is limited to prevent exhaustion of storage.
With source-paced persistence, when the repository size limit is reached,
the oldest messages are overwritten by new messages.
With receiver-paced persistence, when the repository size limit is reached,
the source is prevented from sending more messages.

For receiver-paced persistence, when all required receivers acknowledge
consumption of a message, it is removed from the Store.
But note that if the required receivers to not acknowledge consumption
of messages and the repository fills before the oldest messages are
acknowledged,
the repository size is enforced and the source is blocked from sending
more messages.

\note When you configure a size limit, it applies to a single persisted
source.
For example, if you have two publishing applications and each one sends
to the topic "EventStream",
two separate repositories will be created, one for each source,
and each repository will be allowed to grow to the configured size
limit.
You must provision your repository sizes with knowledge of
how many persisted sources will be serviced by a given Store.

The size configuration options differ depending on whether you are
implementing a Memory Repository Store
(\ref umecfgrepositorytype "repository-type" <b>"memory"</b>) or
a Disk Repository Store
(\ref umecfgrepositorytype "repository-type" <b>"disk"</b>).

<b>Memory Repository Size</b>

A memory type source repository has three configuration options that manage
its size relative to its capacity.

Note that the design of UM's persistence allows a maximum of
2,147,483,647 messages (2**31 - 1) to be persisted.

<ul>
<li>\ref umecfgrepositoryagethreshold "repository-age-threshold" -
This value determines how long the memory repository retains messages.
Messages in memory that exceed this time can be deleted from the memory
cache.

<li>\ref umecfgrepositorysizethreshold "repository-size-threshold" -
The size in bytes that a repository
can reach before it begins to delete the oldest retained messages.
If the repository size falls below the threshold, it stops deleting old
messages.

<li>\ref umecfgrepositorysizelimit "repository-size-limit" -
The maximum size in bytes for the repository.
Once this limit is reached, the repository stops accepting new messages.
The age and size thresholds should be set at levels that guarantee the size
limit is never met. You should consider how fast the source sends messages,
the size of the messages and the reliability of the receivers.
For example, more reliable receivers mean less recovery instances,
which could mean a younger age threshold.
Do not specify a limit that would allow more than 2,147,483,647 messages
to be stored.
</ul>

<b>Disk Repository Size</b>

A disk type source repository maintains a memory cache in
addition to the actual disk storage. It continually persists messages from the
memory cache to the disk, and uses the memory cache for receiver recovery
first before performing disk reads to access needed messages.

Note that the design of UM's persistence allows a maximum of
2,147,483,647 messages (2**31 - 1) to be persisted.

The Store has four configuration options that manage its size relative to its capacity.

<ul>
<li>\ref umecfgrepositorysizethreshold "repository-size-threshold" -
The size in bytes that a repository
can reach before it begins to delete the oldest retained messages.
These messages could have been persisted to disk and may be available for
recovery.
If the disk repository memory cache size falls below the threshold,
it stops deleting old messages.

<li>\ref umecfgrepositorysizelimit "repository-size-limit" -
The maximum size in bytes for the disk repository's memory cache.
Once this limit is reached, the repository stops accepting new messages.
The age and size thresholds should be set at levels that guarantee the size
limit is never met.
You should consider how fast the source sends messages,
the size of the messages and the reliability of the receivers.
For example, more reliable receivers mean less recovery instances,
which could mean a younger age threshold.
Do not specify a limit that would allow more than 2,147,483,647 messages
to be stored.

<li>\ref umecfgrepositorydiskfilesizelimit "repository-disk-file-size-limit" -
The maximum disk space (in bytes) for the disk repository.
Once this limit is reached, the repository overwrites old messages with new
messages.
Overwriting old messages is not necessarily a negative situation provided you
disk file size is adequate.
However, if messages needed for recovery are not in either the memory cache
or the disk file, you may need to increase the disk file size to ensure that
overwritten messages are no longer needed for receiver recovery.
Do not specify a limit that would allow more than 2,147,483,647 messages
to be stored.
</ul>

\m4_s2 persistentstorefault Persistent Store Fault Tolerance

Sources and receivers register with a Store instance and use individual
repositories within the Store.
Sources can use redundant repositories configured in multiple
Stores Instances in Quorum/Consensus (QC) arrangement for fault tolerance.
Be aware that the arrangement of Store instances  into Quorum/Consensus
groups is a function of the source.
I.e. the individual Stores of a QC group are not aware of each
other and do not coordinate their activities.

Informatica strongly recommends that the Store instances of a QC group
run on separate physical hosts.

\m4_s2 identifyingpersistentstores Identifying Persistent Stores

A persistent source must be configured to identify one or more Stores
to provide persistence services.
The source configuration can identify Store instances with one of:
<ul>
<li>IP:port or domainID:IP:port using \ref umestoresource,
see \ref ipstore "Store Address"
<li>Store's context name using \ref umestorenamesource,
see \ref namedstores "Named Stores").
</ul>

In either case, the store should be told which interface to bind to,
which defines its IP address.
This is done with the \ref umeelementstore in the Store's configuration file.
There is a shortcut available to simplify the Store configuration file;
see \ref cidrstore "Using a CIDR Range of IP Addresses".

\anchor ipstore
<b>Store Address: Identify Store with IP:Port</b>

Using IP:port is feasible in deployments where there is no
DRO; i.e. all components are in a single \ref topicresolutiondomain (TRD).
Deployments that include DRO and have multiple TRDs require that the domain
ID be added to the address: domainID:IP:port.

Configure Store instance for a single IP:port.

<ol>
<li>Identify the Store with only the IP:port,
specified with the \ref umeelementstore in the Store's configuration file.
For example:
\code
<store name="newyork-1" port="14567" interface="10.29.3.16">
\endcode

<li>Configure the source with the IP:port using the LBM configuration option
\ref umestoresource so sources can find and
register with the Store instance.
\verbatim
source ume_store 10.29.3.16:14567
\endverbatim
</ol>

\anchor namedstores
<b>Named Stores: Identify Store with Context Name</b>

A Store is configured with a context name.
Sources are then configured to specify the Stores
by their names, instead of their IP:Port.

<ol>
<li>Give the Store's context a name using the
\ref umecfgcontextname "context-name" option
in the Store configuration file.
For example:
\code
<store name="newyork-1" port="14567" interface="10.29.3.0/24">
<ume-attributes>
   <option type="store" name="context-name" value="NEWYORK-1"/>
</ume-attributes>
\endcode

<li>Configure the source with the name of the Store's context using the
LBM configuration option \ref umestorenamesource so sources can
find and register with the Store.

\verbatim
source ume_store_name NEWYORK-1
\endverbatim

Note that you did not have to determine the full IP address of the
store's host.
</ol>

Store context names can be used with or without DROs.
UM automatically resolves and maintains a mapping between a Store's context name and its
domain ID, IP address and port, as follows:
<ul>
<li>Store advertises its context name at startup and in response to queries
from sources.
<li>If a Store receives a context name advertisement that matches its own
context name, that Store issues a warning in the Store's log.
This represents an invalid configuration and can produce unpredictable
results.
Always ensure that Store context names are unique within a UM deployment.
<li>Sources using Store context names issue an information message to the application
every time a resolved context name changes its DomainID:IPaddress:port.
</ul>

\anchor cidrstore
<b>Shortcut: Using a CIDR Range of IP Addresses</b>

Configure a Store with a CIDR range of IP addresses
(see \ref specifyinginterfaces).
This allows multiple Store daemon instances which only differ
by their IP address to be configured the same.
At initialization time, each Store daemon instance will
determine its IP address using the CIDR specification.
However, be aware that sources will need to use
the full IP address.

<ol>
<li>Identify the Store with a range of IP addresses specified in the Store
configuration file.
For example:
\code
<store name="newyork-1" port="14567" interface="10.29.3.0/24">`
\endcode
When the Store Process initializes,
UM will choose a network interface within that IP address range (10.29.3.0 -
10.29.3.255).

<li>Configure the source with the IP:port using the LBM configuration option
\ref umestoresource so sources can find
and register with the Store.
<b>You must specify the full IP address, not the CIDR range.</b>
\verbatim
source ume_store 10.29.3.16:14567
\endverbatim

<li>Alternatively, you can use the
\ref namedstores "Named Stores" feature
so that the source doesn't need to specify the full IP.
</ol>

\m4_pg operationalview Operational View

Sources, receivers, and Store instances interact in very controlled ways.
This section illustrates the flow of network traffic between the components
during three modes of operation and also provides a reference of persistence
events.

This document is oriented mostly to programmers.
See also the Operations Guide chapters
\ref persistentstoreumestored, \ref persistentstorecrashed,
\ref persistentsendingproblems, and \ref umpersistentstorelogmessages.

\note If your application is running with the LBM configuration option
\ref requesttcpbindrequestportcontext set to zero,
UIM port binding (also known as "request port binding") is turned off,
which also disables persistence.

\m4_s1 generalpersistenceoperation General Persistence Operation

\m4_s2 sourceregistration Source Registration

UM sources heavily influence the persistence registration process.
Sources send out registration information to enable receivers to register
with Store instances and also monitor Store liveness.
If Stores become unresponsive, or if communication among sources,
Stores and receivers becomes impaired, the source directs re-registration.

The following outlines the major events in the source registration process
with the Store instance:

<ol>
<li>Source advertises topic over topic resolution transport
<li>(optional) Source queries for and resolves Store context names
<li>Source registers with Store by unicast
<li>Source sends SRI over configured transport
</ol>

The following diagram illustrates network flow during the registration process.

\image html source_registration.png
\image latex source_registration.png

Sources can find the correct Store instance(s) to register with from the values
configured for it in the LBM configuration options
\ref umestoresource or \ref umestorenamesource.
The LBM configuration option \ref umestoresource contains the IP address, TCP port,
registration ID, and group index for the Store(s) to be used by the source.
The LBM configuration option \ref umestorenamesource contains the names of
the Stores to be used by the source.
\ref umestorenamesource requires that the Store context name is configured with the
\ref umecfgcontextname "context-name" option in the Store configuration
file.
See \ref identifyingpersistentstores and the \ref umeelementstore.

Sources unicast registrations to the Store instance.
The Store unicasts responses back to the source.
Registrations are on a per topic per source basis.
Stores use RegIDs to identify sources and receivers.
After registration sources may send data.

After the source successfully registers with all required Stores,
the source delivers a Registration Complete event to the publisher
and sends an \ref sourceregistrationinformationsri "SRI" over the source's
\ref transportsessions "transport session".
For multiple Stores in the QC group,
the source determines the required number of Stores based on the
LBM configuration option \ref umeretentionintragroupstabilitybehaviorsource.

The source sends the SRI at the rate set by the LBM configuration option
\ref umesriintersriintervalsource until it reaches the maximum number of SRIs
set by \ref umesrimaxnumberofsriperupdatesource.
The Stores must receive this SRI.

\note Persistence users are advised to follow the recommendations in
\ref preventingstoreregistrationhangs.

\m4_s2 sourceregistrationinformationsri Source Registration Information (SRI)

An SRI is a control message sent over the UM transport by a source that
contains Store information that a receiver needs to register with the
Store instance(s).

An SRI contains the following Store information.
<ul>
<li>Domain ID
<li>IP address
<li>TCP port
<li>Store index for all the Stores with which the source registered
<li>group index for all the Stores with which the source registered
<li>the source's Registration ID
<li>SRI overall version number and a separate version number for each Store
</ul>

The SRI contains one overall version number and a separate version number for
each Store instance.
If Stores become unresponsive and the source must re-register when the Store
returns, the source increases the SRI version number and the version numbers
for the Stores it re-registered with.
The highest SRI version number indicates the most current registration
information.
If a receiver gets an SRI with a higher version number than the version
number it has, the receiver examines the individual Store version numbers and
re-registers with the those Stores that have higher individual version numbers.

\m4_s1 receiverregistration Receiver Registration

Receivers register with Store instance(s) after receiving a SRI packet from
the source sending on the receiver's topic.

Receiver must receive an SRI before they can register with the Store instance(s).
The following lists the major events in the receiver registration process.

<ol>
<li>Receiver resolves topic over topic resolution transport.
<li>If source is not sending SRIs, receiver sends SRI request by unicast.
<li>Receiver receives SRI over its transport.
<li>Receiver registers with Store(s) by unicast.
</ol>

The following diagram illustrates network flow during the registration process.

\image html receiver_registration.png
\image latex receiver_registration.png

\m4_s2 receiverregistrationprocess Receiver Registration Process

Any receivers who have resolved their topic and joined the transport session
when the source sends out SRIs can register with the Store instance.
Any receivers joining the transport session when the source is not sending
SRIs can request an SRI from the source if they find that the persistence
flag is set in the source's TIR during topic resolution.
The source responds with a SRI record.

Receivers unicast registrations to the Store instance.
The Store unicasts responses back to the receivers.
Stores use RegIDs to identify sources and receivers.
After registration, receivers may handle recovery and send acknowledgements.

Note: If a persistent receiver's initial registration fails,
it does not become an Ultra Messaging receiver.

\m4_s2 persistencenormaloperation Persistence Normal Operation

The following diagram illustrates the normal operation of data reception and
acknowledgement and also shows how UM attains Parallel Persistence.
The source sends message data to receivers and Stores in parallel.

\image html ump_normal_operation.png
\image latex ump_normal_operation.png

During normal persistence operation:

<ol>
<li>Sources transmit data to receivers and Stores at the same time over UM
multicast or unicast transport protocols.
<li>As the Store instance receives and persists messages, it unicasts
acknowledgements (message stability control messages) to the source letting
it know of successful reception and storage.
<li>As receivers process and consume messages they unicast acknowledgments to
the Store letting the Store know of successful consumption of data.
<li>If the source desires delivery confirmation, the receiver unicasts
acknowledgements directly to the source letting the source know of message
consumption as well.
</ol>

Normal operation and recovery can proceed at the same time.
In addition, as a receiver consumes retransmitted messages, the receiver sends
normal acknowledgements for consumption and confirmed delivery (if requested
by the source).

\m4_s2 persistenceflightsize Persistence Flight Size

UM supports a flight size mechanism that tracks messages in flight from a
persistent source and responds when a send would exceed the configured flight
size (LBM configuration options \ref umeflightsizesource and/or \ref umeflightsizebytessource).
You can configure \ref umeflightsizebehaviorsource to either:

<ul>
<li>block any sends that would exceed the flight size or,
<li>allow the sends while notifying your application.
</ul>

UM considers a sent message in flight until the following two conditions are
met:

<ul>
<li>The source receives the configured number of stability acknowledgements
from the Store instance(s).
<li>The source has received the configured number of delivery confirmation
notifications. (See \ref umeretentionuniqueconfirmationssource.)
</ul>

If configuring both \ref umeflightsizesource and
\ref umeflightsizebehaviorsource, UM uses the smaller of the two flight
sizes on a per send basis.

<table>
<tr><th>\ref umeflightsizesource <th>\ref umeflightsizebytessource <th>Result
<tr><td>Exceeded <td>Exceeded <td>\ref umeflightsizebehaviorsource executes
<tr><td>Exceeded <td>Not Exceeded <td>\ref umeflightsizebehaviorsource executes
<tr><td>Not Exceeded <td>Exceeded <td>\ref umeflightsizebehaviorsource executes
<tr><td>Not Exceeded <td>Not Exceeded <td>No flight size sending restriction
</table>

When using Stores in a Quorum/Consensus configuration, intragroup and
intergroup stability settings affect whether UM considers a messages in flight.
Consider a case with three Store instances in a single QC group,
and two receivers.
Given the default configuration, until a source receives a stability
notification from two of the three Stores, UM considers a given message
in-flight.
In addition, if you set \ref umeretentionuniqueconfirmationssource to 2,
that same message would be considered in flight until the source receives
two stability notifications AND two delivery confirmation notifications.
See also \ref sourcesusingquorumconsensusstoreconfiguration.

<b>Blocking Message Sends That Exceed the Flight Size</b>

By default, when a source sends a message that exceeds it's flight size,
the call to send blocks.
For example, suppose the flight size is set to 1.
The first send completes but before the source receives a stability
notification or delivery confirmation, it initiates a second call to send.
If the source uses a blocking send, the send call blocks until the first
message stabilizes.
If the source uses a non-blocking send, the send returns an LBM_EWOULDBLOCK.

<b>Notification of Message Sends That Exceed the Flight Size</b>

Alternatively, \ref umeflightsizebehaviorsource can be set to notify
your application when a message send surpasses the flight size.
A send that exceeds the configured flight size succeeds and also triggers a
flight size notification, indicating that the flight size has been surpassed.
Once the number of in-flight messages falls below the configured flight size,
another flight size notification source event is triggered, this time,
informing the application that the number of in-flight messages is below the
source's flight size.

\m4_s2 receiverrecovery Receiver Recovery

Normal loss retransmission over the UM transport operates identically in
persistence as it does in streaming, according to the transport protocol.
Stores do not participate in this transport-level loss retransmissions.

Persistent Stores become involved in message recovery in circumstances
where the transport protocol is not able to recover.
For example, if an application exits (either intentionally or by failure)
and then restarts some time later, the transport is not able to recover
messages that were sent during the application's down time.
When the receiver restarts and re-registers, the receiver discovers the lowest
message sequence number it did not receive, and subsequently requests
retransmissions of all messages not received, starting from this low
sequence number.

For more on this process see, \ref persistentreceiverrecovery.

Another circumstance in which the Store becomes involved in message recovery
is if the transport protocol tries but is unable to recover lost messages.
In this case, Off Transport Recovery (OTR) is used.
Note that OTR is available in streaming, and is serviced by the source's
retention buffer.
But for persistent sources, the Store services OTR.
See \ref offtransportrecoveryotr for more information.

For more reliable persistence operation, Informatica recommends enabling OTR,
especially when using \ref umrouter "DROs".

The following diagram illustrates receiver recovery:

\image html receiver_recovery.png
\image latex receiver_recovery.png

Receivers unicast retransmission requests.
If the Store has the message, it unicasts the retransmission to the receiver.
If it does not have the message and is configured to forward the request to
the source, it unicasts the retransmission request to the source.
If the source has the message, it unicasts the retransmission directly to the
receiver.
See also \ref messagelossrecovery.

Store sends retransmissions from a thread separate from the main context
thread so as not to impede live message data processing.
The '`<store>`' configuration option,
\ref umecfgretransmissionrequestprocessingrate "retransmission-request-processing-rate",
sets the Store's capacity to process retransmission requests.
The retransmission thread processes requests off a retransmission queue which
is set at 4 times the size of
\ref umecfgretransmissionrequestprocessingrate "retransmission-request-processing-rate".
The following UM Web Monitor statistics indicate retransmission activity
(see \ref storewebmonitor):

<ul>
<li>Retransmission requests received rate
<li>Retransmission requests served rate
<li>Retransmission requests dropped rate
<li>Total retransmission requests dropped since Store startup
</ul>

\m4_s2 registrationlimitations Registration Limitations

An important use case for UM Persistence is the idea that an application
registers, either with a RegID or a SessionID, and can then exit (gracefully
or not) and subsequently it can re-register with the same RegID or SessionID
and pick up where it left off.

This re-registration has some limitations regarding operational
parameters changing between the registration and the re-registration.
In general, an application re-registering a source or receiver should
use the same operational parameters that it used when it originally
registered.

In particular, except as noted below, the re-registering application
should use the same values for any "ume_..." configuration options
supplied.

There are some exceptions to this rule:
<ul>
<li>It is permissible for an application bind to a different IP address
and/or Port.
This is important because a failure might render the original host unusable,
so the application must be allowed to migrate to a different host.
<li>It is permissible for the application to use a different transport
type (TCP, LBT-RM, LBT-RM, IPC, etc).
This is important because a migration to a different host might impose
different networking restrictions (e.g. no multicast).
<li>The values for \ref umestoresource can change (IP/Port/TRD).
This is important because a Store might fail and need to be migrated to
a different host.
</ul>

\m4_s1 receiverpacedpersistenceoperations RPP: Receiver-Paced Persistence

The Receiver-paced Persistence (RPP) mode of operation is primarily intended to
prevent message loss to critical receivers, even if loss prevention requires
blocking sources from sending.
To achieve this, message retention in the Store is different from Source-paced
persistence:

<ul>
<li>In Source-paced Persistence (SPP), messages are retained in the Store
until the space is needed for new messages.
I.e. the message repository is a circular buffer which will overwrite when it
"wraps".
If a slow or stopped receiver falls behind the source by more than the size
of the Store's repository, that receiver will experience unrecoverable loss.

<li>In Receiver-paced Persistence (RPP), messages are retained only for as
long as registered receivers need them to be retained in order to ensure
recoverability of unacknowledged messages.
When all necessary receivers have acknowledged a message, that message is
removed from the Store's repository.
If critical receivers are unable to acknowledge messages and the repository
has reached its configured capacity, the source is blocked from sending
additional messages.
Blocking the source prevents sending of messages that would otherwise
overwrite unacknowledged messages.
</ul>

Source pacing is typically chosen for applications where outgoing messages
are generated by external events or processes that cannot be slowed down or
stopped (e.g. market data).
Receiver pacing is typically chosen for applications which are able to slow
down or even halt the generation of messages (e.g. a user interface which can
inhibit user entry).

RPP is enabled with LBM configuration options.
No special API calls are needed.

RPP differentiates between two types of receivers:

<ul>
<li>Blocking: A blocking receiver will block the source if additional messages
would overwrite retained messages not yet acknowledged by that receiver.
<li>Non-blocking: A non-blocking receiver will not block the source; the
source will be allowed to overwrite retained messages not yet acknowledged by
the non-blocking receiver.
Thus a non-blocking receiver will experience unrecoverable message loss if it
falls behind the source by more than the configured size of the Store's
repository.
(Note that this is the same behavior of source-paced persistence.)
</ul>

Each receiver indicates its desired blocking behavior with the
\ref umereceiverpacedpersistencereceiver configuration option.
Both blocking and non-blocking receivers may register with the same Store and
subscribe to the same source.

Here are important points when using RPP:

<ul>
<li>The repository must be configured to allow RPP, and sources and receivers
must be configured to request RPP behavior during registration.
Assuming the Store is configured to allow RPP, the source determines the
pacing behavior (receiver v.s. source) when it registers.
If a receiver requests a different behavior, its registration will fail.

<li>The Store tracks the number of registered blocking and non-blocking
receivers for each message sent by the source.
A message is normally retained in the Store repository until that number of
receivers have acknowledged consumption.
Once all receivers acknowledge consumption of a message,
that message is removed from the repository.

<li>Sources can modify specific repository configuration options that pertain
to RPP.

<li>Due to RPP's message retention policies, late joining RPP receivers
cannot recover previously sent messages.

<li>With RPP, sources are required to configure their flight size in bytes,
in addition to message count.
(With SPP, only message count flight size is required.)
The value set for the source's \ref umeflightsizebytessource configuration
option is checked against a maximum allowed value specified in the Store's XML
configuration file.

<li>With RPP, if the Store's repository is full with unacknowledged messages
by blocking receivers, the Store will block the source by withholding
stability acknowledgements, resulting in flight size blockage.
See \ref persistenceflightsize.
(With SPP, once the repository is full, it will simply start overwriting the
oldest messages with new messages from the source.)
</ul>

In addition, a disk write delay interval for the repository, improves
performance by preventing unnecessary disk activity.
If all receivers acknowledge within the write delay interval,
the message is deleted from memory without having ever been written to
disk.
This gives an RPP Store comparable performance to a memory-only Store,
while still giving a large disk-based repository if it is needed.
(But notice that if slow or absent receivers cause the write delay to
expire without the needed acknowledgements, the Store performance will
return to the general performance of an SPP Store.
You can tell if the Store has resorted to writing to disk by looking at
the file size of the cache file.
If it is greater than zero, it represents a high water mark of
data written to disk since the file was last deleted.

Informatica recommends provisioning Stores based on SPP Store performance.

RPP introduces the capability of a source application to override set the
settings for the following operational options on the Store:

<ul>
<li>\ref umecfgrepositorysizethreshold "repository-size-threshold"
<li>\ref umecfgrepositorysizelimit "repository-size-limit"
<li>\ref umecfgrepositorydiskfilesizelimit "repository-disk-file-size-limit"
<li>\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay"
<li>\ref umecfgrepositoryallowackonreception "repository-allow-ack-on-reception"
(The source doesn't actually override this option.
This option enables the source to set the Store's ACK behavior.)
</ul>

With SPP, those parameters are set only by the Store configuration file
alone.
With RPP, the source's configuration can optionally request a different value
for those operating parameters, with the Store's configured value being used
as a maximum allowed threshold.

\m4_s2 rppregistration RPP Registration

A source configures its desired pacing behavior (source paced v.s. receiver
paced) with \ref umereceiverpacedpersistencesource and
\ref umereceiverpacedpersistencereceiver.
If set to 1, it becomes an RPP source.
Assuming the Store is configured to allow RPP, when an RPP source registers
with the Store, the Store's repository for that source becomes an RPP
repository.
The receiver configures its desired pacing behavior with
\ref umereceiverpacedpersistencereceiver, where 0 is source-paced and 1 or 2
are receiver-paced.
The receiver's pacing must match that of the source and Store, otherwise the
receiver's registration will fail.
In addition, the choice of 1 or 2 determines the receiver's desired blocking
behavior (1=blocking, 2=non-blocking).

Note that although the configured pacing behavior must match between source
and receiver, that does not mean that the numerical setting of the
\ref umereceiverpacedpersistencesource and
\ref umereceiverpacedpersistencereceiver options must be equal.
If the source is 0 (source paced), then the receiver must also be 0.
However, if the source is 1 (receiver paced), then the receiver must be either
1 or 2, depending on the receiver's desired blocking behavior.

As with Source-paced Persistence, RPP sources send Source Registration
Information (SRI) packets to RPP receivers over the configured UM transport.
RPP Receivers must wait for this information before they can initiate
registration requests to the Store.
See \ref sourceregistration and \ref receiverregistration for more information.

A source registration request includes the following:

<ul>
<li>Designation of an RPP topic
<li>Reconfigured repository configuration option values.
Possible options are the 3 repository size options:
\ref umecfgrepositoryallowackonreception "repository-allow-ack-on-reception",
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay",
and \ref umecfgsourceflightsizebytesmaximum "source-flight-size-bytes-maximum".
<li>Re-registration must request the same configuration options as were
initially requested, or the Store will reject the request.
</ul>

A receiver registration request includes its designation as a RPP receiver.

The repository's registration response to both a source and a receiver
acknowledges RPP mode.

<b>Late Registering Receiver</b>

A late joining receiver that registers after the first RPP topic message has
been sent cannot recover any messages sent prior to its initial registration.
It is the user's responsibility to synchronize a receiver's initial
registration with the start of message transmission.
This restriction does not apply to an RPP receiver that initially registered
at an earlier time and is now re-registering, as after a failure and restart.
In that case, messages that were sent after the receiver's initial
registration will be retained by the Store for recovery by the receiver.

<b>Early Exiting Receiver</b>

Each registered receiver has associated with it an activity timeout and a
state lifetime.
During normal operation, the Store monitors the operation of a registered
receiver.
If the Store hears nothing from a receiver for the duration of the activity
timeout, the Store assumes that the receiver has halted operation.
Messages will be retained by the Store according to the receiver's configured
blocking behavior.
This gives the receiver time to restart and re-register.
If an inactive receiver re-registers before the state lifetime expires,
the receiver will be able to recover all messages that it missed.

However, if a receiver remains halted for the duration of the state lifetime,
the Store will delete the receiver state information.
If the repository is retaining messages for this receiver, those messages
will be implicitly acknowledged on behalf of the expired receiver,
making them eligible for deletion if no other receivers' acknowledgements
are pending.
If the source is blocked waiting for this receiver, the Store will unblock
the source.
Finally, if the halted receiver re-register after its state lifetime has
expired, the Store will treat it as an initial registration, and the messages
it missed will not be available.

<b>UM Version RPP Compatibility Matrix</b>

The following table indicates the result of registration requests across UM
versions:

<table>
<tr><th>Version/Object <th>Pre-ver. 5.3 Store <th>Ver. 5.3 RPP Store <th>Ver. 5.3 Non-RPP Store

<tr><td>Pre 5.3 Source <td>Granted <td>Rejected * <td>Granted *

<tr><td>5.3 RPP Source <td>Granted - Source Error <td>Granted * <td>Rejected *

<tr><td>5.3 Non-RPP Source <td>Granted <td>Rejected * <td>Granted *

<tr><td>Pre 5.3 Receiver <td>Granted <td>Rejected <td>Granted

<tr><td>5.3 RPP Receiver <td>Granted - Receiver Error <td>Granted <td>Rejected

<tr><td>5.3 Non-RPP Receiver <td>Granted <td>Rejected <td>Granted
</table>

Where:

<ul>
<li>Granted - Source Error indicates that the Store granted the registration
but the source detected that RPP behavior was not acknowledged by the Store.
<li>Granted - Receiver Error indicates that the Store granted the registration
but the receiver detected that RPP behavior was not acknowledged by the Store.
<li>* Refers only to the re-registration of a source with an existing source
repository because the source determines the repository's behavior for new
registrations.
</ul>

\m4_s2 rppnormaloperation RPP Normal Operation

At a high level, the normal sequence of operations for RPP is the same as it
is for SPP:

<ol>
<li>Sources transmit messages to receivers and Stores at the same time over UM
transports.
Sources also track stability acknowledgements from the Store.
A source is allowed to send messages ahead of stability acknowledgements up
to the configured flight size.
If the flight size of unstabilized messages is reached, the source is blocked
from sending more messages pending stability acknowledgements from the Store.

<li>Receivers acknowledge consumption of received messages back to Stores,
and optionally to the sources.

<li>Stores retain messages as appropriate, send stability acknowledgements to
the sources for messages, and tracks receiver consumption acknowledgements.
</ol>

One important way that RPP differs from SPP is in the sending of stability
acknowledgements.
With SPP, the Store normally waits to send a stability acknowledgement until
a message is "stable" on the configured storage medium, either disk or memory.
With RPP, the sending of stability acknowledgements is affected by receiver
consumption acknowledgements in two ways:

<ul>
<li>If a message is acknowledged by all registered receivers before the
message is written to disk, then there is no need to retain the message at all.
The message is deleted and a stability acknowledgement is sent to the source.

<li>If the repository reaches its capacity limit and there are blocking
receivers which have not acknowledged the messages, the Store stops sending
stability acknowledgements.
It is the lack of stability acknowledgements, combined with the configured
flight size, which causes the source to block.
(To be precise, the Store stops sending stability when there is exactly one
flight size worth of room available in the repository.)
</ul>

The following also affect stability acknowledgements:

<ul>
<li>Acknowledge on Reception - If the source is configured for
\ref umerepositoryackonreceptionsource and the Store is configured for
\ref umecfgrepositoryallowackonreception "repository-allow-ack-on-reception",
the Store sends a stability
acknowledgement to the source immediately upon reception of a message,
even before any receiver acknowledgements are received,
and before the message is written to disk.
This setting can increase system throughput for some use cases,
but also increases the risk of message loss in the event of a Store failure.

\image html ack_on_reception.png
\image latex ack_on_reception.png

<li>Write Delay - The repository option
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay"
allows the repository to hold messages in memory cache longer before
persisting them to disk.
This delay increases the probability that all RPP receivers acknowledge
message consumption, eliminating the need to persist the message to disk.
</ul>

For memory Store repositories, the options
\ref umerepositoryackonreceptionsource and
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay"
have no effect.

\m4_s2 rppmessagerecovery RPP Message Recovery

The normal way that RPP receivers recover messages is when they re-register
within the state lifetime after a failure.
However, just as with SPP, there is the possibility that the transport session
of the source is unable to successfully deliver all messages to the receiver.
In the event of unrecoverable loss at the transport session,
the Off Transport Recovery (OTR) method is also available for RPP receivers.
OTR does not require the receiver to restart to recover messages from the Store.
See the \ref offtransportrecoveryotr for more information.

\m4_s2 rppderegistration RPP Deregistration

You can deregister either sources or receivers using deregistration APIs,
(lbm_src_ume_deregister(), lbm_rcv_ume_deregister(), and
lbm_wrcv_ume_deregister()).
UM deletes the state of deregistered objects.

If you deregister an RPP receiver, UM automatically decrements the number of
receiver acknowledgements required to maintain RPP behavior.
The Store issues Deregistration Successful events for every source or receiver
that deregisters.
Note that after deregistering a source or receiver, the object will still
exist, but is no longer participating in persistence.
An attempt to send to a deregistered source will return an error.
A deregistered receiver will continue to deliver messages on the topic,
but since it is no longer participating in persistence,
it will be unable to acknowledge those messages.
If the application wants to re-join persistence, it must delete the source
or receiver and re-create it, allowing it to re-register.
See \ref persistenceevents.

Users should be cautious using the deregistration APIs, especially for sources.
Source deregistration will immediately delete from the Store any messages
from that source which might be retained due to lack of receiver
acknowledgement.
This deletion will render the receivers unable to recover those messages.

\m4_s2 implementingrpp Implementing RPP

Follow the procedure below to configure Receiver-paced Persistence:

<ol>
<li>Set \ref umereceiverpacedpersistencesource and
\ref umereceiverpacedpersistencereceiver in the LBM configurations.
If only certain sources or receivers in a context are RPP,
use lbm_*setopt() in the source or receiver application or use UM XML
configuration files.

<li>Set
\ref umecfgrepositoryallowreceiverpacedpersistence "repository-allow-receiver-paced-persistence"
= 1 for the repository in the Store configuration file.

<li>Coordinate \ref umeflightsizebytessource between the repository and the
source.
Set the maximum allowable flight size with the repository option,
\ref umecfgsourceflightsizebytesmaximum "source-flight-size-bytes-maximum".
Sources can reconfigure its flight size bytes to a value less than or equal
to the maximum.

<li>Optional: coordinate the \ref umerepositoryackonreceptionsource
between the repository and the source.
If the repository has
\ref umecfgrepositoryallowackonreception "repository-allow-ack-on-reception"
enabled (1), the source can choose to keep it enabled or turn it off.
If the repository has
\ref umecfgrepositoryallowackonreception "repository-allow-ack-on-reception"
disabled (0), the source cannot turn it on.

<li>Optional: if the repository is a disk repository
(\ref umecfgrepositorytype "repository-type" <b>"disk"</b>),
set the maximum write delay with the repository option,
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay".
Sources can set \ref umewritedelaysource
to a value less than or equal to 
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay".

<li>Optional: coordinate repository size options between the source and
repository.
If you wish to use the repository's values, you do not need to configure
source configuration values.
The repository sets a maximum for these three options.
The source can reconfigure the repository's options with values less than
or equal to the maximum configured for the repository using the following
LBM configuration options:

<ul>
<li>\ref umerepositorysizethresholdsource
<li>\ref umerepositorysizelimitsource
<li>\ref umerepositorydiskfilesizelimitsource
</ul>
</ol>

\m4_s2 examplerppconfigurationfiles Example RPP Configuration Files

The sample configuration files shown below show how a Store configuration
file establishes certain RPP option values and the source can reconfigure
them via an LBM configuration file.
Although only two files appear below, this configuration represents two,
single-Store quorum/consensus groups and one UM context.
A second Store configuration file would be required for the Store
"store1rpp" containing options and values identical to "store0rpp".

<b>LBM Configuration File for RPP</b>

The following example LBM configuration file will work for applications which
have sources and/or receivers that must be persisted using RPP.
This configuration file is written assuming that the Store is configured
as shown in the next section.

<ul>
<li>The source configures \ref umeflightsizebytessource to 1,000,000 bytes.
For this to work, the repository must set
\ref umecfgsourceflightsizebytesmaximum "source-flight-size-bytes-maximum"
to a value greater than or equal to 1,000,000.

<li>The source uses \ref umewritedelaysource to override the repository's
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay"
setting to 1000 ms (1 second).
Note that for this to work, the repository must set
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay"
to a value greater than or equal to 1000 ms.

<li>To remove clutter from the example, the transport type is allowed to
default to TCP.
Many persistence users prefer LBT-RM to more quickly and efficiently
distribute messages to Stores and receivers.
</ul>

\verbatim
##Sample LBM Configuration File
# Default to TCP transport
# Multicast Resolver Network Options
context resolver_multicast_address 225.8.17.29
context resolver_multicast_interface 10.29.3.0/24

## Persistence Options ###
source ume_store_name store0rpp
source ume_store_name store1rpp
source ume_store_name store2rpp
source ume_session_id 535353
source ume_store_behavior qc
source ume_flight_size 500
# RPP-oriented configs.
#   If this app creates receivers, have them request RPP mode.
receiver ume_receiver_paced_persistence 1
#   If this app creates sources, have them request RPP mode.
source ume_receiver_paced_persistence 1
source ume_flight_size_bytes 1000000
#   The following parameters override Store configurations.
source ume_repository_size_threshold 104857600
source ume_repository_size_limit 209715200
source ume_repository_disk_file_size_limit 1073741824
source ume_repository_ack_on_reception 1
source ume_write_delay 1000
\endverbatim

<b>Store Configuration File</b>

In the following example Store configuration file, RPP options appear in the
section for the topic pattern, ABC*.
This configuration file is written assuming client applications (sources
and receivers) use LBM configuration files similar to that shown in the
preceding section.

There are actually three Stores configured in QC.
The other two's configurations should differ appropriately.
For example, change each instance of "store0" to "store1" and "store2"
respectively.

\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <log>/configs/stores/umestore0/umestored.log</log>
    <pidfile>/configs/stores/umestore0/umestored.pid</pidfile>
    <lbm-config>/configs/lbm_store0.cfg</lbm-config>
    <web-monitor>*:15404</web-monitor>
  </daemon>
  <stores>
    <store name="rpp-ump-test-store0" port="14667">
      <ume-attributes>
        <option type="store" name="disk-cache-directory" value="/stores/store1/cache"/>
        <option type="store" name="disk-state-directory" value="/stores/store1/state"/>
        <option type="store" name="context-name" value="store0rpp"/>
      </ume-attributes>
      <topics>
        <topic pattern="ABC.*" type="PCRE">
          <ume-attributes>
             <option type="store" name="repository-allow-receiver-paced-persistence" value="1"/>
             <option type="store" name="repository-type" value="disk"/>
             <option type="store" name="repository-size-threshold" value="2048"/>
             <option type="store" name="repository-size-limit" value="209715200"/>
             <option type="store" name="repository-disk-file-size-limit" value="1073741824"/>
             <option type="store" name="source-flight-size-bytes-maximum" value="4194304"/>
             <option type="store" name="repository-allow-ack-on-reception" value="1"/>
             <option type="store" name="repository-disk-write-delay" value="1000"/>
          </ume-attributes>
        </topic>
      </topics>
    </store>
  </stores>
</ume-store>
\endcode

\m4_s2 rppcrossfeaturefunctionality RPP Cross Feature Functionality

<table>
<tr><th>UM Feature <th>Supported <th>Notes
<tr><td>Store Proxy Sources <td>Yes
<tr><td>DRO <td>Yes <td>
<tr><td>UM Transports <td>Yes <td>
<tr><td>Multi-Transport Threads <td>No <td>The Multi-Transport Threads does not support persistence.
<tr><td>Off-Transport Recovery <td>Yes <td>
<tr><td>Late Join <td>No <td>A receiver cannot recover messages sent prior to that receiver's initial registration.
<tr><td>HF <td>Yes <td>
<tr><td>HFX <td>Yes <td>
<tr><td>Wildcard Receivers <td>Yes <td>
<tr><td>Message Batching <td>Yes <td>
<tr><td>Ordered Delivery <td>Yes <td>
<tr><td>Request/Response <td>Yes <td>
<tr><td>Multicast Immediate Messaging (MIM) <td>No <td>MIM messages are not persisted and have no impact on RPP.
<tr><td>Source Side Filtering <td>Yes <td>
<tr><td>Self-Describing Messaging (SDM) <td>Yes <td>
<tr><td>Pre-Defined Messaging (PDM) <td>Yes <td>
<tr><td>UM Spectrum <td>Yes <td>
<tr><td>Monitoring/Statistics <td>Yes <td>
<tr><td>Acceleration - DBL <td>Yes <td>
<tr><td>Acceleration - UD <td>Yes <td>
<tr><td>Implicit/Explicit Acknowledgements <td>Yes <td>
<tr><td>Registration ID/Session Management <td>Yes <td>
<tr><td>Fault Tolerance - Quorum Consensus <td>Yes <td>
<tr><td>UM SNMP Agent <td>Yes <td>
<tr><td>Ultra Messaging Manager <td>Yes <td>
<tr><td>Ultra Messaging Cache <td>Yes <td>
<tr><td>Ultra Messaging Desktop Services <td>No <td>
</table>

\m4_s1 persistenceevents Persistence Events

The Ultra Messaging API provides a number of events, callbacks, messages,
functions, and settings.
The API reference (C API, Java API or .NET API) can be used to see the true
extent of the API.
In order to design successful applications, though, a high level
understanding of the events and callbacks is essential.

<ul>
<li>Events - Source events occur on a per source basis.
<li>Callbacks - Source and receiver application callbacks called directly from
UM internal operation and usually demands a return value be filled in and/or
are informational in nature.
Typically, applications do very little processing in callbacks.
<li>Messages - Messages to receivers can simply contain UM information or
have impact on operation.
</ul>

Some specific languages, such as C, Java, or C# may have specific nuances
for the various events and callbacks.
But, by and large, an application should plan on having access to the
items listed in the following sections.
For details for a particular language, consult the Ultra Messaging API
documentation (C API, Java API or .NET API).

\m4_s2 persistencesourceevents Persistence Source Events

The following events and callbacks are available for source applications:

<table>
<tr><th>Event Name <th>Type <th>Description
<tr><td>Store Registration Success <td>Source Event <td>Delivered once a
source has successfully registered with a single Store.
Event contains flags to show if the source is "old" (i.e. a re-registration)
as well as the sequence number that the source should use as its initial
sequence number when sending, and the Store information.
See \ref LBM_SRC_EVENT_UME_REGISTRATION_SUCCESS_EX.

<tr><td>Store Registration Complete <td>Source Event <td>Delivered once a
source has completed registration with the required Store(s).
This indicates the source may send as it desires.
Event contains the consensus sequence number.
See \ref LBM_SRC_EVENT_UME_REGISTRATION_COMPLETE_EX.

<tr><td>Store Registration Error <td>Source Event <td>Delivered once a source
has received an error from the Store indicating the requested registration
was not granted. Event contains an error message to indicate what happened.
See \ref LBM_SRC_EVENT_UME_REGISTRATION_ERROR.

<tr><td>Store Message Stable <td>Source Event <td>Delivered once a message is
stable at a single Store.
Event contains the message sequence number and indicates if the message
meets Intergroup and/or Intragroup stability requirements.
Also includes the Store information.
See \ref LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX.

<tr><td>Store Message Not Stable <td>Source Event <td>Delivered once a
message's \ref umemessagestabilitylifetimesource has expired.
The source no longer retransmits the message to the Store.
See \ref LBM_SRC_EVENT_UME_MESSAGE_NOT_STABLE.

<tr><td>Delivery Confirmation <td>Source Event <td>Delivered once a message
has been confirmed as delivered and processed by a receiving application.
Event contains the message sequence number as well as indications whether
the message has met the unique confirmations requirement.
Also contains the receiver's Registration ID or Session ID.
See \ref LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX.

<tr><td>Store Unresponsive <td>Source Event <td>Delivered once a Store is
seen to be unresponsive due to failure or network disconnect.
Event contains a message with more details suitable for logging.
If a majority of a source's configured Stores are unresponsive,
the application will not be allowed to send messages.
See \ref LBM_SRC_EVENT_UME_STORE_UNRESPONSIVE.

<tr><td>Store Message Reclaimed <td>Source Event <td>Delivered once a message
has passed through retention and is about to be released from memory or disk.
Event contains the message sequence number.
(Reclaim refers to storage space reclamation.)
See \ref LBM_SRC_EVENT_UME_MESSAGE_RECLAIMED_EX.

<tr><td>Store Forced Reclaim <td>Callback <td>Indicates a message is being
forcibly released because the memory size limit
(\ref retransmitretentionsizelimitsource) has been exceeded or the message's
\ref umemessagestabilitylifetimesource has expired.
Event contains the message sequence number.
See \ref umeforcereclaimfunctionsource.

<tr><td>Flight Size Notification <td>Source Event <td>Indicates that the number
of in-flight messages for a source has exceeded or fallen below the configured
flight size limit for a source.
The event indicates if the flight size has been exceeded (OVER) by a new
message send or that a message recently stabilized has reduced the number
of in flight messages to less than the flight size limit (UNDER).
See \ref LBM_SRC_EVENT_FLIGHT_SIZE_NOTIFICATION.

<tr><td>Source Deregistration Success <td>Source Event <td>Delivered once
a source successfully deregisters from an individual Store.
The event contains either the RegID or Session ID, the sequence number of the
last message stored for the source and Store information.
See \ref LBM_SRC_EVENT_UME_DEREGISTRATION_SUCCESS_EX.

<tr><td>Source Deregistration Complete <td>Source Event <td>Delivered
once UM receives a successful deregistration event from all Stores.
See \ref LBM_SRC_EVENT_UME_DEREGISTRATION_COMPLETE_EX.
</table>

\m4_s2 persistencereceiverevents Persistence Receiver Events

The following callbacks and messages are available for receiver applications:

<table>
<tr><th>Event Name <th>Type <th>Description

<tr><td>Store Registration Success <td>Message <td>Delivered once a receiver
has successfully registered with a single Store.
Message contains flags to show if the receiver is "old" (i.e. Not a new
registration) as well as the sequence number that the receiver should use as
its low sequence number, and the Store information.
In addition, the event contains the source's Registration ID or Session ID
and the receiver's Registration ID or Session ID.
See \ref LBM_MSG_UME_REGISTRATION_SUCCESS_EX.

<tr><td>Store Registration Complete <td>Message <td>Delivered once a receiver
has completed registration with the Store(s) required.
This indicates the receiver may now receive data.
Message contains the consensus sequence number.
See \ref LBM_MSG_UME_REGISTRATION_COMPLETE_EX.

<tr><td>Store Registration Failure <td>Message <td>Delivered once a
receiver has received an error from the Store indicating the requested
registration was not granted. Event contains an error message to indicate
what happened.
See \ref LBM_MSG_UME_REGISTRATION_ERROR.

<tr><td>Receiver Deregistration Success <td>Message <td>Delivered once a
receiver successfully deregisters from an individual Store.
The message contains either the RegID or Session ID for the receiver and the
source, the sequence number of the last message stored for the source and
Store information.
See \ref LBM_MSG_UME_DEREGISTRATION_SUCCESS_EX.

<tr><td>Receiver Deregistration Complete <td>Message <td>Delivered once
UM receives a successful deregistration event from all Stores.
See \ref LBM_MSG_UME_DEREGISTRATION_COMPLETE_EX.

<tr><td>Store Registration Change <td>Message <td>Delivered once a change in
Store information is received from the source.
The extent of the change is included in a message suitable for logging.
See \ref LBM_MSG_UME_REGISTRATION_CHANGE.

<tr><td>Store Retransmission <td>Message <td>Retransmissions from recovery
come in as normal messages with a flag indicating their status as a
retransmission.
See \ref LBM_MSG_FLAG_UME_RETRANSMIT and \ref LBM_MSG_FLAG_OTR.

<tr><td>Store Registration Function <td>Callback <td>Called once a receiver
receives Store information from a source and UM desires to know the RegID to
use for the receiver.
Callback passes the source RegID, the Store information, and the source
transport name.
The return value is the RegID that UM should request to use from the Store.
See \ref umeregistrationextendedfunctionreceiver.

<tr><td>Store Recovery Sequence Number Function <td>Callback <td>Called once
registration is about to complete and the low sequence number must be
determined.
Callback passes the highest sequence number seen from the source and
the consensus sequence number from the Stores.
See \ref umerecoverysequencenumberinfofunctionreceiver.
</table>

\m4_s1 storemonitoring Store Monitoring

See \ref monitoring for an overview of monitoring an Ultra Messaging
network.

It is important to the health and stability of a UM network to
monitor the operation of Stores.
This monitoring should include real-time automated detection of
problems that will produce a timely alert to operations staff.

Three types of data should be monitored:
<ul>
<li>\ref storemonitoringlogs "Log file".
<li>\ref storemonitoringumlibrarystats "UM library statistics" (context, source, receiver, wildcard receiver, event queue).
<li>\ref storemonitoringdaemonstats "Daemon statistics" (similar data to the \ref storewebmonitor).
</ul>

For UM library stats and daemon stats,
the monitoring messages contain an "application ID".
For UM applications, this is a user-specified name
intended to identify the individual component/instance,
and is supplied by the option \ref monitorappidcontext.

However, in the Store,
the "monitor-appid" is typically set in the store's XML configuration file,
so that it can be set on a store-basis.
I.e. if the Store daemon is configured with multiple Store instances,
each one can be given its own "monitor-appid".

For example, a Store configured with:
\code
  <stores>
    <store name="store_topic1" interface="10.29.4.0/24" port="12801">
      <ume-attributes>
        <option type="lbm-context" name="monitor_appid" value="store_appid_topic1"/>
        ...
\endcode
The UM library stats will have the application ID `"store_appid_topic1"`.

However, in the case of Store daemon stats, the "name" attribute of the
\ref umeelementstore is used as the application ID.
So in the above example Store configuration,
the daemon stats will have the application ID `"store_topic1"`.

\m4_s2 storemonitoringlogs Store Monitoring: Logs

Ideally, log file monitoring would support the following:
<ul>
<li>Archive all log messages for all Stores for at least a week, preferably a month.
<li>Provide rapid access to operations staff to view the latest log messages from a Store.
<li>Periodic scans of the log file to detect errors and raise alerts to operations staff.
</ul>

Regarding log file scanning, messages in the Store's log file contain a
severity indicator in square brackets. For example:
\verbatim
Sun Oct 30 08:32:22 2022 [WARNING]: Store-5688-5445: WARNING: store "store_topic1" cache directory appears to be on an NFS mount. This is not recommended.
\endverbatim
Informatica recommends alerting operations staff for messages of severity
[WARNING], [ERROR], [CRITICAL], [ALERT], and [EMERGENCY].

It would also be useful to have a set of exceptions for specific messages
you wish to ignore.
For example, if you have a Store that must locate its state and cache files
on an NFS mount,
you might want to have your scanner exclude message Store-5688-5445.

There are many third party real-time log file analysis tools available.
A discussion of possible tools is beyond the scope of UM documentation.

\m4_s2 storemonitoringumlibrarystats Store Monitoring: UM Library Stats

The Store communicates with persistent applications using Ultra Messaging
protocols, and therefore makes use of the UM library.
It is just as important to monitor the UM library statistics for
the Store as it is for applications.
Automatic monitoring is enabled using the same configuration options
as for applications.

There are two data formats for UM library stats:
<ul>
<li>Protobufs - recommended.
<li>CSV - deprecated. Informatica recommends migrating to protobufs.
</ul>

For example, here is an excerpt from a sample Store configuration file that
shows how an XML-based UM library configuration file is specified:
\code
<ume-store version="1.3">
  <daemon>
    ...
    <xml-config>um.xml</xml-config>
    ...
\endcode

Here is an excerpt from a sample "um.xml":
\code
<?xml version="1.0" encoding="UTF-8" ?>
<um-configuration version="1.0">
  <templates>
    ...
    <template name="automonitor">
      <options type="context">
        <option name="monitor_format" default-value="pb"/>
        <option name="monitor_interval" default-value="600"/>
        <option name="monitor_transport" default-value="lbm"/>
      </options>
    </template>
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
    <application name="umestored">
      <contexts>
        <context name="store_topic1" template="mytemplate,automonitor">
          <sources/>
        </context>
        <context name="29west_statistics_context" template="mon_ctx">
          <sources/>
        </context>
      </contexts>
    </application>
    ...
\endcode

<b>Notes:</b>

<ol>

<li>The \ref monitorformatcontext value "pb"
selects the protobuf format and is available for the
Store in UM version 6.14 and beyond.
Selecting this format implicitly enables the inclusion of the
Store's daemon stats (see below).

<li>For a list of possible protobuf messages for the Store,
see the "ump_mon.proto" file at \ref exampleump_mon_proto.

<li>The Store context named "store_topic1" is configured with the
`"automonitor"` template, which sets the automatic monitoring options.
The \ref monitorintervalcontext option enables automatic monitoring
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

\m4_s2 storemonitoringdaemonstats Store Monitoring: Daemon Stats

The daemon statistics for the Store represent a superset of the
information presented on the \ref storewebmonitor.

There are two data formats for the Store to send its daemon stats:
<ul>
<li><b>Protobufs</b> - recommended.
The protobufs format is accepted by the \ref monitoringcollectorservicemcs
and the "lbmmon" example applications:
\ref examplelbmmon_c and \ref examplelbmmon_java.
<li><b>Binary</b> - deprecated. Informatica recommends migrating to protobufs.
For information on the deprecated binary formatted daemon stats,
see \ref storedaemonstatistics.
</ul>

The recommended way to enable Store daemon stats is by
enabling UM library stats using using \ref monitorformatcontext with format "pb".
For example, here's an excerpt from a UM library XML configuration file from
https://github.com/UltraMessaging/mcs_demo file
<a href="https://github.com/UltraMessaging/mcs_demo/blob/main/um.xml">um.xml</a>:
\verbatim
    <template name="automonitor">
      <!-- Additional application configuration to enable automatic monitoring. -->
      <options type="context">
        <option name="monitor_format" default-value="pb"/>
        <option name="monitor_interval" default-value="600"/>
        <option name="monitor_transport" default-value="lbm"/>
      </options>
    </template>
    ...
    <application name="store1">
      <contexts>
        <context name="store_topic1" template="mytemplate,automonitor,res_trd1">
          <sources/>
        </context>
        <!-- Context created by automatic monitoring. -->
        <context name="29west_statistics_context" template="mon_ctx">
          <sources/>
        </context>
      </contexts>
    </application>
\endverbatim

The protobufs format is accepted by the \ref monitoringcollectorservicemcs
and the "lbmmon" example applications:
\ref examplelbmmon_c and \ref examplelbmmon_java.

For a list of possible protobuf messages for the Store,
see the "ump_mon.proto" file at \ref exampleump_mon_proto.

For a full demonstration of monitoring, including Store daemon stats, see:
https://github.com/UltraMessaging/mcs_demo

See also \ref storemonitoringumlibrarystats.

\m4_pg storerepositoryprofilingsrp Store Repository Profiling (SRP)

To aid the users in operating and maintaining their Persistent Store
deployment,
Informatica provides an API that will read Store cache and state files
and return useful information about them, including message content.
This is the Store Repository Profiling (SRP) API.
(The API is not in the normal "lbm" library; see \ref usingthesrpapi.)

Also supplied is the "umesnaprepo" example program,
which uses the SRP API to read the information and print to standard out.
It can be used as-is (see \ref umesnaprepomanpage), or its source code
(\ref exampleumesnaprepo_c)
can be used as a guide for users to develop their own management tools.

This API and example program are supported on the same platforms that
support the Persistent Store: 64-bit Linux and 64-bit Windows.
The API is C-only (no Java or .NET).
Also be aware that the API is read-only.
The API does not provide a way to modify the cache or state files.

<b>IMPORTANT</b>: due to differences in certain Windows and Linux data sizes,
a given set of state and cache files needs to be read on the same platform
where it was generated.
For example it is *NOT* valid to copy a Linux Store's files to a Windows
machine and use the windows-based SRP API or command-line tool to read them.

\note The Store instance <b>should NOT be running</b> while the API
or example program is used to read the Store files.
There currently is no tool that performs the same function on an
actively running Store.

\m4_s1 usingthesrpapi Using the SRP API

Use the \ref exampleumesnaprepo_c source code as your guide.

The 
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../API/umeprofile_8h.html.html">umeprofile.h</a>
header file contains the needed definitions.

The API code is *not* contained within the normal "lbm" library.
On Linux, it is in "libumestorelib.a", a static library.
On Windows, it is in "umestore.dll", a dynamic library.

The main API functions are:
<ul>
<li>lbm_srp_create()
<li>lbm_srp_delete()
<li>lbm_srp_get_repo_state()
<li>lbm_srp_free_repo_state()
<li>lbm_srp_get_repo_message()
</ul>

\m4_s1 umesnaprepomanpage umesnaprepo Man Page

The "umesnaprepo" command is an example program that uses the
\ref storerepositoryprofilingsrp API to read Store state and cache
files and print useful information, including message content.
It can be used as-is, or its source code (\ref exampleumesnaprepo_c)
can be used as a guide for users to develop their own management tools.

\note The Store instance <b>should NOT be running</b> while the API
or example program is used to read the Store files.
There currently is no tool that performs the same function on an
actively running Store.

\verbatim
m4_esyscmd([[[../share/get_usage.pl -p unused -u profile_repo_usage -H unused ../../src/example/umesnaprepo.c]]])m4_dnl
\endverbatim

For example:
\verbatim
umesnaprepo -s /UM/store5/state -c /UM/store5/cache
\endverbatim

This examines the state and cache files and prints information for every
Store instance represented there.
Here's some example output:
\verbatim
Examining repository at index: 0
state_filename: /UM/store5/state/2545027182-state
cache_filename: /UM/store5/cache/2545027182-cache
...
Repository cache:
    number of messages: 26
...
Receiver 0
    regid: 2545027183
    sqn: 25
...
Message sqn [0]:
   tsp: 1584022054.898262
   disk_len: 37
   disk_offset: 0
   flags: 0x01
Message body:
00 00 00 25 a4 ab 82 e6 00 00 00 00 6d 65 73 73         ...%........mess
61 67 65 20 30 00 00 00 00 00 00 00 00 00 00 00         age 0...........
00 00 00 00 00                                          .....          
...
\endverbatim

In this example output, notice that the actual beginning of the message
(the first byte is the "m" of "message 0") is at offset 12 from the beginning
of the buffer.
The 12 bytes in front of the message is the "LBMC" header.
The example application lets you supply the "-T" option,
which parses the LBMC header and starts printing the message at the actual
start of data.

\m4_pg enablingpersistence Enabling Persistence

The following table lists all source files used in this section. The files can be found in the /doc/example directory. You can also access these file via the Sample Source Code tab in the left panel, under C Example Source Code.

<table>
<tr><th>Filename <th>Content
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src.c">ume-example-src.c</a> <td>Source Application
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv.c">ume-example-rcv.c</a> <td>Receiver Application
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-2.c">ume-example-src-2.c</a> <td>Source Application 2
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-2.c">ume-example-rcv-2.c</a> <td>Receiver Application 2
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-3.c">ume-example-src-3.c</a> <td>Source Application 3
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-3.c">ume-example-rcv-3.c</a> <td>Receiver Application 3
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-config.xml">ume-example-config.xml</a> <td>Persistent Store Configuration File
</table>

\m4_s1 startingconfiguration Starting Configuration

We begin with the minimal source and receiver used by the QuickStart Guide.
To more easily demonstrate the persistence features we are interested in,
we have modified the QuickStart source and receiver in the following ways.

<ul>
<li>Modified the source to send 20 messages with a one second pause between
each message.
<li>Modified the receiver to anticipate 20 messages instead of just one.
<li>Assigned the topic, "UME Example", to both the source and receiver.
<li>Modified the receiver to not exit on unexpected receiver events.
</ul>

The last change allows us to better demonstrate basic operation and evolve
our receiver slowly without having to anticipate all the options that
UM provides up front.

Example files for our exercise are:
<table>
<tr><th>Filename <th>Content
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src.c">ume-example-src.c</a> <td>Source Application
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv.c">ume-example-rcv.c</a> <td>Receiver Application
</table>

\m4_s1 addingthestoretoasource Adding the Store to a Source

The fundamental component of a persistence solution is the Persistent Store.
To use a Store, a source needs to be configured to use one by setting
\ref umestoresource for the source.
We can do that with the following piece of code.

\code
err = lbm_src_topic_attr_str_setopt(&attr, "ume_store", "127.0.0.1:14567");
\endcode

This sets the Persistent Store for the source to the Store running at
127.0.0.1 on port 14567.

Example files for our exercise are:
<table>
<tr><th>Filename <th>Content
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-2.c">ume-example-src-2.c</a> <td>Source Application 2
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-2.c">ume-example-rcv-2.c</a> <td>Receiver Application 2
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-config.xml">ume-example-config.xml</a> <td>Persistent Store Configuration File
</table>

After adding the Store specification to the source,
perform the following steps (assumes a Unix command prompt):

<ol>
<li>Create the cache and state directories.
\verbatim
$ mkdir umestored-cache ; mkdir umestored-state
\endverbatim
<li>Start up the Store.
\verbatim
$ umestored ume-example-config.xml
\endverbatim
<li>Start the Receiver.
\verbatim
$ ume-example-rcv
\endverbatim
<li>Start the Source.
\verbatim
$ ume-example-src
\endverbatim
</ol>

You should see a message on the source that says:

\verbatim
INFO: Source "UME Example" Late Join not set, but UME store specified. Setting Late Join.
\endverbatim

This is an informational message from UM and merely means Late Join was
not set and that UM is going to set it.

Notice that the receiver was not configured with any Store information.
That is because setting it on the source is all that is needed.
The receiver learns Store settings from the source through the normal
UM topic resolution process.
Receivers don't need to do anything special to leverage the usage of a
Store by a source.

\m4_s1 addingfaultrecoverywithregistrationids Adding Fault Recovery with Registration IDs

If the source or receiver crashes, how does the source and receiver tell
the Store that they have restarted and wish to resume where they left off?
We need to add in some sort of identifiers to the source and receiver so
that the Store knows which sources and receivers they are.

In persistence, these identifiers are called Registration IDs or RegIDs.
UM allows the application to control the use of RegIDs as it wishes.
This allows applications to migrate sources and receivers not just between
systems, but between locations with true, unprecedented freedom.
However, UM requires an application to be careful of how it uses RegIDs.
Specifically, an application must not use the same RegID for multiple
sources and/or receivers at the same time.

Now let's look at how we can use RegIDs to provide complete fault recovery
of sources and receivers.
We'll first handle RegIDs in the simplest manner by using static IDs for
our source and receiver.
For the source, the RegID of 1000 can be added to the existing Store
specification by changing the string to `127.0.0.1:14567:1000`

This yields the source code in
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-2.c">ume-example-src-2.c</a>

For the receiver, we accomplish this in two steps.

<ol>
<li>Set a callback function to be called when we desire to set the
RegID to 1100.
This is done by declaring a callback function which will return the
RegID value 1100 to UM.
The example names the callback `app_rcv_regid_callback()`.

<li>Inform the LBM configuration for the receiver to use this callback
function.
That is accomplished by setting the ume_registration_extended_function()
similar to example code below.
</ol>

\code
lbm_ume_rcv_regid_ex_func_t id;      /* structure to hold registration function information */
id.func = app_rcv_regid_callback;    /* the callback function to call */
id.clientd = NULL;                   /* the value to pass in the clientd to the function */
err = lbm_rcv_topic_attr_setopt(&attr, "ume_registration_extended_function", &id, sizeof(id));
\endcode

Once this is done, the receiver has the ability to control what RegID it
will use.
This yields the source code in
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-2.c">ume-example-rcv-2.c</a>.

With these in place, you can experiment with killing the receiver and
bringing it back (as long as you bring it back before the source is finished),
as well as killing the source and bringing it back.

The restriction to this initial approach to RegIDs is that the RegIDs 1000
and 1100 may not be used by any other objects at the same time.
If you run additional sources or receivers, they must be assigned new RegIDs,
not 1000 or 1100.
Let's now take a more sophisticated approach to RegIDs that will allow much
more flexibility.

\m4_s1 enablingpersistencebetweenthesourceandstore Enabling Persistence Between the Source and Store

Let's refine our source to include some desired behavior following a crash.
Upon restart, we want our source to resume with the first unsent message.
For example, if the source sent 10 messages and crashed, we want our source to
resume with the 11th message and continue until it has sent the 20th message.

Accomplishing this graceful resumption requires us to ensure that our source
is the only source that uses the RegID assigned to it.
The same RegID should be used as long as the source has not sent the 20th
message regardless of any crashes that may occur.
The sources and receivers are primarily responsible for managing the RegIDs.

The following two sections explain the changes needed for the source and
receiver, which become fairly easy due to the events that UM delivers to
the application during persistence operation.

\m4_s1 enablingpersistenceinthesource Enabling Persistence in the Source

With the above mentioned behaviors in mind, let's turn to looking at how they
may be implemented with persistence, starting with the source.
We can summarize the changes we need by the following list.

<ol>
<li>At source startup, use any saved RegID information found in the file by
setting information in the \ref umestoresource configuration variable.
<li>After the Store registration is successful, if a new RegID was assigned
to the source, save the RegID to the file.
<li>Set the message number to begin sending.
Refer to the explanation below.
<li>Send until message number 20 has been sent.
<li>After message 20 has been sent, delete the saved RegID file.
</ol>

For Step 3, if the source has just been initialized, the application starts
with message number 1.
If the source has been restarted after a crash, the application looks to UM
to establish the beginning message number because UM will use the next
sequence number.
For this simple example, we can make the assumption that each message is
one sequence number for UM and that UM starts with sequence number 0.
Thus the application can set the message number it begins resending with
the value of the UM sequence number + 1.
These changes yield the source code in
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-3.c">ume-example-src-3.c</a>

\m4_s2 smartsourcesandpersistence Smart Sources and Persistence

When using the \ref smartsources feature to send persistent messages, there
are a few restrictions:
<ul>
<li>No support for source-side delivery confirmation.
Neither of the forms described in \ref deliveryconfirmationconcept are allowed.
<li>No support for \ref receiverlivenessdetection.
<li>Application stability notification is only supported per-message.
See \ref umemessagestabilitynotificationsource.
<li>The following configuration options have limited or no support with
Smart Sources:
<ul>
<li>\ref umeconfirmeddeliverynotificationsource
<li>\ref umeretentionuniqueconfirmationssource
<li>\ref umesriflushsrirequestresponsesource
<li>\ref umesrirequestresponselatencysource
<li>\ref umemessagestabilitynotificationsource
<li>\ref retransmitretentionsizethresholdsource
<li>\ref umeretentionsizethresholdsource
<li>\ref retransmitretentionsizelimitsource
<li>\ref umeretentionsizelimitsource
<li>\ref retransmitretentionagethresholdsource
</ul>
</ul>

\m4_s1 enablingpersistenceinthereceiver Enabling Persistence in the Receiver

Let's also refine the receiver to resume where it left off after a crash.
Just as with the source, the receiver can have the Store assign it a RegID
if the receiver is just beginning.
Once the receiver receives the 20th message from the source,
it can get rid of the RegID and exit.
Because the receiver can receive some messages, crash, and come back,
we should only need to look at a message and check if it is the 20th
message based on the message contents or sequence number.
UM provides all the events to the application that we need to
create these behaviors in the receiver.

The receiver changes are summarized below:

<ol>
<li>At receiver startup, use any saved RegID information
found in the file for callback information when needed.

<li>When RegID callback is called: Check to see if the source RegID matches
the saved source RegID.
If it does, return the saved receiver RegID.
RegID matches the saved source RegID if so, return the saved receiver RegID.

<li>After Store registration is successful: If not using a previously saved
RegID, then save the RegID assigned by the Store to the source to a file,
as well as the Store information and the source RegID.

<li>After the last message is received (message number 20 or UM sequence
number 19), end the application and delete the saved RegID file.
</ol>

RegIDs in UM can be considered to be per source and per topic.
Thus the receiver does not want to use the wrong RegID for a different
source on the same topic.
To avoid this, we save the source RegID and even Store information so that
the `app_rcv_regid_callback()` can make sure to use the correct RegID for
the given source RegID.
These changes yield the source code in
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-3.c">ume-example-rcv-3.c</a>

The above sources and receivers are simplified for illustration purposes
and do have some limitations.
The receiver will only keep the information for one source at a time saved
to the file.
This is fine for illustration purposes, but would be lacking in
completeness for production applications unless it was assured that a
single source for any topic would be in use.
To extend the receiver to include several sources is simply a matter of
saving each to the file, reading them in at startup, and being able to
search for the correct one for each callback invoked.

\m4_pg demonstratingpersistence Demonstrating Persistence

The following files are used in this section:

<table>
<tr><th>Filename <th>Content
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-3.c">ume-example-src-3.c</a> <td>Source Application 3
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-3.c">ume-example-rcv-3.c</a> <td>Receiver Application 3
<tr><td><a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-config.xml">ume-example-config.xml</a> <td>Persistent Store Configuration File
</table>

Perform the following tasks first:

<ol>
<li>Build ume-example-rcv-3.c and ume-example-src-3.c.
Instructions for building them are at the beginning of the source files.

<li>Create default directories, umestored-cache and umestored-state in the
/doc/UME directory where the other ume-example files are located.
Our sample Store configuration file, ume-example-config.xml, doesn't
specify directories for the Store's cache and state files,
so those will be placed in the default directories.

<li>Start the Store.
\verbatim
$ umestored ume-example-config.xml
\endverbatim
</ol>

You should see no output if the Store started successfully.
However, you should find a new log file, ume-example-stored.log,
in the directory you ran the Store in.
The first couple lines should look similar to below.

\verbatim
Sun Oct 29 14:15:01 yyyy [INFO]: Store-5688-5273: Latency Busters Persistent Store version m4_vers
Sun Oct 29 14:15:01 yyyy [INFO]: Store-5688-5274: UMP m4_vers [[[[UMP-]]]m4_vers] [64-bit] Build: mmm dd yyyy, hh:mm:ss ( DEBUG license LBT-RM LBT-RU LBT-IPC LBT-SMX ) WC[PCRE 7.4 2007-09-21, regex, appcb] HRT[gettimeofday()]
\endverbatim

You'll also be able to view the Store's web monitor.
Open a web browser and go to: `http://127.0.0.1:15304/`

You should see the Store's web monitor page, which is a diagnostic and
monitoring tool for the Store.
See \ref storewebmonitor.

\m4_s1 runningpersistentexampleapplications Running Persistent Example Applications

With the Store running, let's try our example source and receiver applications.

<ol>
<li>Start the Receiver.
\verbatim
$ ume-example-rcv-3.exe
\endverbatim
<li>Start the Source.
\verbatim
$ ume-example-src-3.exe
\endverbatim
</ol>

You should see output for the source similar to the following:
\verbatim
saving RegID info to "UME-example-src-RegID" - 127.0.0.1:14567:2795623327
\endverbatim

You should see output for the receiver similar to the following:

\verbatim
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][2795623327] Requesting RegID: 0
saving RegID info to "UME-example-rcv-RegID" - 127.0.0.1:14567:2795623327:2795623328
Received 15 bytes on topic UME Example (sequence number 0) 'UME Message 01'
Received 15 bytes on topic UME Example (sequence number 1) 'UME Message 02'
Received 15 bytes on topic UME Example (sequence number 2) 'UME Message 03'
Received 15 bytes on topic UME Example (sequence number 3) 'UME Message 04'
...
\endverbatim

The example source sends 20 messages.
After the 20th messages, both the source and receiver exit and print:`
<br>`removing saved RegID file...`
<br>So what just happened? Let's walk through the output line by line.

<b>Source</b>

\verbatim
saving RegID info to "UME-example-src-RegID" - 127.0.0.1:14567:2795623327
\endverbatim

The source successfully registered with the Store using its pre-configured
Store address and port of 127.0.0.1:14567.
It didn't ask for a specific RegID from the Store, so the Store
automatically assigned one to it.
In this case, the Store assigned the ID, 2795623327.
Your source's ID will likely be different because Stores assign random RegIDs.

If you run the test again, you'll notice the source application has written
a file named '`UME-example-src-RegID`' that contains the same information the
source printed on startup, namely the IP address and port of the Store it
registered with, along with its RegID assigned by the Store.

<b>Receiver</b>

\verbatim
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][2795623327] Requesting RegID: 0
saving RegID info to "UME-example-rcv-RegID" - 127.0.0.1:14567:2795623327:2795623328
\endverbatim

The receiver has been informed of how to connect to the Store by the source,
and it also successfully registered with the Store.
The Store's IP address and port are shown, followed by the source's unique
identifier string (in this case, it's a TCP source on port 14371),
and the source's RegID.
The receiver then requests RegID 0 from the Store, which is a special value
that means pick an ID for me (Although not displayed, the source requested
ID 0 when it started up as well).

In parallel with the source application, the receiver application writes
its RegID with this Store to the file, `UME-example-rcv-RegID`.

After sending 20 messages under normal, stable conditions, the source and
receiver applications exit and remove their RegID files.

\m4_s1 singlereceiverfailsandrecovers Single Receiver Fails and Recovers

Perform the following procedure with the Store running to see what happens
when a receiver fails and recovers:

<ol>
<li>Start the Receiver.
\verbatim
$ ume-example-rcv-3.exe
\endverbatim

<li>Start the source.
Let it run for a few seconds so the receiver gets a few messages.

\verbatim
$ ume-example-src-3.exe
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][3735579353] Requesting RegID: 0
saving RegID info to "UME-example-rcv-RegID" - 127.0.0.1:14567:3735579353:3735579354
Received 15 bytes on topic UME Example (sequence number 0) 'UME Message 01'
Received 15 bytes on topic UME Example (sequence number 1) 'UME Message 02'
Received 15 bytes on topic UME Example (sequence number 2) 'UME Message 03'
\endverbatim

<li>Stop the receiver (Ctrl/C) and leave the source running.
Wait a few more seconds so that the source sends some messages while the
receiver was down.

<li>Restart the Receiver and let it run to completion.

\verbatim
$ ume-example-rcv-3.exe
read in saved RegID info from "UME-example-rcv-RegID" - 127.0.0.1:14567 RegIDs
source 3735579353, receiver 3735579354
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][3735579353]
Requesting RegID: 3735579354
Received 15 bytes on topic UME Example (sequence number 3) 'UME Message 04'
Received 15 bytes on topic UME Example (sequence number 4) 'UME Message 05'
Received 15 bytes on topic UME Example (sequence number 5) 'UME Message 06'
Received 15 bytes on topic UME Example (sequence number 6) 'UME Message 07'
Received 15 bytes on topic UME Example (sequence number 7) 'UME Message 08'
Received 15 bytes on topic UME Example (sequence number 8) 'UME Message 09'
Received 15 bytes on topic UME Example (sequence number 9) 'UME Message 10'
Received 15 bytes on topic UME Example (sequence number 10) 'UME Message 11'
\endverbatim

</ol>

Notice that the receiver picked up the message stream right where it had
left off - after message 3.
The first few messages (which the source had sent while the receiver was
down) appear to come in much faster than the source's normal rate of one
per second.
That's because they are being served to the receiver from the Store.
The remaining messages continue to come in at the normal one-per-second
rate because they're being received from the source's live message stream.
This is durable subscription at work.

\m4_s1 singlesourcefailsandrecovers Single Source Fails and Recovers

Perform the following procedure with the Store running to see what happens
when a source fails and recovers.

<ol>
<li>Start the Receiver.
\verbatim
$ ume-example-rcv-3.exe
\endverbatim

<li>Start the source.
\verbatim
$ ume-example-src-3.exe
\endverbatim
Let it run for a few seconds so the receiver gets a few messages.

<li>Stop the Source (Ctrl/C).

<li>Restart the Source and let it run to completion.
\verbatim
$ ume-example-rcv-3.exe
\endverbatim
</ol>

<b>Source</b>

You should see output similar to the following on the second run of the source:

\verbatim
read in saved RegID info from "UME-example-src-RegID" - 127.0.0.1:14567:2118965523
will start with message number 5
removing saved RegID file "UME-example-src-RegID"
\endverbatim

<b>Receiver</b>

The receiver's output looks like the following:

\verbatim
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][2118965523] Requesting RegID: 0
saving RegID info to "UME-example-rcv-RegID" - 127.0.0.1:14567:2118965523:2118965524
Received 15 bytes on topic UME Example (sequence number 0) 'UME Message 01'
Received 15 bytes on topic UME Example (sequence number 1) 'UME Message 02'
Received 15 bytes on topic UME Example (sequence number 2) 'UME Message 03'
Received 15 bytes on topic UME Example (sequence number 3) 'UME Message 04'
UME Store 0: 127.0.0.1:14567 [TCP:169.254.97.160:14371][2118965523] Requesting RegID: 2118965524
saving RegID info to "UME-example-rcv-RegID" - 127.0.0.1:14567:2118965523:2118965524
Received 15 bytes on topic UME Example (sequence number 4) 'UME Message 05'
Received 15 bytes on topic UME Example (sequence number 5) 'UME Message 06'
Received 15 bytes on topic UME Example (sequence number 6) 'UME Message 07'
Received 15 bytes on topic UME Example (sequence number 7) 'UME Message 08'
...
\endverbatim

When the source was restarted, it read in its previously saved RegID and
requested the same ID when registering with the Store.
The Store informed the source that it had left off at sequence number 3
(UME Message 04), and the next sequence number it should send is 4 (UME
Message 05).
Bringing the source back up also caused the receiver to re-register with
the Store.
Receivers can only find out about Stores from sources they are listening to.
Once the receiver re-registered with the Store, it continued receiving
messages from the source where it had left off.

\m4_s1 singlestorefails Single Store Fails

Perform the following procedure with the Store running to see what happens
when the Store itself fails.

<ol>
<li>Start the Receiver.
\verbatim
$ ume-example-rcv-3.exe
\endverbatim

<li>Start the source.
\verbatim
$ ume-example-src-3.exe
\endverbatim
Let it run for a few seconds so the receiver gets a few messages.

<li>Stop the Store (Ctrl/C).
</ol>

Notice that with this simple example program, the source simply prints
the following and exits.

\verbatim
saving RegID info to "UME-example-src-RegID" - 127.0.0.1:14567:4095035673
Store unresponsive: store 0 [127.0.0.1:14567] unresponsive
Store unresponsive: store 0 [127.0.0.1:14567] unresponsive - no registration response.
line 318: not currently registered with enough UMP stores
\endverbatim

When a source application tries to send a message without being registered
with a Store, the send call returns an error.
Messages sent while not registered with a Store cannot be persisted.
See \ref designingpersistentstores for information about using multiple Stores.

Your source application(s) should assume an unresponsive Store is a
temporary problem and wait before sending the message again.
See `umesrc.c`, `umesrc.java`, or `umesrc.cs` for examples of this behavior.

\anchor designingpersistenceapplications
\m4_pg registrationidentifiers Registration Identifiers

As mentioned in \ref registrationidentifierconcept and
\ref addingfaultrecoverywithregistrationids, Stores use RegIDs to
identify sources and receivers. UM offers three main methods for
managing RegIDs:

<ul>
<li><b>Recommended</b>: use Session IDs to enable the Store to both
assign and manage RegIDs.
See \ref managingregidswithsessionids.
Note: while the use of Session IDs is recommended, an understanding of the
underlying registration IDs is often helpful to understanding persistence.

<li>Your applications assign static RegIDs and ensure that the same RegID
is not assigned to multiple sources and/or receivers.
See \ref usestaticregids.

<li>You can allow Stores to assign RegIDs and then save the assigned
RegIDs for subsequent reuse.
See \ref saveassignedregids.
</ul>

Your applications can manage RegIDs for the lifetime of a source or
receiver as long as multiple applications do not reuse RegIDs simultaneously
on the same Store.
RegIDs only need to be unique on the same Store and may be reused between
Stores as desired.
You can use a static mapping of RegIDs to applications or use some simple
service to assign them.

\m4_s1 usestaticregids Use Static RegIDs

For very small deployments, the simplest method uses static RegIDs for
individual applications.
This method requires every persistent source connecting to a given Store
have a unique RegID from every other persistent source attaching to the
same Store.
This includes publishing applications that have multiple persistent topics;
each topic's source object must have a unique RegID.
(The use of session IDs greatly simplifies the management of these RegIDs.)

The following source code examples assign a static RegID to a source by
adding the RegID, 1000, to the \ref umestoresource LBM configuration option.
See also <a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-2.c">ume-example-src-2.c</a>

<b>C API</b>

\code
lbm_src_topic_attr_t * sattr;

if (lbm_src_topic_attr_create_from_xml(&sattr, "MyCtx", src_topic_name) == LBM_FAILURE) {
  fprintf(stderr, "lbm_src_topic_attr_create_from_xml: %s\n", lbm_errmsg());
  exit(1);
}
if (lbm_src_topic_attr_str_setopt(sattr, "ume_store", "127.0.0.1:14567:1000")
== LBM_FAILURE) {
  fprintf(stderr, "lbm_src_topic_attr_str_setopt: %s\n", lbm_errmsg());
  exit(1);
}
\endcode

<b>JAVA API</b>

\code
LBMSourceAttributes sattr = null;
try {
  sattr = new LBMSourceAttributes();
  sattr.setValue("ume_store", "127.0.0.1:14567:1000");
}
catch (LBMException ex) {
  System.err.println("Error creating source attribute: " + ex.toString());
  System.exit(1);
}
\endcode

<b>.NET API</b>

\code
LBMSourceAttributes sattr = null;
try {
  sattr = new LBMSourceAttributes();
  sattr.setValue("ume_store", "127.0.0.1:14567:1000");
}
catch (LBMException ex) {
  System.Console.Error.WriteLine ("Error creating source attribute: " + ex.toString());
  System.Environment.Exit(1);
}
\endcode

\m4_s1 saveassignedregids Save Assigned RegIDs

When using RegIDs, your application can request that the Store assign it a
new and unique RegID when it registers for the first time.
That RegID is made available to the application, which can then save it to
local storage.
Thus, the next time the application starts (or restarts) and wants to use
the same registration, it reads the value written to local storage.
This method of managing RegIDs is not common. For example, what if the
application needs to be restarted on a different server due to hardware
failure?
If it cannot re-register with its earlier RegID, it will not be able to
recover only those messages it had not yet acknowledged.
(The use of Session IDs simplifies this greatly by essentially saving the
registration IDs for you on the Store itself.)

The following minimal source code example saves the RegID assigned to a
source to a file.
See also <a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-3.c">ume-example-src-3.c</a>

<b>C API</b>

\code
/* Callback invoked by UM for source events. */
int app_src_callback(lbm_src_t *src, int event, void *eventd, void *clientd)
{
  ...
  switch (event) {
  ...
  case LBM_SRC_EVENT_UME_REGISTRATION_SUCCESS_EX:
    /* Get the registration information. */
    lbm_src_event_ume_registration_ex_t *reginfo = (lbm_src_event_ume_registration_ex_t *)eventd;

    /* Might want to do the following conditionally only if we are requesting a new RegID. */
   	FILE *fp = fopen("UME-example-src-RegID", "w");  /* Error checking omitted for clarity. */
   	fprintf(fp, "%s:%u", reginfo->store, reginfo->registration_id);
   	fclose(fp);
  ...
  }  /* switch */
  ...
}  /* app_src_callback */

...

err = lbm_src_create(&src, ctx, topic, app_src_callback, ...);  /* Error checking omitted. */
\endcode

\m4_s1 managingregidswithsessionids Managing RegIDs with Session IDs

The RegIDs used by Stores to identify sources and receivers must be unique.
Rather than maintaining RegIDs (either statically or dynamically),
applications can use a Session ID, which is simply a 64-bit value that
uniquely identifies any set of sources with unique topics and receivers
with unique topics.
A single Session ID allows Stores to correctly identify all the sources and receivers for a particular application.

In practice, a Session ID is often thought of as an application identifier,
although it is more accurately thought of as a context identifier.
(For applications that only have a single context with persistent
sources and/or receivers, the two are effectively the same.)
However, be aware that many application systems run multiple instances of a
given program, perhaps for horizontal scaling. Each instance needs its own
Session ID.

It is also possible for a single context to host multiple Session IDs,
although this is rarely done.
The LBM configuration options \ref umesessionidsource and
\ref umesessionidreceiver can be used to arrange individual source and/or
receiver objects into registration groupings.
However, it is more common to use the option \ref umesessionidcontext to
group all sources and receivers created within a context into a single
session ID.
(If both a context and a source or receiver option is specified, the source
or receiver option will override the context option.)

<b>How Stores Associate Session IDs and RegIDs</b>

Session IDs do not replace the use of RegIDs by UM but rather simplify
RegID management.
Using Session IDs equates to your application specifying a 0 (zero) RegID
for all sources and receivers.
However, instead of your application persisting the RegID assigned by the
Store, the Store maintains the RegID for you.

When a Store receives a registration request from a source or receiver with
a particular Session ID, it checks to see if it already has a source or
receiver for that topic/Session ID.
If it does, then it responds with that source's or receiver's RegID.

If it does not find a source or receiver for that topic/Session ID pair,
the Store:

<ol>
<li>Assigns a new RegID.
<li>Associates the topic/Session ID with the new RegID.
<li>Responds to the source or receiver with the new RegID.
</ol>

The source can then advertise with the RegID supplied by the Store.
Receivers include the source's RegID in their registration request.

All of the above steps happen within UM itself without any intervention
by the application.
However, the application does have access to the underlying registration
ID, if it desires it.

\m4_pg designingpersistentsources Designing Persistent Sources

The major concerns of sources revolve around RegID management and message
retention.

\m4_s1 neworreregistration New or Re-Registration

Any source needs to know at start-up if it is a new registration or a
re-registration.
The answer determines how a source registers with the Store.
The UM library can not answer this question.
Therefore, it is essential that the developer consider what identifies the
lifetime of a source and how a source determines the appropriate value to
use as the RegID when it is ready to register.
RegIDs are per source per topic per Store, thus a single RegID per Store is
needed.

The following source code examples look for an existing RegID from a file
and uses a new RegID assigned from the Store if it finds no existing RegID.
See also <a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-src-3.c">ume-example-src-3.c</a>

<b>C API</b>

\code
    err = lbm_context_create(&ctx, NULL, NULL, NULL);
    if (err) {printf("line %d: %s\n", __LINE__, lbm_errmsg()); exit(1);}

	srcinfo.message_num = 1;
	srcinfo.existing_regid = 0;

	err = read_src_regid_from_file(SRC_REGID_SAVE_FILENAME, store_info, sizeof(store_info));
	if (!err) { srcinfo.existing_regid = 1; }

        err = lbm_src_topic_attr_create_from_xml(&attr, "MyCtx", src_topic_name);
        if (err) {printf("line %d: %s\n", __LINE__, lbm_errmsg()); exit(1);}

        err = lbm_src_topic_attr_str_setopt(attr, "ume_store", store_info);
        if (err) {printf("line %d: %s\n", __LINE__, lbm_errmsg()); exit(1);}
\endcode

The use of Session IDs allows UM, as opposed to your application,
to accomplish the same RegID management.
See \ref managingregidswithsessionids Managing RegIDs with Session IDs.

\m4_s1 sourcesmustbeabletoresumesending Sources Must Be Able to Resume Sending

A source sends messages unless UM prevents it, in which case,
the send function returns an error.
A source may lose the ability to send messages temporarily if the Store(s)
in use become unresponsive, e.g. the Store(s) die or become disconnected
from the source.
Once the Store(s) are responsive again, sending can continue.
Thus source applications need to take into account that sending may fail
temporarily under specific failure cases and be able to resume sending when
the failure is removed.

The following source code examples demonstrate how a failed send function
can sleep for a second and try again:

<b>C API</b>

\code
while (lbm_src_send(src, message, len, 0) == LBM_FAILURE) {
    If (lbm_errnum() == LBM_EUMENOREG) {
        printf("Send unsuccessful. Waiting...\n");
        sleep(1);
        continue;
    }
    fprintf(stderr, "lbm_src_send: %s\n", lbm_errmsg());
    exit(1);
}
\endcode

<b>Java API</b>

\code
for (;;) {
    try {
        src.send(message, len, 0);
    }
    catch (UMENoRegException ex) {
        System.out.println("Send unsuccessful. Waiting...");
        try {
            Thread.sleep(1000);
        }
        catch (InterruptedException e) { }
        continue;
    }
    catch (LBMException ex) {
        System.err.println("Error sending message: " + ex.toString());
        System.exit(1);
    }
    break;
}
\endcode

<b>.NET API</b>

\code
for (;;) {
    try {
        src.send(message, len, 0);
    }
    catch (UMENoRegException ex) {
        System.Console.Out.WriteLine("Send unsuccessful. Waiting...");
        System.Threading.Thread.Sleep(1000);
        continue;
    }
    catch (LBMException ex) {
        System.Console.Out.WriteLine ("Error sending message: " + ex.toString());
        System.exit(1);
    }
    break;
}
\endcode

\m4_s1 sourcemessageretentionandrelease Source Message Retention and Release

UM allows streaming of messages from a source without regard to message
stability at a Store, which is one reason for UM's performance advantage
over other persistent messaging systems.
Sources retain all messages until notified by the active Store(s) that they
are stable.
This provides a method for Stores to be brought up to date when restarted
or started anew.

When messages are considered stable at the Store, the source can release
them which frees up source retention memory for new messages.
Generally, the source releases older stable messages first.
To release the oldest retained message, all the following conditions
must be met:

<ul>
<li>Message must meet stability requirements of the source, which can
range from a single stability notice from the active Store to stability
notices from a group of Stores (See
\ref sourcesusingquorumconsensusstoreconfiguration).

<li>Message must have been confirmed as delivered by a configured number
of receivers (\ref umeretentionuniqueconfirmationssource).

<li>The aggregate amount of buffered messages exceeds
\ref retransmitretentionsizethresholdsource bytes in payload and headers.
</ul>

Some things to note:

<ul>
<li>If \ref retransmitretentionsizethresholdsource is not met,
no messages will be released regardless of stability.

<li>If the source turns off \ref umemessagestabilitynotificationsource,
\ref umeretentionuniqueconfirmationssource is the only
way to allow the source to release messages before retention size options
come into play.

<li>With a quorum/consensus Store configuration, when a quorum of Stores
report stability for a message, remaining Stores may or may not send
additional stability acks for that message.
</ul>

\note \ref smartsources simplify matters somewhat by pre-allocating
retention buffers.
They are not dynamically allocated or deallocated during operation.
See \ref smartsourcesandpersistence for more information.

\m4_s1 forcedreclaims Forced Reclaims

If the aggregate amount of buffered messages exceeds
\ref retransmitretentionsizelimitsource bytes in payload and headers,
then UM forcibly releases the oldest retained message even if it does
not meet one or more of the conditions stated in Source Message Retention
and Release.
This condition should be avoided and Informatica suggests increasing the
\ref retransmitretentionsizelimitsource.

A second condition that produces a forced reclaim is when a message remains
unstabilized when the \ref umemessagestabilitylifetimesource expires.

Whenever UM performs a Forced Reclaim, it notifies the application in
the following ways:

<ul>
<li>The source event callback's RECLAIMED_EX event (see
\ref persistencesourceevents) includes a "FORCED" flag on the event.
(UM uses the same RECLAIMED_EX event, without the FORCED flag,
for normal reclaims.)

<li>Through the separate forced reclaim callback, if registered.
You set this separate forced reclaim callback with the
\ref umeforcereclaimfunctionsource configuration option.
</ul>

\note UM retains the separate callback for backwards compatibility
purposes and may be deprecated in future releases.
The source event FORCED flag is the recommended method of tracking
forced reclaims.

The following sample code, from \ref exampleumesrc_c,
implements the extended reclaim source event with the 'Forced' flag
set if the reclamation is a forced reclaim.

<b>C API</b>

\code
case LBM_SRC_EVENT_UME_MESSAGE_RECLAIMED_EX:
{
    lbm_src_event_ume_ack_ex_info_t *ackinfo = (lbm_src_event_ume_ack_ex_info_t *)ed;
    if (opts->verbose) {
        printf("UME message reclaimed (ex) - sequence number %x (cd %p). Flags 0x%x ",
               ackinfo->sequence_number, (char*)(ackinfo->msg_clientd) - 1, ackinfo->flags);
        if (ackinfo->flags & LBM_SRC_EVENT_UME_MESSAGE_RECLAIMED_EX_FLAG_FORCED) {
            printf("FORCED");
        }
        printf("\n");
    }
}
break;
\endcode

<b>Java API</b>

\code
case LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED_EX:
    UMESourceEventAckInfo reclaiminfo = sourceEvent.ackInfo();
    if (_verbose > 0) {
        if (reclaiminfo.clientObject() != null) {
            System.out.print("UME message reclaimed (ex) - sequence number "
                               + Long.toHexString(reclaiminfo.sequenceNumber())
                               + " (cd "
                               + Long.toHexString(((Long)reclaiminfo.clientObject()).longValue())
                               + "). Flags 0x"
                               + reclaiminfo.flags());
        } else {
            System.out.print("UME message reclaimed (ex) - sequence number "
                               + Long.toHexString(reclaiminfo.sequenceNumber())
                               + " Flags 0x"
                               + reclaiminfo.flags());
        }
        if ((reclaiminfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED_EX_FLAG_FORCED) != 0) {
            System.out.print(" FORCED");
        }
        System.out.println();
    }
    break;
\endcode

<b>.NET API</b>

\code
case LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED_EX:
    UMESourceEventAckInfo reclaiminfo = sourceEvent.ackInfo();
    if (_verbose > 0) {
        System.Console.Out.Write("UME message reclaimed (ex) - sequence number "
                                   + reclaiminfo.sequenceNumber()
                                   + " (cd "
                                   + ((uint)reclaiminfo.clientObject()).ToString("x")
                                   + "). Flags "
                                   + reclaiminfo.flags());
        if ((reclaiminfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED_EX_FLAG_FORCED) != 0) {
            System.Console.Out.Write(" FORCED");
        }
        System.Console.Out.WriteLine();
    }
    break;
\endcode

\m4_s1 sourcereleasepolicyoptions Source Retention Policy Options

Sources use a set of configuration options to release messages that,
in effect, specify the source's retention policy.
The following configuration options directly impact when the source
may release retained messages:

<ul>
<li>\ref umemessagestabilitynotificationsource
<li>\ref umeretentionuniqueconfirmationssource
<li>\ref retransmitretentionsizethresholdsource
<li>\ref retransmitretentionsizelimitsource
</ul>

\m4_s1 confirmeddelivery Confirmed Delivery

The configuration option \ref umeretentionuniqueconfirmationssource
requires a message to have a minimum number of unique confirmations
from different receivers before the message may be released.
This retains messages that have not been confirmed as being received and
processed and keeps them available to fulfill any retransmission requests.
This provides a form of receiver-pacing; the source will not be allowed
to exceed \ref persistenceflightsize beyond receiving applications.

For example, a topic might have 2 receivers which are considered essential
to keep up, and which should therefore contribute to flight size calculation.
There might be any number of less-essential receivers which can be allowed
to lag behind.
In this case, \ref umeretentionuniqueconfirmationssource would be set to 2,
and the non-essential receivers would set
\ref umeallowconfirmeddeliveryreceiver to 0.

\note \ref smartsources do not support delivery confirmation.

The following code samples show how to require a message to have 10
unique receiver confirmations

<b>C API</b>

\code
lbm_src_topic_attr_t * sattr;

if (lbm_src_topic_attr_create_from_xml(&sattr, "MyCtx", src_topic_name) == LBM_FAILURE) {
    fprintf(stderr, "lbm_src_topic_attr_create_from_xml: %s\n", lbm_errmsg());
    exit(1);
}
if (lbm_src_topic_attr_str_setopt(sattr, "ume_retention_unique_confirmations",
                                  "10") == LBM_FAILURE) {
    fprintf(stderr, "lbm_src_topic_attr_str_setopt: %s\n", lbm_errmsg());
    exit(1);
}
\endcode

<b>JAVA API</b>

\code
LBMSourceAttributes sattr = null;
try {
    sattr = new LBMSourceAttributes();
    sattr.setValue("ume_retention_unique_confirmations", "10");
}
catch (LBMException ex) {
    System.err.println("Error creating source attribute: " + ex.toString());
    System.exit(1);
}
\endcode

<b>.NET API</b>

\code
LBMSourceAttributes sattr = null;
try {
    sattr = new LBMSourceAttributes();
    sattr.setValue("ume_retention_unique_confirmations", "10");
}
catch (LBMException ex) {
    System.Console.Error.WriteLine ("Error creating source attribute: " + ex.toString());
    System.Environment.Exit(1);
}
\endcode

\m4_s1 sourceeventhandler Source Event Handler

The Source Event Handler is a function callback initialized at source
creation to provide source events to your application related to the
operation of the source.
The following source code examples illustrate the use of a source event
handler for registration events.
To accept other source events, additional case statements would be required,
one for each additional source event.
See also \ref persistenceevents.

<b>C API</b>

\code
int handle_src_event(lbm_src_t *src, int event, void *ed, void *cd)
{
    switch (event) {
    case LBM_SRC_EVENT_UME_REGISTRATION_ERROR:
    {
        const char *errstr = (const char *)ed;
        printf("Error registering source with UME store: %s\n", errstr);
    }
    break;

    case LBM_SRC_EVENT_UME_REGISTRATION_SUCCESS_EX:
    {
        lbm_src_event_ume_registration_ex_t *reg =
            (lbm_src_event_ume_registration_ex_t *)ed;

        printf("UME store %u: %s registration success. RegID %u. Flags %x ",
               reg->store_index, reg->store, reg->registration_id, reg->flags);
        if (reg->flags & LBM_SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD)
            printf("OLD[SQN %x] ", reg->sequence_number);
        if (reg->flags & LBM_SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_NOACKS)
            printf("NOACKS ");
        printf("\n");
    }
    break;

    case LBM_SRC_EVENT_UME_REGISTRATION_COMPLETE_EX:
    {
        lbm_src_event_ume_registration_complete_ex_t *reg =
            (lbm_src_event_ume__complete_ex_t *)ed;
        printf("UME registration complete. SQN %x. Flags %x ",
               reg->sequence_number, reg->flags);
        if (reg->flags & LBM_SRC_EVENT_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM)
            printf("QUORUM ");
        printf("\n");
    }
    break;

    case LBM_SRC_EVENT_UME_STORE_UNRESPONSIVE:
    {
        const char *infostr = (const char *)ed;
        printf("UME store: %s\n", infostr);
    }
    break;

    default:
        printf("Unknown source event %d\n", event);
        break;
    }
    return 0;
}
\endcode

<b>JAVA API</b>

\code
public int onSourceEvent(Object arg, LBMSourceEvent sourceEvent)
{
    switch (sourceEvent.type()) {
    case LBM.SRC_EVENT_UME_REGISTRATION_ERROR:
        System.out.println("Error registering source with UME store: "
            + sourceEvent.dataString());
        break;

    case LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX:
        UMESourceEventRegistrationSuccessInfo reg =
            sourceEvent.registrationSuccessInfo();
        System.out.print("UME store " + reg.storeIndex() + ": " + reg.store()
            + " registration success. RegID " + reg.registrationId() + ". Flags "
            + reg.flags() + " ");
        if (((reg.flags() & LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD)) != 0) {
            System.out.print("OLD[SQN " + reg.sequenceNumber() + "] ");
        }
        if (((reg.flags() & LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_NOACKS)) != 0) {
            System.out.print("NOACKS ");
        }
        System.out.println();
        break;

    case LBM.SRC_EVENT_UME_REGISTRATION_COMPLETE_EX:
        UMESourceEventRegistrationCompleteInfo regcomp =
            sourceEvent.registrationCompleteInfo();
        System.out.print("UME registration complete. SQN " + regcomp.sequenceNumber()
            + ". Flags " + regcomp.flags() + " ");
        if ((regcomp.flags() & LBM.SRC_EVENT_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM) != 0) {
            System.out.print("QUORUM ");
        }
        System.out.println();
        break;

    case LBM.SRC_EVENT_UME_STORE_UNRESPONSIVE:
        System.out.println("UME store: " + sourceEvent.dataString());
        break;
    ...
    default:
        System.out.println("Unknown source event " + sourceEvent.type());
        break;
    }
    return 0;
}
\endcode

<b>.NET API</b>

\code
public int onSourceEvent(Object arg, LBMSourceEvent sourceEvent)
{
    switch (sourceEvent.type()) {
    case LBM.SRC_EVENT_UME_REGISTRATION_ERROR:
        System.Console.Out.WriteLine("Error registering source with UME store: "
            + sourceEvent.dataString());
        break;

    case LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX:
        UMESourceEventRegistrationSuccessInfo reg = sourceEvent.registrationSuccessInfo();
        System.Console.Out.Write("UME store " + reg.storeIndex() + ": " + reg.store()
            + " registration success. RegID " + reg.registrationId() + ". Flags "
            + reg.flags() + " ");
        if (((reg.flags() & LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD)) != 0) {
            System.Console.Out.Write("OLD[SQN " + reg.sequenceNumber() + "] ");
        }
        if (((reg.flags() & LBM.SRC_EVENT_UME_REGISTRATION_SUCCESS_EX_FLAG_NOACKS)) != 0) {
            System.Console.Out.Write("NOACKS ");
        }
        System.Console.Out.WriteLine();
        break;

    case LBM.SRC_EVENT_UME_REGISTRATION_COMPLETE_EX:
        UMESourceEventRegistrationCompleteInfo regcomp =
            sourceEvent.registrationCompleteInfo();
        System.Console.Out.Write("UME registration complete. SQN " +
            regcomp.sequenceNumber() + ". Flags " + regcomp.flags() + " ");
        if ((regcomp.flags() & LBM.SRC_EVENT_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM) != 0) {
            System.Console.Out.Write("QUORUM ");
        }
        System.Console.Out.WriteLine();
        break;

    case LBM.SRC_EVENT_UME_STORE_UNRESPONSIVE:
        System.Console.Out.WriteLine("UME store: " + sourceEvent.dataString());
        break;
    ...
    default:
        System.Console.Out.WriteLine("Unknown source event " + sourceEvent.type());
        break;
    }
    return 0;
}
\endcode

\m4_s1 sourceeventhandlerstabilityconfirmationandrelease Source Event Handler - Stability, Confirmation and Release

As shown in Source Event Handler above, the Source Event Handler can be
expanded to handle more source events by adding additional case statements.
The following source code examples show case statements to handle message
stability events, delivery confirmation events and message release
(reclaim) events.
See also \ref persistenceevents.

<b>C API</b>

\code
case LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX:
/* requires that source ume_message_stability_notification option is enabled */
{
    lbm_src_event_ume_ack_ex_info_t *info = (lbm_src_event_ume_ack_ex_info_t *)ed;

    printf("UME store %u: %s message stable. SQN %x (msgno %d). Flags %x ",
        info->store_index, info->store, info->sequence_number,
        (int)info->msg_clientd - 1, info->flags);
    if (info->flags & LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTRAGROUP_STABLE)
        printf("IA "); /* Stable within Store QC group */
    if (info->flags & LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTERGROUP_STABLE)
        printf("IR "); /* Stable amongst all Stores */
    if (info->flags & LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STABLE)
        printf("STABLE ");  /* Just plain stable */
    if (info->flags & LBM_SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STORE)
        printf("STORE ");   /* Stability reported by UME Store */
    printf("\n");
}
break;

case LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX:
/* requires that source ume_confirmed_delivery_notification option is enabled */
{
    lbm_src_event_ume_ack_ex_info_t *info = (lbm_src_event_ume_ack_ex_info_t *)ed;

    printf("UME delivery confirmation. SQN %x, Receiver RegID %u (msgno %d). Flags %x ",
        info->sequence_number, info->rcv_registration_id,
        (int)info->msg_clientd - 1, info->flags);
    if (info->flags & LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UNIQUEACKS)
        printf("UNIQUEACKS "); /* Satisfied number of unique ACKs requirement */
    if (info->flags & LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UREGID)
        printf("UREGID "); /* Confirmation contains receiver application registration ID */
    if (info->flags & LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_OOD)
        printf("OOD "); /* Confirmation received from arrival order receiver */
    if (info->flags & LBM_SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_EXACK)
        printf("EXACK "); /* Confirmation explicitly sent by receiver */
    printf("\n");
}
break;

case LBM_SRC_EVENT_UME_MESSAGE_RECLAIMED:
/* requires that source ume_confirmed_delivery_notification or ume_message_stability_notification
attributes are enabled */
{
    lbm_src_event_ume_ack_info_t *ackinfo = (lbm_src_event_ume_ack_info_t *)ed;

    printf("UME message released - sequence number %x (msgno %d)\n",
        ackinfo->sequence_number, (int)ackinfo->msg_clientd - 1);
}
break;
\endcode

<b>JAVA API</b>

\code
case LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX:
    // requires that source ume_message_stability_notification option is enabled
    UMESourceEventAckInfo staInfo = sourceEvent.ackInfo();
    System.out.print("UME store " + staInfo.storeIndex() + ": "
                    + staInfo.store() + " message stable. SQN " + staInfo.sequenceNumber()
                    + " (msgno " + staInfo.clientObject() + "). Flags "
                    + staInfo.flags() + " ");
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTRAGROUP_STABLE) != 0) {
        System.out.print("IA "); // Stable within Store QC group
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTERGROUP_STABLE) != 0) {
        System.out.print("IR ");  // Stable amongst all Stores
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STABLE) != 0) {
        System.out.print("STABLE ");  // Just plain stable
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STORE) != 0) {
        System.out.print("STORE ");   // Stability reported by UME Store
    }
    System.out.println();
    break;

case LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX:
    // requires that source ume_confirmed_delivery_notification option is enabled
    UMESourceEventAckInfo cdelvinfo = sourceEvent.ackInfo();
    System.out.print("UME delivery confirmation. SQN " + cdelvinfo.sequenceNumber()
                    + ", RcvRegID " + cdelvinfo.receiverRegistrationId() + " (msgno "
                    + cdelvinfo.clientObject() + "). Flags " + cdelvinfo.flags() + " ");
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UNIQUEACKS) != 0) {
        System.out.print("UNIQUEACKS "); // Satisfied number of unique ACKs requirement
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UREGID) != 0) {
        System.out.print("UREGID ");    // Confirmation contains receiver application reg ID
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_OOD) != 0) {
        System.out.print("OOD ");      // Confirmation received from arrival order receiver
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_EXACK) != 0) {
        System.out.print("EXACK ");    // Confirmation explicitly sent by receiver
    }
    System.out.println();
    break;

case LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED:
    // requires that source ume_confirmed_delivery_notification or
    // ume_message_stability_notification attributes are enabled
    System.out.println("UME message released - sequence number "
                + Long.toHexString(sourceEvent.sequenceNumber())
                + " (msgno "
                + Long.toHexString(((Integer)sourceEvent.clientObject()).longValue())
                + ")");
    break;
\endcode

<b>.NET API</b>

\code
case LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX:
    // requires that source ume_message_stability_notification option is enabled
    UMESourceEventAckInfo staInfo = sourceEvent.ackInfo();
    System.Console.Out.Write("UME store " + staInfo.storeIndex() + ": "
                        + staInfo.store() + " message stable. SQN " + staInfo.sequenceNumber()
                        + " (msgno " + ((int)staInfo.clientObject()).ToString("x") + ").
                        Flags " + staInfo.flags() + " ");
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTRAGROUP_STABLE) != 0) {
        System.Console.Out.Write("IA ");  // Stable within Store QC group
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_INTERGROUP_STABLE) != 0) {
        System.Console.Out.Write("IR ");  // Stable amongst all Stores
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STABLE) != 0) {
        System.Console.Out.Write("STABLE ");  // Just plain stable
    }
    if ((staInfo.flags() & LBM.SRC_EVENT_UME_MESSAGE_STABLE_EX_FLAG_STORE) != 0) {
        System.Console.Out.Write("STORE ");  // Stability reported by UME Store
    }
    System.Console.Out.WriteLine();
    break;

case LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX:
    // requires that source ume_confirmed_delivery_notification option is enabled

    UMESourceEventAckInfo cdelvinfo = sourceEvent.ackInfo();

    System.Console.Out.Write("UME delivery confirmation. SQN " +
    cdelvinfo.sequenceNumber()
                        + ", RcvRegID " + cdelvinfo.receiverRegistrationId() + " (msgno "
                        + ((int)cdelvinfo.clientObject()).ToString("x") + "). Flags " +
                        cdelvinfo.flags() + " ");
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UNIQUEACKS) != 0) {
        System.Console.Out.Write("UNIQUEACKS ");  // Satisfied number of unique ACKs requirement
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_UREGID) != 0) {
        System.Console.Out.Write("UREGID ");  // Confirmation contains receiver application reg ID
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_OOD) != 0) {
        System.Console.Out.Write("OOD ");  // Confirmation received from arrival order receiver
    }
    if ((cdelvinfo.flags() & LBM.SRC_EVENT_UME_DELIVERY_CONFIRMATION_EX_FLAG_EXACK) != 0) {
        System.Console.Out.Write("EXACK ");  // Confirmation explicitly sent by receiver
    }
    System.Console.Out.WriteLine();
    break;

case LBM.SRC_EVENT_UME_MESSAGE_RECLAIMED:
    // requires that source ume_confirmed_delivery_notification or
    // ume_message_stability_notification attributes are enabled

    System.Console.Out.WriteLine("UME message released - sequence number "
                               + sourceEvent.sequenceNumber().ToString("x")
                               + " (msgno "
                               + ((int)sourceEvent.clientObject()).ToString("x")
                               + ")");
    break;
\endcode

\m4_s1 mappingyourmessagenumberstosequencenumbers Mapping Your Message Numbers to Sequence Numbers

Some application developers want their publishing applications to know the
UM-assigned topic-level sequence numbers assigned to outgoing messages.

The C API functions lbm_src_send_ex() and lbm_src_sendv_ex() allow you to expand the number
of source events that will be delivered to your sending application,
including a source event that informs your sender of the topic-level
sequence numbers assigned to each message you send.
In the case of a large message that requires
\ref messagefragmentationandreassembly "fragmentation",
the callback will tell you the starting and ending topic-level
sequence numbers assigned to it.

The following two source code examples show how to:

<ul>
<li>Enable message sequence number information.
<li>Handle sequence number source events to determine the application
message number in the Source Event Handler.
</ul>

<b>C API - Enable Message Information</b>

\code
lbm_src_send_ex_info_t exinfo;
struct my_sqn_nums_s{
  unsigned int first_sqn;
  unsigned int last_sqn;
};
typedef struct my_sqn_nums_s my_sqn_nums_t;
my_sqn_nums_t msg_sqn_nums;

...

/* Enable message sequence number info to be returned */
exinfo.flags = LBM_SRC_SEND_EX_FLAG_UME_CLIENTD | LBM_SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO;
exinfo.ume_msg_clientd = &msg_sqn_nums;
if (lbm_src_send_ex(src, message, msglen, 0, &exinfo) == LBM_FAILURE) {
    ... /* handle error. */
}
/* Before lbm_src_send_ex returns, the source event will be delivered on the callers thread,
 * setting up msg_sqn_nums. */
printf("first_sqn=%u, last_sqn=%u\n", msg_sqn_nums.first_sqn, msg_sqn_nums.last_sqn);
\endcode

<b>C API - Source Number Event Handler</b>

\code
int handle_src_event(lbm_src_t *src, int event, void *ed, void *cd)
{
    switch (event) {
        case LBM_SRC_EVENT_SEQUENCE_NUMBER_INFO:
        {
            lbm_src_event_sequence_number_info_t *info =
                (lbm_src_event_sequence_number_info_t *)ed;
            my_sqn_nums_t *sqn_nums = (my_sqn_nums_t *)info->msg_clientd;

            sqn_nums->first_sqn = info->first_sequence_number;
            sqn_nums->last_sqn = info->last_sequence_number;
        }
        break;
        ...
    }
    return 0;
}
\endcode

<b>JAVA API - Enable Message Information</b>

\code
LBMSourceSendExInfo exinfo = new LBMSourceSendExInfo();
exinfo.setClientObject(new Integer(msgno));  // msgno set to application message number
exinfo.setFlags(LBM.SRC_SEND_EX_FLAG_SEQUENCE_NUMBER_INFO);
// Enable message sequence number info to be returned
try {
    src.send(message, msglen, 0, exinfo);
}
catch(UMENoRegException ex) {
    // Handle error
}
// Access start/end sqns via instance variables.
\endcode

<b>JAVA API - Sequence Number Event Handler</b>

\code
public int onSourceEvent(Object arg, LBMSourceEvent sourceEvent)
{
    switch (sourceEvent.type()) {
        case LBM.SRC_EVENT_SEQUENCE_NUMBER_INFO:
        {
            LBMSourceEventSequenceNumberInfo info = sourceEvent.sequenceNumberInfo();
            // Set instance variables to info.firstSequenceNumber() and info.lastSequenceNumber().
            break;
        }
    ...
    }
    return 0;
}
\endcode

<b>.NET API - Enable Message Information</b>

.NET code is the same as Java (above).

\m4_s1 receiverlivenessdetection Receiver Liveness Detection

As an extension to Confirmed Delivery, you can set receivers to send a
keepalive to a source during a measured absence of delivery confirmations
(due to traffic lapse).
In the event that neither message reaches the source within a designated
interval, or if the delivery confirmation TCP connection breaks down,
the receiver is assumed to have "died".
UM then notifies the publishing application via context event callback.
This lets the publisher assign a new subscriber.

To use this feature, set these five configuration options:
<ul>
<li>\ref umesourcelivenesstimeoutcontext
<li>\ref umereceiverlivenessintervalcontext
<li>\ref umeconfirmeddeliverynotificationsource
<li>\ref umeuserreceiverregistrationidcontext
<li>\ref umesessionidcontext, \ref umesessionidsource, \ref umesessionidreceiver
</ul>

\note \ref smartsources do not support liveness detection.

This specialized feature is not recommended for general use.
If you are considering it, please note the following caveats:
<ul>
<li>Do not use in conjunction with a \ref umrouter.
<li>There is a variety of potential network occurrences that can break
or reset the TCP connection and falsely indicate the death of a receiver.
<li>In cases where a receiver object is deleted while its context is not,
the publisher may still falsely assume the receiver to be alive.
</ul>

Other false receiver-alive assumptions could be caused by the following:
<ul>
<li>TCP connections can enter a half-open or otherwise corrupted state.
<li>Failed TCP connections sometimes do not fully close, or experience
objectionable delays before fully closing.
<li>A switch or router failure along the path does not affect the TCP
connection state.
</ul>

\m4_pg designingpersistentreceivers Designing Persistent Receivers

Receivers are predominantly interested in RegID management and recovery
management.

\m4_s1 receiverregidmanagement Receiver RegID Management

RegIDs are slightly more involved for receivers than for sources.
Since RegIDs are per source per topic per Store and a topic may have several
sources, a receiver may have to manage several RegIDs per Store in use.
Fortunately, receivers in UM can leverage the RegID of the source with the
use of a callback as discussed in \ref addingfaultrecoverywithregistrationids
and shown in
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../example/ume-example-rcv-2.c">ume-example-rcv-2.c</a>.
Your application can determine the correct RegID to use and return it to UM.
You can also use Session IDs to enable UM to manage receiver RegIDs.

Much like sources, receivers typically have a lifetime based on an amount
of work, perhaps an infinite amount.
And just like sources, it may be helpful to consider that a RegID is
"assigned" at the start of that work and is out of use at the end.
In between, the RegID is in use by the instance of the receiver application.
However, the nature of RegIDs being per source means that the expected
lifetime of a source should play a role in how RegIDs on the receiver are
managed.
Thus, it may be helpful for the application developer to consider the source
application lifetime when deciding how best to handle RegIDs on the receiver.

<b>Receiver Message and Event Handler</b>

The Receiver Message and Event Handler is an application callback, defined at
receiver initialization, to deliver received messages to your application.
The following source code examples illustrate the use of a receiver message
and event handler for registration messages.
To accept other receiver events, additional case statements would be required,
one for each additional event. See also \ref persistenceevents

<b>C API</b>

\code
int rcv_handle_msg(lbm_rcv_t *rcv, lbm_msg_t *msg, void *clientd)
{
    switch (msg->type) {
    case LBM_MSG_UME_REGISTRATION_ERROR:
        printf("[%s][%s] UME registration error: %s\n", msg->topic_name,
                msg->source, msg->data);
        exit(0);
        break;

    case LBM_MSG_UME_REGISTRATION_SUCCESS:
        {
            lbm_msg_ume_registration_t *reg =
                (lbm_msg_ume_registration_t *)(msg->data);

            printf("[%s][%s] UME registration successful. "
                "SrcRegID %u RcvRegID %u\n",
                msg->topic_name, msg->source,
                reg->src_registration_id, reg->rcv_registration_id);
        }
        break;

    case LBM_MSG_UME_REGISTRATION_SUCCESS_EX:
        {
            lbm_msg_ume_registration_ex_t *reg =
                (lbm_msg_ume_registration_ex_t *)(msg->data);

            printf("[%s][%s] store %u: %s UME registration successful. "
                "SrcRegID %u RcvRegID %u. Flags %x ",
                msg->topic_name, msg->source, reg->store_index, reg->store,
                reg->src_registration_id, reg->rcv_registration_id, reg->flags);
            if (reg->flags & LBM_MSG_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD)
                printf("OLD[SQN %x] ", reg->sequence_number);
            printf("\n");
        }
        break;

    case LBM_MSG_UME_REGISTRATION_COMPLETE_EX:
        {
            lbm_msg_ume_registration_complete_ex_t *reg =
                (lbm_msg_ume_registration_complete_ex_t *)(msg->data);

            printf("[%s][%s] UME registration complete. SQN %x. Flags %x ",
                msg->topic_name, msg->source, reg->sequence_number, reg->flags);
            if (reg->flags & LBM_MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM)
                printf("QUORUM ");
            if (reg->flags & LBM_MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_RXREQMAX)
                printf("RXREQMAX ");
            printf("\n");
        }
        break;

    case LBM_MSG_UME_REGISTRATION_CHANGE:
        printf("[%s][%s] UME registration change: %s\n", msg->topic_name,
            msg->source, msg->data);
        break;
    ...

    default:
        printf("Unknown lbm_msg_t type %x [%s][%s]\n", msg->type,
            msg->topic_name, msg->source);
        break;
    }
    return 0;
}
\endcode

<b>JAVA API</b>

\code
public int onReceive(Object cbArg, LBMMessage msg)
{
    case LBM.MSG_UME_REGISTRATION_ERROR:
        System.out.println("[" + msg.topicName() + "][" + msg.source()
                    + "] UME registration error: " + msg.dataString());
        break;

    case LBM.MSG_UME_REGISTRATION_SUCCESS_EX:
        UMERegistrationSuccessInfo reg = msg.registrationSuccessInfo();
        System.out.print("[" + msg.topicName() + "][" + msg.source()
                    + "] store " + reg.storeIndex() + ": "
                    + reg.store() + " UME registration successful. SrcRegID "
                    + reg.sourceRegistrationId() + " RcvRegID "
                    + reg.receiverRegistrationId()
                    + ". Flags " + reg.flags() + " ");
        if ((reg.flags() & LBM.MSG_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD) != 0) {
            System.out.print("OLD[SQN " + reg.sequenceNumber() + "] ");
        }
        System.out.println();
        break;

    case LBM.MSG_UME_REGISTRATION_COMPLETE_EX:
        UMERegistrationCompleteInfo regcomplete = msg.registrationCompleteInfo();
        System.out.print("[" + msg.topicName() + "][" + msg.source()
            + "] UME registration complete. SQN " + regcomplete.sequenceNumber()
            + ". Flags " + regcomplete.flags() + " ");
        if ((regcomplete.flags() & LBM.MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM) != 0) {
            System.out.print("QUORUM ");
        }
        if ((regcomplete.flags() & LBM.MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_RXREQMAX) != 0) {
            System.out.print("RXREQMAX ");
        }
        System.out.println();
        break;

    case LBM.MSG_UME_REGISTRATION_CHANGE:
        System.out.println("[" + msg.topicName() + "][" + msg.source()
                    + "] UME registration change: " + msg.dataString());
        break;
    ...

    default:
        System.err.println("Unknown lbm_msg_t type " + msg.type() + " ["
                    + msg.topicName() + "][" + msg.source() + "]");
        break;
    }
    return 0;
}
\endcode

<b>.NET API</b>

\code
public int onReceive(Object cbArg, LBMMessage msg)
{
    case LBM.MSG_UME_REGISTRATION_ERROR:
        System. Console.Out.WriteLine("[" + msg.topicName() + "]["
            + msg.source() + "] UME registration error: " + msg.dataString());
        break;

    case LBM.MSG_UME_REGISTRATION_SUCCESS_EX:
        UMERegistrationSuccessInfo reg = msg.registrationSuccessInfo();
        System.Console.Out.Write("[" + msg.topicName() + "][" + msg.source()
                    + "] store " + reg.storeIndex() + ": "
                    + reg.store() + " UME registration successful. SrcRegID "
                    + reg.sourceRegistrationId() + " RcvRegID "
                    + reg.receiverRegistrationId()
                    + ". Flags " + reg.flags() + " ");
        if ((reg.flags() & LBM.MSG_UME_REGISTRATION_SUCCESS_EX_FLAG_OLD) != 0) {
            System.Console.Out.Write ("OLD[SQN " + reg.sequenceNumber() + "] ");
        }
        System.Console.Out.WriteLine();
        break;

    case LBM.MSG_UME_REGISTRATION_COMPLETE_EX:
        UMERegistrationCompleteInfo regcomplete = msg.registrationCompleteInfo();
        System.Console.Out.Write("[" + msg.topicName() + "][" + msg.source()
                    + "] UME registration complete. SQN "
                    + regcomplete.sequenceNumber()
                    + ". Flags " + regcomplete.flags() + " ");
        if ((regcomplete.flags() & LBM.MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_QUORUM) != 0) {
            System.Console.Out.Write("QUORUM ");
        }
        if ((regcomplete.flags() & LBM.MSG_UME_REGISTRATION_COMPLETE_EX_FLAG_RXREQMAX) != 0) {
            System.Console.Out.Write("RXREQMAX ");
        }
        System.Console.Out.WriteLine();
        break;

    case LBM.MSG_UME_REGISTRATION_CHANGE:
        System.Console.Out.WriteLine("[" + msg.topicName() + "][" + msg.source()
                    + "] UME registration change: " + msg.dataString());
        break;
    ...

    default:
        System.Console.Out.WriteLine("Unknown lbm_msg_t type " + msg.type()
                    + " [" + msg.topicName() + "][" + msg.source() + "]");
        break;
    }
    return 0;
}
\endcode

\m4_s1 recoverymanagement Recovery Management

Recovery management for failed and restarted receivers is fairly simple.
UM requests any missed messages from the Store(s) and delivers
them to the restarted receiver.
However, your application can override that default behavior either by
configuring a \ref retransmitrequestmaximumreceiver value, or by
configuring a \ref umerecoverysequencenumberinfofunctionreceiver application
callback, or both.

For example, let's say a source sends 7 messages with sequence numbers 0-6
which are stabilized at the Store.
A C-based receiver, configured with \ref retransmitrequestmaximumreceiver set
to 2, and an application callback
\ref umerecoverysequencenumberinfofunctionreceiver, consumes (and
acknowledges) message 0, goes down, then restarts right after message 6.

During receiver registration, the \ref lbm_ume_rcv_recovery_info_ex_func_t
application callback is called with the following values in the passed-in
structure \ref lbm_ume_rcv_recovery_info_ex_func_info_t&nbsp;*info:

\code
info->high_sequence_number == 6
info->low_rxreq_max_sequence_number == 4
info->low_sequence_number == 1
\endcode

Where:
<ul>
<li>\ref lbm_ume_rcv_recovery_info_ex_func_info_t::high_sequence_number -
the most recent message sent by the source,

<li>\ref lbm_ume_rcv_recovery_info_ex_func_info_t::low_rxreq_max_sequence_number -
high_sequence_number (above) minus the number configured for
\ref retransmitrequestmaximumreceiver (2 in this example), and

<li>\ref lbm_ume_rcv_recovery_info_ex_func_info_t::low_sequence_number -
the first sequence number missed by the receiver after it went down.
</ul>

Normally, UM would start delivering messages at 1, but
\ref retransmitrequestmaximumreceiver is set to 2, which overrides UM's
normal behavior.
So in this example, the first message delivered will be number 4.

Finally, the application can, at run-time, further override the
starting sequence number.
The callback function can modify the contents of the passed-in structure
\ref lbm_ume_rcv_recovery_info_ex_func_info_t&nbsp;*info; specifically it can
update the \ref lbm_ume_rcv_recovery_info_ex_func_info_t::low_sequence_number
field.
When the callback returns, UM examines that field to see if it was
modified by the callback.
If so, UM overrides the effect of \ref retransmitrequestmaximumreceiver
and starts at the requested sequence number.

Notice that this design does not allow the callback to override the
effect of \ref retransmitrequestmaximumreceiver by setting the
\ref lbm_ume_rcv_recovery_info_ex_func_info_t::low_sequence_number field
to its original value, 1 in this example.
Upon return, UM will see the value unchanged, and will allow
\ref retransmitrequestmaximumreceiver to override the starting sequence
number.
This is only an issue if <i>both</i>
\ref retransmitrequestmaximumreceiver and
\ref umerecoverysequencenumberinfofunctionreceiver are used.
If the application wants to use the sequence number remembered by the Store,
it should not configure \ref retransmitrequestmaximumreceiver.

\m4_s1 duplicatmessagedelivery Duplicate Message Delivery

In a distributed system, it is not possible to <i>guarantee</i>
"once-and-only-once" delivery of messages in the face of unpredictable
system or component failure.
Regardless of the algorithms and handshaking, there is always the
possibility of messages sent that are never received, as well as
messages received and then received again if the receiving application
fails and restarts.

UM's persistence design is based on the principle of being close to
once-and-only-once, but when that is not possible, UM prefers to fail
on the side of duplicate message delivery.
Due to other design goals (low latency and high throughput), the
possibility of receiving duplicate messages is significant after an
application failure and restart.

It is therefore important for persistent applications to be designed
to tolerate duplicate message reception, either by making message
processing idempotent, or by including logic in the receiving application
to detect duplicates and only process the messages which have not been
previously processed.

To assist the application in implementing "de-duplication",
all messages retransmitted to a receiver are marked as retransmissions via
a flag in the message structure.
Thus it is easy for an application to determine if a message is a new "live"
message from the source, or a retransmission, which may or may not have been
processed before the failure.
The presence or absence of the retransmit flag gives the application a hint
of how best to handle the message with regard to it being processed
previously or not.

Informatica recommends that you always check the data or other message
properties of messages with the retransmit flag set to be sure the message
has not been already processed.
Relying on UM sequence numbers is not a 100% reliable method for detecting
duplicate messages.

\m4_s1 settingcallbackfunctiontosetrecoverysequencenumber Setting Callback Function to Set Recovery Sequence Number

Whereas the UM persistence design attempts to choose the correct starting
sequence number for a recovering receiver, there are cases where the
application wishes to override UM's choice.

The sample code below demonstrates how to use the recovery sequence
number info function to determine the stored message with which to restart
a receiver.
This example retrieves the low sequence number from the recovery sequence
number structure and adds an offset to determine the beginning sequence number.
The offset is a value completely under the control of your application.
For example, if a receiver was down for a "long" period and you only want
the receiver to receive the last 10 messages, use an offset to start the
receiver with the 10th most recent message.
If you wish not to receive any messages, set the
\ref lbm_ume_rcv_recovery_info_ex_func_info_t::low_sequence_number to the
\ref lbm_ume_rcv_recovery_info_ex_func_info_t::high_sequence_number plus one.

<b>C API</b>

\code
lbm_ume_rcv_recovery_info_ex_func_t cb;

cb.func = ume_rcv_seqnum_ex;  /* declared below */
cb.clientd = NULL;
if (lbm_rcv_topic_attr_setopt(&rcv_attr,
                              "ume_recovery_sequence_number_info_function",
                              &cb, sizeof(cb)) == LBM_FAILURE) {
    fprintf(stderr,
        "lbm_rcv_topic_attr_setopt:ume_recovery_sequence_number_info_function: %s\n",
        lbm_errmsg());
    exit(1);
}
printf("Will use seqnum info with low offset %u.\n", seqnum_offset);

...

int ume_rcv_seqnum_ex(lbm_ume_rcv_recovery_info_ex_func_info_t *info, void *clientd)
{
    lbm_uint_t new_lo = info->low_sequence_number + seqnum_offset;

    printf("[%s] SQNs Low %x (will set to %x), Low rxreqmax %x, High %x (CD %p)\n",
        info->source, info->low_sequence_number,
        new_lo, info->low_rxreq_max_sequence_number,
        info->high_sequence_number, info->source_clientd);
    info->low_sequence_number = new_lo;
    return 0;
}
\endcode

<b>JAVA API</b>

\code
UMERcvRecInfo umerecinfocb = new UMERcvRecInfo(seqnum_offset);
rcv_attr.setRecoverySequenceNumberCallback(umerecinfocb, null);
System.out.println("Will use seqnum info with low offset " + seqnum_offset);

class UMERcvRecInfo implements UMERecoverySequenceNumberCallback {
    private long _seqnum_offset = 0;

    public UMERcvRecInfo(long seqnum_offset) {
        _seqnum_offset = seqnum_offset;
    }

    public int setRecoverySequenceNumberInfo(Object cbArg,
    UMERecoverySequenceNumberCallbackInfo cbInfo)
    {
        long new_low = cbInfo.lowSequenceNumber() + _seqnum_offset;
        System.out.println("SQNs Low " + cbInfo.lowSequenceNumber() + " (will set to "
            + new_low + "), Low rxreqmax " + cbInfo.lowRxReqMaxSequenceNumber()
            + ", High " + cbInfo.highSequenceNumber());
        try {
            cbInfo.setLowSequenceNumber(new_low);
        }
        catch (LBMEInvalException e) {
            System.err.println(e.getMessage());
        }
        return 0;
     }
 }
\endcode

<b>.NET API</b>

\code
UMERcvRecInfo umerecinfocb = new UMERcvRecInfo(seqnum_offset);
rcv_attr.setRecoverySequenceNumberCallback(umerecinfocb, null);
System.Console.Out.WriteLine("Will use seqnum info with low offset " + seqnum_offset);

class UMERcvRecInfo implements UMERecoverySequenceNumberCallback {
    private long _seqnum_offset = 0;

    public UMERcvRecInfo(long seqnum_offset) {
        _seqnum_offset = seqnum_offset;
    }

    public int setRecoverySequenceNumberInfo(Object cbArg,
        UMERecoverySequenceNumberCallbackInfo cbInfo)
    {
        long new_low = cbInfo.lowSequenceNumber() + _seqnum_offset;
        System.Console.Out.WriteLine ("SQNs Low " + cbInfo.lowSequenceNumber() + " (will set to "
            + new_low + "), Low rxreqmax " + cbInfo.lowRxReqMaxSequenceNumber()
            + ", High " + cbInfo.highSequenceNumber());
        try {
            cbInfo.setLowSequenceNumber(new_low);
        }
        catch (LBMEInvalException e) {
            System.Console.Out.WriteLine (e.getMessage());
        }
        return 0;
    }
}
\endcode

\anchor immediatemessageconsumption
\anchor delayedmessageprocessing
\anchor batchingacknowledgments
\m4_s1 persistencemessageconsumption Persistence Message Consumption

When a persistent subscriber application has finished processing a
received message, it must signal consumption of the message to UM.
This is how UM keeps track of where message recovery should begin if
recovery is needed (e.g. if the receiver restarts).

There are three basic methods to signaling message consumption that
the application must choose between:
<ul>
<li>The subscriber's receiver callback returns to UM,
allowing UM to delete the message.
The message deletion signals consumption.
This is generally the most simple case.
<li>The subscriber retains the message past the point of the receiver
callback returning.
Then some other application function (typically running in a separate thread)
finishes the processing and deletes the message.
The message deletion signals consumption.
<li>The subscriber calls a separate "explicit ACK" API which signals
message consumption.
In this case, the act of deleting the message does not signal consumption.
</ul>

When the application uses one of those methods to signal consumption,
it is informing the local instance of UM running within the application.
As a separate step, UM must send a consumption acknowledgement (ACK)
to the Persistent Store(s).
However, the two steps are not necessarily directly linked.

There are two configurable acknowledgement methods that UM can follow
when the application signals consumption:
<ul>
<li>UM batches ACKs based on a configurable time period.
I.e. UM will delay sending ACKs to the Store so that multiple messages
can be acknowledged at once, when its timer expires.
<li>UM immediately sends an ACK to the Store.
</ul>

Batching of ACKs greatly improves the throughput of a persistent receiver,
and can also improve latency.
It is the default configuration.

However, batching has the disadvantage that if message recovery is needed
(e.g. if the subscriber restarts), it increases the chances that
already processed messages will be re-sent during recovery
("duplicate messages").
Any messages that the application signaled consumed,
but which UM has not yet acknowledged to the Store,
can be re-sent during recovery.

Note that even with immediate ACK,
there is still the possibility of one or more already-consumed
messages being recovered; applications need to be able to handle this.
See \ref duplicatmessagedelivery for more information.

<b>Use Cases</b>

There are four common use cases which combine an application
consumption method with a UM acknowledgement method:
<ul>
<li>\ref deleteonreturnbatchacks, most common.
<li>\ref retainonreturnbatchacks, also common.
<li>\ref explicitacknowledgments.
<li>\ref ackimmediatelyondelete.
</ul>

\m4_s2 deleteonreturnbatchacks Delete on Return, Batch ACKs

The application receiver callback completes all processing of a message
before returning.
It allows UM to delete the message on return, which signals consumption.

To maximize efficiency, the application allows UM to batch ACKs
to the Store.

Note that in this use case, messages are always signaled consumed in
the same order in which they are received.

For this use case, use the configuration:
<ul>
<li>\ref umeuseackbatchingreceiver - set to <b>1</b> (the default).
<li>\ref umeexplicitackonlyreceiver - set to <b>0</b> (the default).
</ul>

The subscriber code is written to signal message consumption
on return from the receiver callback.
This is handled differently between the C API vs. the Java and .NET
APIs.

<b>C API</b>

The default behavior for a C application receiver callback is for the message
to be deleted and when the receiver callback returns,
which signals consumption the message.
No special coding is needed for this use case.

Note: the receiver callback must *not* call lbm_msg_delete().

<b>Java and .NET</b>

With Java and .NET, the application receiver callback must explicitly call
\ref com::latencybusters::lbm::LBMMessage.dispose() prior to
returning.

(Note that this is not strictly true for .NET.
A .NET program can skip calling "dispose()" and allow the message to
become garbage. This will introduce significant latency outliers when GC
runs, and also makes acknowledgements to the Store non-deterministic.
Finally, in the future, performance improvements for .NET will probably
require the use of "dispose()".
Informatica recommends that .NET programs call "dispose()" for
every message.)

\m4_s2 retainonreturnbatchacks Retain on Return, Batch ACKs

There are application designs where a received message cannot
be fully processed inside the receiver application callback.
For example, the message might need to be handed off to a worker thread for
longer-term processing.
Or the acknowledgement must be delayed until some asynchronous event happens,
like a handshake with another application.

To maximize efficiency, applications allow UM to batch ACKs
to the Store.

Note that some applications are written to process these handed-off
messages in parallel,
and messages might be signaled consumed in a different order than they arrived.
In this use case, out-of-order consumption is supported.
See \ref ackordering for more information.

For this use case, use the configuration:
<ul> 
<li>\ref umeuseackbatchingreceiver - set to <b>1</b> (the default).
<li>\ref umeexplicitackonlyreceiver - set to <b>0</b> (the default).
</ul>
Note that this is the same configuration as \ref deleteonreturnbatchacks.

The subscriber code should be written to hand off the message to another part
of the application and suppress deleting the message
on return from the receiver callback.
This is handled differently between the C API vs. the Java and .NET
APIs.

<b>C API</b>

In C, the application's receiver callback function must
call the lbm_msg_retain() API for the received message
prior to handing off the message for processing.
This suppresses the automatic deletion of the received message when
the receiver callback returns,
and allows the message buffer to be passed to some other part of the
application for processing and deletion at a later time.

When the application subsequently completes all processing of the message,
it signals consumption by calling lbm_msg_delete().

<b>Java and .NET</b>

In Java and .NET, the application should call the
\ref com::latencybusters::lbm::LBMMessage.promote() API
prior to handing the message for a separate processing.
This allows the message object to be passed to some other part of the
application for processing and disposal at a later time.

When the application subsequently completes all processing of the message,
it signals consumption by calling
\ref com::latencybusters::lbm::LBMMessage.dispose().

\m4_s2 explicitacknowledgments Explicit Acknowledgments

The \ref umeuseackbatchingreceiver "ACK batching feature" did not exist
in UM in versions prior to 5.0.
In those early versions, the application had to use the
\ref umeexplicitackonlyreceiver "Explicit ACK feature" to benefit from
the increased throughput allowed by batching of ACKs.
Informatica will continue to support Explicit ACKs, even though we
generally recommend the ACK batching use cases
\ref deleteonreturnbatchacks or \ref retainonreturnbatchacks.

With explicit ACKs, message consumption is separated from message deletion.
The application uses a separate API to trigger an acknowledgement to the Store.
Batching is achieved under application control by not ACKing every message.
With explicit ACKs, the action of acknowledging a message to the Store
implicitly acknowledges all previous unacknowledged messages.

\warning Because explicit ACKs implicitly acknowledge all previous
unacknowledged messages, it is not valid to acknowledge messages out of order.
Otherwise the application risks not recovering needed messages.
See \ref ackordering.

For this use case, use the configuration:
<ul> 
<li>\ref umeuseackbatchingreceiver - set to <b>0</b>.
<li>\ref umeexplicitackonlyreceiver - set to <b>1</b>.
</ul>

The subscriber should be written the same as \ref deleteonreturnbatchacks
(if processing is completed in the receiver callback) or
\ref retainonreturnbatchacks (if the message is retained after the
receiver callback returns).
The same coding rules apply regarding message retention and disposal.

However, as an additional step, the application must call
the explicit ACK API:
<ul>
<li>C: lbm_msg_ume_send_explicit_ack()
<li>Java/.NET: com::latencybusters::lbm::LBMMessage.sendExplicitAck()
</ul>
This is typically done inside of a timer callback,
which provides batching behavior.

\m4_s2 ackimmediatelyondelete ACK Immediately on Delete

With this use case, the application directs UM to send an acknowledgement
to the Store for each and every processed message immediately after
the message is deleted.

The advantage of this use case is that it minimizes the chances that
already processed messages will be re-sent during recovery (i.e.
"duplicate messages").
However, there is still the possibility of one or more duplicate messages
during recovery, so applications need to be able to handle this.
See \ref duplicatmessagedelivery for more information.

A disadvantage of this use case is that the maximum sustainable
throughput (message rate) is limited by the per-message overhead of
sending acknowledgements.

Another disadvantage is that messages must be deleted in the same
order as they were received,
even if the messages are handed off to another thread for processing.
See \ref ackordering.

Informatica's general recommendation is that since the application needs
to handle duplicate messages even with immediate acknowledgement,
the user should implement a use case that includes ACK batching.

For this use case, use the configuration:
<ul>
<li>\ref umeuseackbatchingreceiver - set to <b>0</b>.
<li>\ref umeexplicitackonlyreceiver - set to <b>0</b> (the default).
</ul>

The subscriber should be written the same as \ref deleteonreturnbatchacks
(if processing is completed in the receiver callback) or
\ref retainonreturnbatchacks (if the message is retained after the
receiver callback returns).
The same coding rules apply regarding message retention and disposal.

\m4_s1 ackordering ACK Ordering

When UM is allowed to batch ACKs to the Store using
\ref umeuseackbatchingreceiver, the UM client library supports "out of order"
signaling that the application is done processing messages.
For example, the application might retain received messages 1, 2, and 3 for
asynchronous processing, and then delete them in the order 2, 1, 3.

However, be aware that the Persistent Store does not support "out of order"
acknowledgement of messages.
If the Store receives an acknowledgement of sequence number N, that implicitly
acknowledges all sequence numbers less than N.

The UM client library handles this by withholding acknowledgement to
the Store all messages for which an earlier message is not signaled complete.
For example, if the application retains messages 1, 2, and 3,
and subsequently deletes message 2, UM will not send an ACK to the Store
for message 2.
If the application then deletes message 1, UM is now able to send an
ACK for message 2, which will implicitly acknowledge message 1 as well.

However, this ability to process messages out of order is dependent on
using ACK batching (i.e. \ref umeuseackbatchingreceiver is <b>1</b>).
If ACK batching is disabled, then the application is responsible for
ordering acknowledgements to the Store. This is true for both the
\ref explicitacknowledgments and \ref ackimmediatelyondelete use cases.

For example, suppose that the \ref ackimmediatelyondelete use case is being
used.
If the application processes and deletes messages in the order 2, 1, 3, 
the ACK for message 2 will implicitly ACK message 1 to the Store.
If the application crashes after ACKing 2 and restarts,
recovery will start with message 3.
Thus, message 1 is never fully processed.

If ACK batching is disabled, the messages must be deleted in
order: 1, 2, 3.

\m4_s1 objectfreeexplicitacknowledgments Object-free Explicit Acknowledgments

When using explicit ACKs, you can extract ACK
information from messages.
This allows the received message buffer to be deleted when the receiver
callback is done, while still allowing the application to save the ACK
structure for persistent acknowledgement to the Store at a future time.
This can improve receiver performance when used with
the \ref receivebufferrecycling feature to
reduce the per-message use of dynamic memory (malloc/free) with a persistent
receiver.
Extracting ACKs can also additionally improve performance of Java and .NET
applications by allowing the use of \ref zeroobjectdelivery.

The following source code examples show how to extract ACK information and
send an explicit ACK.

<b>C API</b>

\code
int rcv_handle_msg(lbm_rcv_t *rcv, lbm_msg_t *msg, void *clientd)
{
  lbm_ume_rcv_ack_t *ack = NULL;
...

  ack = lbm_msg_extract_ume_ack(msg);
  defer_ack(ack);  /* Pass the "ack" to another thread or work queue. */
...
  return 0;
}

int worker()
{
  lbm_ume_rcv_ack_t *ack = NULL;
...
  ack = get_deferred_ack();  /* Get "ack" that was saved above. */

  /* Some applications improve throughput by not ACKing every message. */
  if (ack_this_message) {
    lbm_ume_ack_send_explicit_ack(ack, msg->sequence_number);
  }

  lbm_ume_ack_delete(ack);  /* Extracted ack *must* be deleted. */
...

}
\endcode

<b>JAVA API or .NET API</b>

\code
public int onReceive(Object cbArg, LBMMessage msg)
{
  UMEMessageAck ack;
...

  ack = msg.extractUMEAck();
  defer_ack(ack);  /* Pass the "ack" to another thread or work queue. */
...
  return 0;
}

int worker()
{
  UMEMessageAck ack;

  ack = get_deferred_ack();  /* Get "ack" that was saved above. */

  /* Some applications improve throughput by not ACKing every message. */
  if (ack_this_message) {
    ack.sendExplicitAck(msg.sequenceNumber());
  }
  ack.dispose();  /* Extracted ack *must* be deleted. */
}
\endcode

\m4_pg designingpersistentstores Designing Persistent Stores

As mentioned in \ref persistentstoreconcept, the Persistent Stores, also just
called Stores, actually persist the source and receiver state and use
RegIDs to identify sources and receivers.
Each source to which a Store provides persistence may have zero or more
receivers.
The Store maintains each receiver's state along with the source's state and
the messages the source has sent.

This document is oriented mostly to programmers.
See also the Operations Guide chapters
\ref persistentstoreumestored, \ref persistentstorecrashed,
\ref persistentsendingproblems, and \ref umpersistentstorelogmessages.

The Store can be configured with its own set of options to persist this
state information on disk or simply in memory.
The term disk Store is used to signify a Store that persists state to disk,
and the term memory Store is used to signify a Store that persists state
only in memory.

A source does not send data to the Store and then have the
Store forward it to the receivers.
In UM, the source sends to receivers and the Stores in parallel.
See \ref persistencenormaloperation.
Thus, UM can provide extremely low latency to receiving applications.

The Store(s) that a source uses are part of the source's configuration settings.
Sources must be configured to use specific Store(s) in a Quorum/Consensus
arrangement.

Receivers, on the other hand, do not need to be configured with Store
information a priori.
The source provides Store information to receivers via a Source Registration
Information (SRI) message after the source registers with a Store.
Thus the receivers learn about Stores from the source, without needing to
be configured themselves.
Because receivers learn about the Store or Stores with which they must
register via a SRI record, the source must be available to receivers.
However, the source does not have to be actively sending data to do this.

\m4_s1 limitinitialrestore Limit Initial Restore with Restore-Last

The "restore-last" feature limits the initial message restore
for a restarting Store.

When a disk-based store is restarted,
during its initialization it will open the state and cache files
and restore the data.
This makes previously saved message data available for recovering subscribers.
Note that this message restoration takes some time.
For small files of a few megabytes, it might take a few seconds.
But for large files of many gigabytes, it could take minutes.

Starting with UM version 6.15,
you can configure a restarting Store to only restore a subset of the saved messages.
This can greatly speed up the process of initialization.

For example, you might direct the Store to only restore 8 hours'
worth of message data when it is restarted.
Doing this means that older messages are not available from this Store
for recovering subscribers.
But if only one Store of a Q/C group is restarted,
one or more of the other Stores will continue to have the older messages
available.

The \ref umeelementrestorelast is used to enable this
feature.

When the restore-last feature is enabled,
the Store will write an additional, per-source "cache index" file.
It is written to the configured cache directory and is named the
same as the source's normal message cache file with ".idx" appended.
For example, your cache directory might contain:
\verbatim
3085235048-cache
3085235048-cache.idx
\endverbatim

When the Store is restarted, the cache index file is used to
quickly determine which messages are within the restore-last range.
As a result of this algorithm,
if a deployed Store is re-configured to enable the restore-last feature,
the first time it is restarted will not be sped up.
I.e. since the index file will not yet exist,
the first startup after enabling the feature will restore the entire
existing cache file.


See \ref umeelementrestorelast for implementation details.

\m4_s1 storelogfile Store Log File

The Store Process generates log messages that are used to monitor its
health and operation.
You can configure these to be directed to "console" (standard output)
or a specified log "file", via the \ref umeelementlog.
Normally "console" is only used during testing, as a persistent log file
is preferred for production use.
The Store does not over-write log files on startup, but instead
appends them.

\m4_s1 storerollinglogs Store Rolling Logs

To prevent unbounded disk file growth, the Store supports rolling
log files.
When the log file rolls, the file is renamed according to the model:
<br>&nbsp;&nbsp;<i>CONFIGUREDNAME</i><tt>_</tt><i>PID</i><tt>.</tt><i>DATE</i><tt>.</tt><i>SEQNUM</i>
<br>where:
<ul>
<li><i>CONFIGUREDNAME</i> - Root name of log file, as configured by user.
<li><i>PID</i> - Process ID of the Store Process.
<li><i>DATE</i> - Date that the log file was rolled, in YYYY-MM-DD format.
<li><i>SEQNUM</i> - Sequence number, starting at 1 when the process starts,
and incrementing each time the log file rolls.
</ul>
For example: `umestorelog_9867.2017-08-20.2`

The user can configure when the log file is eligible to roll over by
either or both of two criteria: size and frequency.
The size criterion is in millions of bytes.
The frequency criterion can be daily or hourly.
Once one or both criteria are met, the next message written to the log
will trigger a roll operation.
These criteria are supplied as attributes to the \ref umeelementlog.

If both criteria are supplied, then the first one to be reached will trigger
a roll.
For example, consider the setting:
\code
  <log type="file" size="23" frequency="daily">store.log</log>
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

\m4_s1 quorumconsensusstoreusage Quorum/Consensus Store Usage

To provide the highest degree of resiliency in the face of failures,
UM provides the Quorum/Consensus failover strategy which allows a source to
provide UM with a number of Stores to be used at the same time.
Multiple Stores can fail and messaging can continue operation unhindered as
long as a majority of configured Stores are operational.

Quorum/Consensus, also called QC, allows a source and the associated
receivers to have their persisted state maintained at several Stores at the
same time.
Central to QC is the concept of a group of Stores, which is a logical
grouping of Stores that are intended to signify a single entity of resilience.
Within the group, individual Stores may fail but for the group as a whole
to be viable and provide resiliency, a quorum must be available.
In UM, a quorum is a simple majority.
For example, in a group of five Stores, three Stores are required to
maintain a quorum.
One or two Stores may fail and the group continues to provide resiliency.
UM requires a source to have a quorum of Stores available in the group in
order to send messages.
A group can consist of a single Store.

QC also provides the ability to use multiple groups.
The use of multiple QC groups is a special case and should be discussed with
Informatica support before using.

\m4_s1 sourcesusingquorumconsensusstoreconfiguration Sources Using Quorum/Consensus Store Configuration

In the case of Quorum/Consensus Store behavior, a message is considered
stable after it has been successfully stored within a group of Stores or
among groups of Stores according to the two settings,
intergroup behavior and intragroup behavior, described below.

<ul>
<li>The intragroup behavior specifies the requirements needed to stabilize
a message among the Stores within a group.
A message is stable for the group once it is successfully stored at a
quorum (majority) of the group's Stores or successfully stored in all the
Stores in the group.

<li>The intergroup behavior specifies the requirements needed to stabilize
a message among groups of Stores.
A message is stable among the groups if it is successfully stored at any
group, a majority of groups, all groups, or all active groups.
</ul>

Notice that a message needs to meet intragroup stability requirements
before it can meet intergroup stability requirements.
These options provide a number of possibilities for retention of messages
for the source.

\m4_pg persistentfaultrecovery Persistent Fault Recovery

Recovery from source and receiver failure is the real heart of persistent
operation.
For a source, this means continuing operation from where it stopped.
For a receiver, this means essentially the same thing, but with the
retransmission of missed messages.
Application developers can easily leverage the information in UM to
make their applications recover from failure in graceful ways.

\ref latejoin is the mechanism of persistent recovery as well as an UM 
streaming feature.
If Late Join is turned off on a source (\ref latejoinsource) or receiver
(\ref uselatejoinreceiver), it also turns off persistent recovery.
In order to control Late Join behavior, UM provides a mechanism for a
receiver to control the low sequence number.
See \ref recoverymanagement.

Not all failures are recoverable.
For application developers it usually pays in the long run to identify what
types of errors are non-recoverable and how best to handle them when possible.
Such an exercise establishes the precise boundaries of expected versus
abnormal operating conditions.

\m4_s1 persistentsourcerecovery Persistent Source Recovery

The following shows the basic steps of source recovery:

<ol>
<li>Re-register with the Store.
<li>Determine the highest sequence number that the Store has from the source.
<li>Resume sending with the next sequence number.
</ol>

Because UM allows you to stream messages and not wait until a message is
stable at the Persistent Store before sending the next message,
the main task of source recovery is to determine what messages the
Persistent Store(s) have and what they don't.
Therefore, when a source re-registers with a Store during recovery,
the Store tells the source what sequence number it has as the most recent
from the source.
The registration event informs the application of this sequence number.
See \ref sourceeventhandler.

In addition, a mechanism exists (LBM_SRC_EVENT_SEQUENCE_NUMBER_INFO) that
allows the application to know the sequence number assigned to every piece
of data it sends.
The combination of registration and sequence number information allows an
application to know exactly what a Store does have and what it does not and
where it should pick up sending.
An application designed to stream data in this way should consider how best
to maintain this information.

When QC is in use, UM uses the consensus of the group(s) to determine what
sequence number to use in the first message it will send.
This is necessary as not all Stores can be expected to be in total agreement
about what was sent in a distributed system.
The application can configure the source with the
\ref umeconsensussequencenumberbehaviorsource to use the lowest sequence
number of the latest group of sequence numbers seen from any Store,
the highest, or the majority.
In most cases, the majority, which is the default, makes the most sense as
the consensus.
The lowest is a very conservative setting.
And the highest is somewhat optimistic.
Your application has the flexibility to handle this in any way needed.

If streaming is not what an application desires due to complexity, then it
is very simple to use the \ref persistenceevents delivered to the
application to mimic the behavior of restricting a source to having only
one unstable message at a time.

\m4_s1 persistentreceiverrecovery Persistent Receiver Recovery

The following shows the basic steps of receiver recovery:

<ol>
<li>Re-register with the Store.
<li>Determine the low sequence number.
<li>Request retransmission of messages starting with the low sequence number.
</ol>

UM provides extensive options for controlling how receivers handle recovery.
By default, receivers want to restart after the last piece of data that was
consumed prior to failure or graceful suspension.
Since UM persists receiver state at the Store, receivers request this
state from the Store as part of re-registration and recovery.
Receiving applications experiencing unrecoverable loss can potentially
retrieve missed messages from the Stores by deleting and recreating the
receiver object.

The actual sequence number that a receiver uses as the first topic level
message to resume reception with is called the "low sequence number".
UM provides a means of modifying this sequence number if desired.
An application can decide to use the sequence number as is, to use an even
older sequence number, to use a more recent sequence number, or to simply
use the most recent sequence number from the source.
See \ref recoverymanagement and
\ref settingcallbackfunctiontosetrecoverysequencenumber "Setting Callback Function to Set Recovery Sequence Number".
This allows receivers great flexibility on a per source basis when recovering.
New receivers, receivers with no pre-existing registration, also have the
same flexibility in determining the sequence number to begin data reception.

Like sources, when QC is in use, UM uses the consensus of the group(s) to
determine the low sequence number.
And as with sources, this is necessary as not all Stores can be expected to
be in total agreement about what was acknowledged.
The application can configure the receiver with
\ref umeconsensussequencenumberbehaviorreceiver to use the lowest sequence
number of the latest group of sequence numbers seen from any Store,
the highest, or the majority.
In most cases, the majority, which is the default, makes the most sense as
the consensus.
The lowest is a very conservative setting.
And the highest is somewhat optimistic.
In addition, this sequence number may be modified by the application after
the consensus is determined.

For QC, UM load balances receiver retransmission requests among the
available Stores.
In addition, if requests are unanswered, retransmissions of the actual
requests will use different Stores.
This means that as long as a single Store has a message, then it is
possible for that message to be retransmitted to a requesting receiver.

\m4_pg callablestore Callable Store

It is possible for an application to start an instance of the Store to run
as an independent set of threads within the application process.
However, there are several restrictions:

<ol>
<li>The application may not make use of messaging.
I.e. an application which intends to start a Store instance must not create
contexts, sources, or receivers, or make any use of UM except starting (and
optionally stopping) the Store.
For applications that need to use messaging, it is suggested that the
application create a child process from which to invoke the Store.
The parent process can then use messaging freely.

<li>Only a C API is provided at this time.
Two API functions are available: umestored_main() to start the Store
threads running, and umestored_main_shutdown() to request the Store threads
to stop gracefully.

<li>The umestored_main() API will not return until the Store exits, either by
processing a signal, or by the application calling umestored_main_shutdown().
When umestored_main() does return, the Store is in a safe state for the
application to exit.

<li>Only a single instance of the Store may be started.
This means that an application may not have two Stores running concurrently,
and it also means that an application may not start a Store, shut it down,
and then start it again.
The Store API is "single use".

<li>The application may not set signal handlers for SIGPIPE, SIGUSR1,
SIGINT, or SIGTERM.
The Store uses those signals.
For applications that need to handle those signals, it is suggested that
the application create a child process, as mentioned above (#1).
</ol>

See 
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../API/umestored__main_8h.html">umestored_main.h File Reference</a>
for API details.

The API code is *not* contained within the normal "lbm" library.
On Linux, it is in "libumestorelib.a", a static library.
On Windows, it is in "umestore.dll", a dynamic library.

For an example of how to use the umestored_main() API, see the example
program \ref exampleumestored_example_c.
Note that while the callable Store APIs are usable on all supported platforms,
this example program is restricted to Linux due to its use of `prctl()`,
a Linux-only function.

\m4_pg storethreadaffinity Store Thread Affinity

A significant performance improvement of the Store can be obtained by
"pinning" threads to CPU cores.
Normally, the operating system will migrate a process's threads
to different CPU cores,
depending on what else is going on in the host.
This can degrade the process's performance in a number of ways,
mostly related to memory access (cache, NUMA zones).
By setting the CPU affinity for the performance-sensitive threads,
you avoid this degradation.

For high-throughput applications,
you will gain significant performance improvement by constraining the
operating system to run the Store's threads on specific CPU cores.
All of a Store's threads should run on cores in the same physical CPU chip.

For maximum benefit, you should "isolate" the cores running the
message reception threads.
This prevents the operating system from scheduling other processes/threads
on those cores.

<b>Setting Affinity</b>

When the Store Process is executed,
the user can optionally use the "-a" option
to set CPU affinity to the various threads.
See \ref umestoredmanpage.

Note that for the Windows Service,
you don't supply the option when the service is run.
Instead you save the thread affinity into the Windows registry
for subsequent use by the Store Windows Service.
See \ref umestoredsmanpage and \ref configurethewindowsservice.

The "-a" option takes a comma-separate list of CPU (core) numbers.
For example, "-a 1,3,1,..." refers to CPU 1, CPU 3, CPU 1 again, etc.

The sequence of numbers are assigned to threads as follows:

The first number is the "process" CPU number,
which is used for all miscellaneous threads that aren't otherwise assigned.

The next 4 numbers are assigned to a Store's operational threads in
the following sequence:
<ol>
<li>Message reception thread.
<li>Proxy source thread.
<li>Receiver recovery thread.
<li>Auxiliary thread.
</ol>
If the Store Process has multiple Stores configured, additional groups
of 4 numbers should be supplied.

Of these threads, the most critical is the message reception thread.
For best performance,
each Store's message reception thread should be given exclusive access
to its own CPU core.

The receiver recovery thread is also important, since it can affect
the speed at which receivers can recover missed messages.
However, since CPU cores are scarce resources on hosts,
it may not be practical to give each receiver recovery thread
its own core.

The proxy source and auxiliary threads are not critical to general
Store throughput,
and are therefore generally assigned to the "process" core as miscellaneous.

<b>Affinity Example</b>

For example, suppose you have a Store Process configured for two Stores.
Further, let's say that on your host, even-numbered CPUs belong
to one physical CPU chip,
and odd-numbered CPUs belong to a different physical CPU chip.
The following would optimize both message reception and message recovery,
at the expense of consuming 5 cores:

\verbatim
umestored -a 3,5,3,7,3,9,3,11,3 ...
\endverbatim

This assigns:
<ul>
<li> the process's miscellaneous threads to CPU 3,
<li> the first Store's message reception thread to CPU 5,
<li> the first Store's proxy source thread to CPU 3,
<li> the first Store's receiver recovery thread to CPU 7,
<li> the first Store's auxiliary thread to CPU 3,
<li> the second Store's message reception thread to CPU 9,
<li> the second Store's proxy source thread to CPU 3,
<li> the second Store's receiver recovery thread to CPU 11,
<li> the second Store's auxiliary thread to CPU 3.
</ul>

If assigning this many cores to the Store Process is not practical,
the following conserves cores at the expense of potentially degrading
message recovery speed:

\verbatim
umestored -a 3,5,3,3,3,7,3,3,3 ...
\endverbatim

This assigns a CPU core to each of the two message reception threads
(5 and 7), and groups all other threads onto the miscellaneous CPU core (3).

\m4_pg persistencefaulttolerance Persistence Fault Tolerance

\m4_s1 messagelossrecovery Message Loss Recovery

Persistence offers the following message recovery mechanisms:

<table>
<tr><th>Method <th>Product <th>Transports <th>Description

<tr><td>Negative Acknowledgments (NAKs) <td>UMS, UMP, UMQ
<td>LBT-RM, LBT-RU <td>Recovers lost transport datagrams from the source
which may contain many small topic messages or fragments of a large message.
Receivers send unicast NAKs to the source for missed transport datagrams.
Source retransmits datagrams over the configured UM transport.

<tr><td>Late Join <td>UMS, UMP, UMQ <td>All <td>Retransmits messages via
unicast to receivers joining the stream after the messages were originally sent.
See \ref usinglatejoin.

<tr><td>Durable Receiver Recovery <td>UMP, UMQ <td>All <td>Recovers messages
persisted while a durable receiver was off line.
UM initiates recovery when a durable receiver joins a persistent stream.
The receiver then requests retransmission from the Store starting with the
low sequence number, defined as the last message it acknowledged to the
Store plus one.
The Store unicasts retransmissions.
See \ref persistentreceiverrecovery.

<tr><td>Off Transport Recovery <td>UMS, UMP, UMQ <td>All <td>Recovers lost
topic messages.
Receiver detects lost sequence number and requests retransmission from the
source or Persistent Stores (if applicable).
UM unicasts retransmissions.
See \ref offtransportrecoveryotr.

<tr><td>Proactive Retransmissions <td>UMP, UMQ <td>All <td>Recovers lost
messages never received by the Store or never acknowledged by the Store.
Operates independently of any receivers.
Source unicasts retransmissions.
See \ref proactiveretransmissions.
</table>

\m4_s1 persistenceproxysources Persistence Proxy Sources

By default, UM expects persistent sources to be running concurrently with
persistent receivers.
If a source exits, any persistent receivers will disconnect from that
source's transport and will wait for the source to come back.
More significantly, if a new receiver starts while the source is absent,
the receiver will be unable to discover the Stores where the old
source's previous messages are Stored.
So that late-joining receiver will not recover messages until the source
finally restarts.

The Proxy Source feature allows you to configure Stores to create a
UM source object to take the place of the exited source.
This proxy source behaves much like a real source in that it provides
all of the necessary information to subscribers so that they can
discover and register with the Stores.
This allows late joining receiver to recover messages they missed.

After the the real source returns, the Store automatically deletes
its proxy source, allowing the real source to resume normal operation.

Some other features of Proxy Sources include:

<ul>
<li>Requires a Quorum/Consensus Store configuration.

<li>Normal Store failover operation also initiates a new proxy source.

<li>A Store can be running more than one proxy source if more than one
source has failed.

<li>A Store can be running multiple proxy sources for the same topic,
each one corresponding to a previous instance of a real source.
</ul>

Note that proxy sources do introduce extra network and CPU loading, so
proxy sources should only be enabled if their functionality is needed.

\m4_s2 howproxysourcesoperate How Proxy Sources Operate

The following sequence illustrates the life of a proxy source:

<ol>
<li>A source configured for Proxy Source sends to receivers and a group of
Quorum/Consensus Stores.

<li>The source fails.

<li>The source's \ref umeactivitytimeoutsource or the Store's
\ref umecfgsourceactivitytimeout "source-activity-timeout" expires.

<li>The Quorum/Consensus Stores elect a single Store to run the proxy source.

<li>The elected Store creates a proxy source and sends topic advertisements.

<li>The failed source reappears.

<li>The Store deletes the proxy source and the original source resumes activity.
</ol>

Note that the implementation of the proxy source involves the Store
creating a normal UM source object.
As such, the user is responsible for providing the Store with a
UM library configuration with appropriate source-scoped options.
For most source-scoped configuration options, there is no
requirement for the proxy source's settings to match the original
source's settings.
However, there are a few that should be configured the same:
<ul>
<li>\ref umeretentionintergroupstabilitybehaviorsource (if configured by the original source).
<li>\ref umeretentionintragroupstabilitybehaviorsource (if configured by the original source).
<li>\ref resolveroperationref "source-related topic resolution options"
(e.g. \ref resolveradvertisementminimumsustaindurationsource).
</ul>

Some UM customers have found reasons to intentionally configure their
proxy source differently from the original source.
For example, to conserve network resources,
some customers choose to configure a different \ref transportsource "transport" and
change \ref transportsessions "topic-to-transport session mappings".
Feel free to
<a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a>
for guidance in configuring your proxy sources.

If the Store running the proxy source fails, the other Stores in the
Quorum/Consensus group detect a source failure again and can elect a new Store
to initiate a proxy source,
subject to the \ref umecfgproxysourcerepoquorumrequired.

\m4_s2 activitytimeoutandstatelifetimes Activity Timeout and State Lifetimes

UM provides activity and state lifetime timers for sources and receivers
that operate in conjunction with the proxy source option or independently.
This section explains how these timers work together and how they work with
proxy sources.

<b>Activity Timeout</b>

The Store uses the activity timer to decide if a new registration is allowed
with the same registration ID.
The Store does not allow two applications to be registered at the same time
with the same registration ID.
However, if an application exits abnormally,
we obviously want to restart the application and have it register with the
same registration ID.
How does the Store prevent simultaneous registration while allowing sequential
registrations?
I.e. how does the Store decide that an existing registrant has exited?
The activity timer.

After registration, the Store expects to hear some kind of activity
(message, control, or keepalive) before the activity timer expires.
If not, then the Store assumes the source or receiver has been deleted,
perhaps by the program cleaning up, or perhaps by crashing.
That "releases" the registration ID for use by another application instance.

Setting the activity timeout is somewhat of a balancing act.
If you set it too long, then you need to wait a long time before you can
restart a crashed application instance.
If you set it too short, it risks the Store timing out the application
too soon, leaving it vulnerable to having its registration ID "stolen"
by another application instance.

Some users maintain tight control over their applications, and choose to set
the activity timeout to zero.
This results in "weak RegIDs", meaning that the Store does not enforce
serialized access to the registration IDs.
Other users choose a non-zero activity timeout, and rely on the Store to
prevent simultaneous use of a registration ID.
This results in "strong RegIDs", meaning that the Store enforces serialized
access to the registration IDs.

The activity timeouts default to 30 seconds,
and can be configured by the application using:
\ref umeactivitytimeoutsource and \ref umeactivitytimeoutreceiver.
They can also be configured by the Store using:
\ref umecfgsourceactivitytimeout and \ref umecfgreceiveractivitytimeout.
(If both the application and the Store configures the same timer,
the result varies and is described in the above linked documentation.)

Finally, be aware that if the activity timeout is longer than
the state lifetime,
then the expiration of the activity timeout also triggers the
deletion of state information.

<b>State Lifetime</b>

The state lifetime timer determines how long state information is
retained on a Store in the absence of the source or receiver.
I.e. if a publisher exits, the state and message data is
retained for the state lifetime period,
and is then discarded.

After registration, the Store expects to hear some kind of activity
(message, control, or keepalive) before the state lifetime timer expires.
If not, then the Store deletes the state information associated
with the source or receiver.

Setting the state lifetime is somewhat of a balancing act.
If you set the source state lifetime too long,
it can lead to old, stale data being available to subscribers
during periods that you don't want it.
If you set it too short, it risks the Store timing out the
application too soon, and potentially leading to undesired
message loss.

For short-lived publishers that start, register, perform some
function, and exit, a fairly short state lifetime can make sense.
For long-lived publishers that might have long-lasting outages and
it's important for all published messages to be reliably delivered,
a long state lifetime is more appropriate.

The state lifetimes default to 0,
meaning that an application's state will be deleted
immediately after the activity timeout happens.
Most UM users set this option to a non-zero value,
according to their requirements.
The state lifetime can be configured by the application using:
\ref umestatelifetimesource and \ref umestatelifetimereceiver.
They can also be configured by the Store using:
\ref umecfgsourcestatelifetime and \ref umecfgreceiverstatelifetime.
(If both the application and the Store configures the same timer,
the result varies and is described in the above linked documentation.)

<b>Activity and State Lifetime Timers Together</b>

\image html source_state_lifetime.png
\image latex source_state_lifetime.png

<b>Proxy Sources</b>

If you have enabled the Proxy Source option,
a source activity timeout
triggers the creation of the proxy source.
The following diagram illustrates this behavior:

\image html src_act_and_state_timers.png
\image latex src_act_and_state_timers.png

\m4_s2 enablingtheproxysources Enabling the Proxy Sources

You must configure both the source and the Stores to enable the Proxy
Source option.

<ul>
<li>Configure the source in an LBM Configuration File with the source
configuration option, \ref umeproxysourcesource.

<li>Configure the Stores in the Store configuration file with the
Store Element Option,
\ref umecfgallowproxysource "allow-proxy-source".
</ul>

\m4_s2 proxysourceelections Proxy Source Elections

When the Stores configured for proxy source detect the loss of
a registered source (expiration of the source's \ref umeactivitytimeoutsource),
one of the Stores should create a proxy source.
The Stores of a Q/C group perform an election to determine which Store creates
the proxy.

Each Store starts by waiting a randomized amount of time based on its
\ref umecfgproxyelectioninterval "proxy-election-interval" option setting.
The Store creates a proxy source if it has not received a persistent
registration request (PREG) from a proxy on a different Store.
The proxy source then sends a PREG containing a unique random value to
the other Stores.
This value determines which Store deletes it's proxy source in the case
that any two Stores independently determine they should create a proxy source.
The nature of the random values ensures that only one Store within the QC
group or configuration of groups keeps its proxy source.

Note that \ref umecfgsourceactivitytimeout value should be set to at least double
the \ref umecfgkeepaliveinterval value.

There are two algorithms that the Stores can use when holding a proxy source
election:
<ol>
<li>Quorum not required (default),
<li>Quorum required (new as of UM version 6.15; set \ref umecfgproxysourcerepoquorumrequired to 1).
</ol>

Informatica recommends that new projects use algorithm 2
(Quorum required).
This is not the default and must be explicitly set.
Existing projects that use algorithm 1 and do not have problems
related to proxy sources do not need to change.

<b>ALGORITHM DETAILS:</b>

A proxy source is specific to a topic/reg-ID (or topic/session-ID).
When a source exits (publisher deletes it or crashes),
the Stores time the source out and hold an election to determine
which Store will create a proxy source.

With algorithm 1 (quorum not required),
every running Store in the Q/C group participates in the election.

With algorithm 2 (quorum required),
only those Stores that have state for the topic/reg-ID will participate.
A proxy source will be elected only if a quorum of Stores
participate.

Algorithm 2 was introduced in UM version 6.15 to help customers who need
to perform an un-recommended Store restart procedure whereby the state and
cache files are deleted before restarting.
Informatica recommends retaining the state and cache files over a restart,
but we also understand that sometimes it is unavoidable and a Store
must be started "clean" (for example, if a disk fails).

Creating a proxy source for a particular topic/reg-ID that does
not have a quorum of repositories is contrary to the general design
of UM persistence.
Selecting algorithm 2 conforms with the UM persistence design.

\m4_s2 proactiveretransmissions Proactive Retransmissions

Proactive Retransmissions, which is enabled by default, address two types
of loss:

<ul>
<li>loss of message data between the source and a Store

<li>loss of stability acknowledgments (ACK) between the Store and the source
</ul>

The Store sends message stability acknowledgments to the source after the
Store persists the message data.

With Proactive Retransmissions, the source maintains an unstable message
queue for those messages sent but not acknowledged by the Store.
The source checks this queue at the \ref umemessagestabilitytimeoutsource.
If a message in this queue exceeds its \ref umemessagestabilitytimeoutsource,
the source retransmits the message and puts it back on the unstabilized
message queue, restarting the message's \ref umemessagestabilitytimeoutsource.

The source continues to retransmit and check the message's stability
timeout until the \ref umemessagestabilitylifetimesource expires or it
receives a stability acknowledgment from the Store.
If the source has not received a stability acknowledgment when the
\ref umemessagestabilitylifetimesource expires, the source sends a
Store Message Not Stable source event notification to the application.
When the Store discards the message because it has not met stability
requirements, the Store sends a Store Forced Reclaim source event
notification to the application.

To disable Proactive Retransmissions, set \ref umemessagestabilitytimeoutsource
to 0 (zero).
As a result, sources do not create an unstable message queue.

The following applies whether you enable or disable Proactive Retransmissions.

<ul>
<li>The Store does not discard duplicate messages, but rather always responds
to duplicate, retransmitted messages by sending stability acknowledgments even
if the message is already stable.

<li>If the Store has marked the message unrecoverably lost and receives a
duplicate message from the source, the Store sends the source a negative
stability acknowledgment (NAK), which induces the source to remove the
message from its unstabilized message queue.
A stability NAK is identical to a stability ACKs except that it has a NAK
flag set.
</ul>

\m4_pg configuringforpersistenceandrecovery Configuring for Persistence and Recovery

Deployment decisions play a huge role in the success of any persistent system.
Configuration in UM has a number of options that aid in performance,
fault recovery, and overall system stability.
It is not possible, or at least not wise, to totally divorce configuration
from application development for high performance systems.
This is true not only for persistent systems, but for practically all
distributed systems.
When designing systems, deployment considerations need to be taken into
account for the following:

<ul>
<li>\ref sourceconsiderations.

<li>\ref receiverconsiderations.

<li>\ref storeconfigurationconsiderations.
</ul>

\m4_s1 sourceconsiderations Source Considerations

Performance of sources is heavily impacted by:

<ul>
<li>The \ref releasepolicy that the source uses,

<li>Streaming methods of the source,

<li>The throughput and latency requirements of the data.
</ul>

Source release settings have a direct impact on memory usage.
As messages are retained, they consume memory. You reclaim memory when you
release messages. Message stability, delivery confirmation and retention
size all interact to create your release policies.
UM provides a hard limit on the memory usage.
When exceeded, UM delivers a Forced Reclamation event.
Thus applications that anticipate forced reclamations can handle them
appropriately. See also \ref sourcemessageretentionandrelease.

How the source streams data has a direct impact on latency and throughput.
One streaming method sets a maximum, outstanding count of messages.
Once reached, the source does not send any more until message stability
notifications come in to reduce the number of outstanding messages.
The umesrc example program uses this mechanism to limit the speed of a
source to something a Store can handle comfortably.
This also provides a maximum bound on recovery that can simplify handling
of streaming source recovery.

The throughput and latency requirements of the data are normal UM concerns.

\m4_s1 receiverconsiderations Receiver Considerations

In addition to the following, receiver performance shares the same
considerations as receivers during normal operation.

\m4_s2 receiveracknowledgementgeneration Receiver Acknowledgement Generation

Persistent receivers send a message consumption acknowledgement to Stores
and the message source.
Some applications may want to control this acknowledgement explicitly
themselves. In this case, \ref umeexplicitackonlyreceiver can be used.

\m4_s2 controllingretransmission Controlling Retransmission

Receivers send retransmission requests and receive and process retransmissions.
Control over this process is crucial when handling very long recoveries,
such as hundreds of thousands or millions of messages.
A receiver only sends a certain number of retransmission requests at a time.

This means that a receiver will not, unless configured to with
\ref retransmitrequestoutstandingmaximumreceiver, request everything at once.
The value of the low sequence number (\ref persistentreceiverrecovery) has
a direct impact on how many requests need to be handled.
A receiving application can decide to only handle the last X number of
messages instead of recovering them all using the option,
\ref retransmitrequestmaximumreceiver.
The timeout used between requests, if the retransmission does not arrive,
is totally controllable with \ref retransmitrequestintervalreceiver.
And the total time given to recover all messages is also controllable.

\m4_s2 receiverrecoveryprocess Receiver Recovery Process

Theoretically, receivers can handle up to roughly 2 billion messages during
recovery.
This limit is implied from the sequence number arithmetic and not from any
other limitation.
For recovery, the crucial limiting factor is how a receiver processes and
handles retransmissions which come in as fast as UM can request them and a
Store can retransmit them.
This is perhaps much faster than an application can handle them.
In this case, it is crucial to realize that as recovery progresses,
the source may still be transmitting new data.
This data will be buffered until recovery is complete and then handed to
the application.
It is prudent to understand application processing load when planning on
how much recovery is going to be needed and how it may need to be
configured within UM.

\m4_s1 storeconfigurationconsiderations Store Configuration Considerations

Stores have numerous configuration options.
See \ref configurationreferenceforumestored for details.

\m4_s2 configuringstoreusagepersource Configuring Store Usage per Source

A Store handles persisted state on a per topic per source basis. Based on
the load of topics and sources, it may be prudent to spread the topic space,
or just source space, across Stores as a way to handle large loads.
As configuration of Store usage is per source, this is extremely easy to do.
It is easy to spread CPU load via multi-threading as well as hard disk
usage across Stores.
A single Store Process can have a set of Store instances within it,
each with their own thread.

\m4_s2 memoryusebystores Memory Use by Stores

As mentioned previously in \ref persistentstoreconcept, Stores can
be memory based or disk based.
Disk Stores also have the ability to spread hard disk usage across multiple
physical disks by using multiple Store instances within a single Store Process.
This gives great flexibility on a per source basis for spreading data
reception and persistent data load.

Stores provide settings for controlling memory usage and for caching
messages for retransmission in memory as well as on disk.
All messages in a Store, whether in memory or on disk, have some small
memory state.
This is roughly about 72 bytes per message.
For very large caches of messages, this can become non-trivial in size.

\m4_s2 activitytimeouts Activity Timeouts

Stores are NOT archives and are not designed for archival.
Stores persist source and receiver state with the aim of providing message
recovery in the event of a fault.
Central to this is the concept that a source or receiver has an activity
timeout attached to it.
Once a source or receiver suspends operation or has a failure,
it has a set time before the Store will forget about it.
This activity timeout needs to be long enough to handle the recovery
demands of sources and receivers.
However, it can not and should not be infinite. Each source takes up memory
and disk space, therefore an appropriate timeout should be chosen that
meets the requirements of recovery, but is not excessively long so that
the limited resources of the Store are exhausted.

\m4_s2 recommendationsforstoreconfiguration Recommendations for Store Configuration

<ul>
<li>Number of Stores in the \ref quorumconsensusstorefailover "QC group".
Informatica recommends a minimum of 3 Stores.
A publisher defines the QC Store QC group using the LBM configuration option
\ref umestoresource.
This option is specified multiple times to define the 
desired number of Stores in the QC group.

<li>Flight Size - Maximum number of messages sent but not stable in a quorum
of Stores.
The publishing application should not exceed the flight size.
See \ref persistenceflightsize for configuration details.

<li>\ref offtransportrecoveryotr.
Informatica recommends that Stores be configured to use OTR to recover lost messages
from the Source.
Note that the default for \ref useotrreceiver is "2",
which does NOT enable OTR for the Store.
Informatica recommends setting "use_otr" to 1 in the Store's LBM configuration file.

<li>\ref proactiveretransmissions.
Informatica recommends that persistent sources use proactive retransmission to
ensure message stability.
See \ref umemessagestabilitytimeoutsource (on by default).

<li>\ref burstloss1.
Informatica strongly recommends disabling "burst loss" by setting
the LBM configuration option \ref deliverycontrolmaximumburstlossreceiver
to a very large number, perhaps 10000000.
This should be done for both the Store's LBM configuration and for the
subscriber's LBM configuration.

<li>\ref persistencebuffersizes.
Informatica recommends performing an analysis of expected publisher
data rates and worst-case data repair times to properly size the
Store's retention buffer and the source's retention buffer (late join buffer).
See \ref persistencebuffersizes.

</ul>

\m4_s2 storeconfigurationpracticestoavoid Store Configuration Practices to Avoid

Informatica recommends against the following Store configuration practices:

<ul>
<li>\ref burstloss1 must be disabled in Stores and
persistent receivers.
Set \ref deliverycontrolmaximumburstlossreceiver to a very large
number (1000000).

<li>Multiple Store QC groups require special attention.
Please <a href="https://ultramessaging.github.io/UM_Support.html">contact UM Support</a> before using.
</ul>

\m4_pg manpagesforstore Man Pages for Store

Persistent Store services are provided by Store Process.

There are two executables for the Store, each with it's own man page:
<ul>
<li>\ref umestoredmanpage - Unix and Windows command-line interface.
<li>\ref umestoredsmanpage - Windows Service interface.
</ul>

\m4_s1 umestoredmanpage Umestored Man Page

Unix and Windows command-line interface.

\verbatim
m4_include([[[umestored.usage]]])
\endverbatim

\par Description
The `umestored` command (the final "d" stands for "daemon") runs the Store Process.
It can be run interactively from a shell or command prompt,
or from a script or batch file.
(For use as a Windows Service, see \ref umestoredsmanpage.)

\par
The <b>"configfile"</b> parameter is required and specifies the file path
for the Store configuration file.
See \ref configurationreferenceforumestored for configuration details.

\par
The <b>"-f"</b> option directs a Unix-based `umestored` to fork a child process
which detaches from the controlling terminal.
The `umestored` command normally remains attached to the controlling
terminal and runs until interrupted.
With <b>"-f"</b>, the `umestored` command exits back to the shell,
and the forked child continues running in the background.

\par
The <b>"-a"</b> option provides the CPU core affinity for Store threads.
This "pins" the threads to one or more desired CPU cores,
which can provide a significant improvement in throughput.
See \ref storethreadaffinity for details.

\par
The <b>"-d"</b> option dumps (prints) the Store's XML DTD to standard output.
After dumping the DTD, `umestored` exits.

\par
The <b>"-u"</b> option tells the Store to format its
log file timestamps as UTC.

\par
The <b>"-v"</b> option validates the XML structure of the given configuration file
against the Store's XML DTD.
After validating the configuration file's XML structure,
`umestored` exits with status 0 for no errors, 
or non-zero if errors were found.
For example:
\verbatim
umestored -v /um/store1_cfg.xml
\endverbatim

\par
Note that valid XML structure does not guarantee that the configuration
file is completely correct.
It must be tested on a running Store.

\par
The <b>"-h"</b> option prints the man page and exits.

\par \b Exit \b Status
The exit status from `umestored` is 0 for success and some non-zero value for
failure.

\par \b Usage \b Notes
When shutting down a Unix-based UM Persistent Store process,
use a SIGINT to trigger a clean shutdown,
which attempts to cleanly finish outstanding IO requests
before shutting down.
Two successive SIGINTs force an immediate shutdown (not recommended unless
absolutely necessary).

\m4_s1 umestoredsmanpage Umestoreds Man Page

Windows Service interface.
See \ref umdaemonsaswindowsservices for general information about UM
daemons as Windows Services.

\verbatim
m4_include([[[umestoreds.usage]]])
\endverbatim

\par \b Description
The `umestoreds` command has two functions:
<ul>
<li>First, it lets the user supply Windows Service operating parameters,
which the command saves into the Windows registry.
Those operating parameters are subsequently used by the Store Service.
See \ref configurethewindowsservice.
<li>Second, it provides Windows with the Store Process executable to run
as a Service.
</ul>

\par
The <b>"configfile"</b> parameter provides the file path
for the Store configuration file.
It is supplied in conjunction with the <b>"-v"</b> option or the
<b>"-s config"</b> option (see below).
See \ref configurationreferenceforumestored for configuration details.

\par
For <b>"-s install"</b> see \ref installthewindowsservice.

\par
For <b>"-s remove"</b> see \ref removethewindowsservice.

\par
For <b>"-s config"</b>, <b>"-e"</b>, <b>"-E"</b>, and <b>"-U"</b>,
see \ref configurethewindowsservice.

\par
The <b>"-a"</b> option specifies the CPU core affinity for Store threads,
which is saved in the Windows registry and subsequently
by the Windows Service.
This "pins" the threads to one or more desired CPU cores,
which can provide a significant improvement in throughput.
See \ref storethreadaffinity for details.

\par
The <b>"-d"</b> option dumps (prints) the Store's XML DTD to standard output.
After dumping the DTD, `umestoreds` exits.

\par
The <b>"-v"</b> option validates the XML structure of the given configuration
file against the Store's XML DTD.
After validating the configuration file's XML structure,
`umestoreds` exits with status 0 for no errors,
or non-zero if errors were found.
For example:
\verbatim
umestoreds -v c:\um\store1_cfg.xml
\endverbatim

\par
Note that valid XML structure does not guarantee that the configuration
file is completely correct.
It must be tested on a running Store.

\par
The <b>"-h"</b> option prints the man page and exits.

\par \b Exit \b Status
The exit status from `umestored` is 0 for success and some non-zero value for
failure.

\par \b Usage \b Notes
When installing the UM Persistent Store as a Microsoft Windows service,
use only local disk devices and fully qualified path names for all filenames.
This is because Windows services run by default under a Local System account,
which has reduced privileges and is not allowed access to network devices.

\par
Stopping the UM Persistent Store service triggers a clean shutdown,
which attempts to cleanly finish outstanding IO requests before shutting down.

\attention Do not use the task manager or the "kill" command
to stop a UM daemon running as a Windows service.
Use the Windows service control panel to stop the service.
In particular, if the persistent Store is killed non-gracefully,
it can leave its files in an inconsistent state.

\m4_pg configurationreferenceforumestored Configuration Reference for Umestored

The operating parameters for `umestored` come from a Store configuration file
that must be supplied on the command line (see \ref manpagesforstore).
A Store Process contains a UM context and receivers that may be configured with
default values through an LBM configuration file referenced in the XML
configuration file.
Default UM options my be overridden for each configured Store using the Store
configuration file.

An overview of the file format can be seen in the
\ref umestoredconfigurationdtd.

You configure `umestored` to instantiate Stores with the Store
configuration file, which Ultra Messaging reads at start up.

The Store configuration file for persistence has the following sections:

<ul>
<li>Daemon section - holds administrative parameters for such things as the
location of log files, the LBM Configuration File, etc.

<li>Stores section - holds parameters for any Persistent Stores and also
the topics to be persisted.
</ul>

<b>High Level Store Configuration File:</b>

\code
<ume-store version="1.3">
  <daemon>
    Daemon configuration options
  </daemon>
  <stores>
    <store attributes>
      <topics>
        <topic attributes>
          <ume-attributes>
            <option attributes/>
          </ume-attributes>
        </topic>
      </topics>
    </store>
  </stores>
</ume-store>
\endcode

\m4_s1 mergingmultiplestorexmlconfigurationfiles Share/Merge Store XML Files with XInclude

The XInclude mechanism can be used to merge or share XML files for UM library
configuration, Store configuration, and DRO configuration.
This is typically done to avoid duplicating groups of configuration options in
multiple places.

To include an external file from a Store configuration file, use the following syntax:

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
  <option type="store" name="repository-type" value="disk"/>
  <option type="store" name="repository-size-threshold" value="75,000,000"/>
  <option type="store" name="repository-size-limit" value="100,000,000"/>
...
\endcode

Example of <b>valid</b> file:

\code
<ume-attributes>
  <option type="store" name="repository-type" value="disk"/>
  <option type="store" name="repository-size-threshold" value="75,000,000"/>
  <option type="store" name="repository-size-limit" value="100,000,000"/>
...
</ume-attributes>
\endcode

\m4_s2 commonstorexincludeusecase Common Store XInclude Use Case

Store configuration files do not support templates.
It is common that groups of configuration options
need to be repeated across many Store configurations.

For example consider the Store configuration
file "store_conf.xml":

\code
  <stores>
    <store name="store-a1" port="14570">
...
      <topics>
        <topic pattern="matching.output\.[0-9]$" type="PCRE">
          <ume-attributes>
            <option type="store" name="repository-type" value="disk"/>
            <option type="store" name="repository-size-threshold" value="75,000,000"/>
            <option type="store" name="repository-size-limit" value="100,000,000"/>
...
          </ume-attributes>
        </topic>
      </topics>
    </store>

    <store name="store-a2" port="14571">
...
      <topics>
        <topic pattern="matching.output\.[0-9]$" type="PCRE">
          <ume-attributes>
            <option type="store" name="repository-type" value="disk"/>
            <option type="store" name="repository-size-threshold" value="75,000,000"/>
            <option type="store" name="repository-size-limit" value="100,000,000"/>
...
          </ume-attributes>
        </topic>
      </topics>
    </store>
...
\endcode

This can be a lot of repeated content for the stores running in this daemon instance.

The XInclude feature can be used to reduce duplicate content by
creating a second file "store_topic_attr.xml":

\code
<ume-attributes>
  <option type="store" name="repository-type" value="disk"/>
  <option type="store" name="repository-size-threshold" value="75,000,000"/>
  <option type="store" name="repository-size-limit" value="100,000,000"/>
...
</ume-attributes>
\endcode

Now "store_conf.xml" can be coded as:

\code
  <stores>
    <store name="store-a1" port="14570">
...
      <topics>
        <topic pattern="matching.output\.[0-9]$" type="PCRE">
          <xi:include xmlns:xi="http://www.w3.org/2001/XInclude" href="./store_topic_attr.xml" />
        </topic>
      </topics>
    </store>

    <store name="store-a2" port="14571">
...
      <topics>
        <topic pattern="matching.output\.[0-9]$" type="PCRE">
          <xi:include xmlns:xi="http://www.w3.org/2001/XInclude" href="./store_topic_attr.xml" />
        </topic>
      </topics>
    </store>
...
\endcode

\m4_s1 storexmlconfigurationfileelements Store XML Configuration File Elements

m4_ifdef([[[comment]]], [[[
# Convert the following text into XML documentation.
]]])m4_dnl
m4_syscmd([[[cat <<__EOF__ >ume_config_descr.txt
# Descriptions and examples of IDs defined in lbm.xsd
# Inside this section of the document (until the EOF), all back quote
# characters need to be escaped with backslash. This is because the
# text is passed to the shell as a "here-is" document, which does
# shell substitution. 

# Name added to each section title
%component UMP

# anchor prefix is for link names.
%anchor_prefix umeelement

# List the top-level elements to doc.
%top ume-store

###

Container element that holds the configuration for the Persistent Store
Process.
Also defines the version of the configuration format used by the file.
%descr ume-store

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  ...
</ume-store>
\endcode
%example ume-store

Version number of Store XML DTD that the configuration file corresponds to.
See \ref umestoredconfigurationdtd for a description of the different versions.
Users are encouraged to update their Store configuration files to correspond
to the latest version supported by the Store software in use.
%descr ume-store.version

(no default; must be specified)
%default ume-store.version

###

Container element for configuration elements that apply to the entire
Store Process.
%descr daemon

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    ...
  </daemon>
  ...
</ume-store>
\endcode
%example daemon

###

Container element for one or more \ref umeelementstore "<store>" elements.
A Store Process can run multiple independent Store instances.
Some users prefer to run multiple Store instances in a single process
to reduce their process management complexity.
Other users prefer to run multiple Store Processes, each with a single
Store instance, to reduce the impact of a Store Process failing.

There should be little or no performance difference between multiple
Store instances running in the same process vs. multiple Store Processes
on the same host.
However, for maximum Store performance, it is generally easier to pin
Store threads to cores when each process is running a single Store instance.

It is NOT recommended for multiple Stores within a QC group to run
in the same process, or even the same host,
as this defeats the goal of reliability through redundancy.
%descr stores

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example stores

###

Configuration for a Store instance.
%descr store

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example store

Identifies log messages for this Store instance in the Store Process log file,
the Store Web Monitor, and Daemon Stats.
Note: this is not the name that sources can use instead of a network address
(see the \ref umecfgcontextname "context-name" option).
%descr store.name

(no default; must be specified)
%default store.name

Specifies the IP address over which Store Process accepts
connection requests for this Store. You can specify a single IP address,
such as 10.29.3.16, or a range of addresses, 10.29.3.16/25.
See also \ref identifyingpersistentstores.
%descr store.interface

0.0.0.0 (INADDR_ANY)
%default store.interface

TCP port where Store Process should listen for connection
requests to this Store.
Starting with UM version 6.8, zero may be supplied.
In that case, the Store will choose an available port in the range
\ref requesttcpportlowcontext to \ref requesttcpporthighcontext.
This typically requires the use of \ref namedstores "named stores".
%descr store.port

(no default; must be specified)
%default store.port

###

Container for \ref umeelementtopic "<topic>" elements.
Defines the topics that this Store instance will persist.
%descr topics

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <topics>
        ...
      </topics>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example topics

###

Defines a topic pattern which the Store will use to find sources
to persist.
Also contains configuration information about those topics.
%descr topic

\b Example:

In this example, the topic "NYSE.xyz" and all topics that start with "alert."
are persisted in the "MyStore1" Store instance.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <topics>
        <topic pattern="NYSE.xyz" type="direct">
          ...
        </topic>
        <topic pattern="^alert\..*" type="pcre">
          ...
        </topic>
        ...
      </topics>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example topic

A string that is used to discover sources to be persisted.
The string can be a simple topic name (\`type="direct"\`),
or it can be a regular expression (\`type="pcre"\`) which can match more than
one topic.
%descr topic.pattern

(no default; must be specified)
%default topic.pattern

How the \`pattern\` attribute should be interpreted.
%descr topic.type

\b direct
%default topic.type

Topic name (exact string match)
%descr topic.type.direct

Perl regular expression.
%descr topic.type.PCRE

Posix regular expression.
<b>Deprecated; do not use.</b>
%descr topic.type.regexp

Container for a set of \ref umeelementoption "<option>" elements.
%descr ume-attributes

\b Example:

In this example, some options are at the Store level and apply to
all topics.
Other options are specific to the topic "NYSE.xyz".
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <ume-attributes>
        ...
      </ume-attributes>
      <topics>
        <topic pattern="NYSE.xyz" type="direct">
          <ume-attributes>
            ...
          </ume-attributes>
          ...
        </topic>
        ...
      </topics>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example ume-attributes

###

Set a configuration option of a particular type.

This element is used to set most of the operational parameters
of the Store and its repositories.

There are many different options that can be set.
See \ref optionsforastoresumeattributeselement
for the full list.

An option element has a type attribute.
The valid types depend on whether the option's ancestor element is
"<store>" or "<topic>":
<table>
<tr><th>Ancestor <th>Valid <tt>type</tt> Attributes
<tr><td>\ref umeelementstore "<store>" <td>type="store"<br>type="lbm-context"
<tr><td>\ref umeelementtopic "<topic>" <td>type="store"<br>type="lbm-receiver"<br>type="lbm-source"
</table>
%descr option

\b Example:

\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <ume-attributes>
        <option type="..." name="..." value="..."/>
        ...
      </ume-attributes>
      <topics>
        <topic pattern="NYSE.xyz" type="direct">
          <ume-attributes>
            <option type="..." name="..." value="..."/>
            ...
          </ume-attributes>
          ...
        </topic>
        ...
      </topics>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example option

Type of configuration option.
%descr option.type

(no default; must be specified)
%default option.type

LBM configuration option of scope "receiver".
%descr option.type.lbm-receiver

LBM configuration option of scope "source".
%descr option.type.lbm-source

LBM configuration option of scope "context".
%descr option.type.lbm-context

Store configuration option.
%descr option.type.store

Name of option.
%descr option.name

(no default; must be specified)
%default option.name

Value for option.
%descr option.value

(no default; must be specified)
%default option.value

Control how much saved message data is restored when
a disk-based Store is restarted.

By default,
when a disk-based Store is stopped and restarted,
it will restore all messages in the cache file to
rebuild its internal index.
If the cache file is very large,
this can take significant time.

Using this element,
you can direct the Store to read only recent data.
Note that it can be specific to a Store,
or a topic within a Store.

If this element is supplied in both the "<store>"
and "<topic>" levels, the "<topic>" setting will
override the "<store>" setting.

See \ref limitinitialrestore for use case.
%descr restore-last

\b Example: on restart, only restore the most recent 8 hours worth of messages.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
...
  <stores>
    <store name="test-store" port="14567">
      <restore-last value="8" behavior="hours"/>
      ...
    </store>
  </stores>
</ume-store>
\endcode
%example restore-last

Number of units worth of message data to restore.
The units are defined by the "behavior" attribute.

For units of "hours", the valid range is 0 - 336 (14 days).

The special value "0" disables the feature,
resulting in the entire cache file being restored.
%descr restore-last.value

\b 0 (disable)
%default restore-last.value

Define how the <i>value</i> attribute is interpreted.
%descr restore-last.behavior

Directs the Store to restore the most recent <i>value</i> number of hours worth of
message data.
<b>NOTE:</b> the message time is relative to the last
(most recent) message in the cache,
<i>not</i> the absolute time that the Store is restarted.
For example, if the store is restarted on Sunday,
but the most-recent message was sent the previous Friday afternoon,
then <i>value</i> hours worth of messages sent on Friday will be restored.
%descr restore-last.behavior.hours

Directs the Store to ignore <i>value</i>, disabling the feature,
resulting in the entire cache file being restored.
%descr restore-last.behavior.none

\b hours
%default restore-last.behavior

DEPRECATED:
Set how often the Store publishes its Daemon Stats.
See \ref daemonstatistics for general information on Daemon Statistics.

Informatica requests users to migrate to using the UM configuration file 
to enable automatic monitoring with Protocol Buffer monitoring format for 
Store and DRO by setting \ref monitorformatcontext to "pb".
See \ref automaticmonitoring.
%descr publishing-interval

\b Example:

Daemon Statistics are configured at both the daemon level and at the
Store level.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <daemon-monitor topic="bozo">
      <publishing-interval>
        ...
      </publishing-interval>
    </daemon-monitor>
  </daemon>
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <publishing-interval>
        ...
      </publishing-interval>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example publishing-interval

###

Configures the rate at which one particular grouping of Daemon Statistics
messages are published.
See \ref daemonstatistics for general information on Daemon Statistics.
%descr group

\b Example:

Daemon Statistics are configured at both the daemon level and at the
Store level.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <daemon-monitor topic="bozo">
      <publishing-interval>
        <group name="default" ivl="10"/>
        <group name="store" ivl="20"/>
        ...
      </publishing-interval>
    </daemon-monitor>
  </daemon>
  <stores>
    <store name="MyStore1" interface="10.1.2.3" port="12000">
      <publishing-interval>
        <group name="default" ivl="10"/>
        <group name="store" ivl="20"/>
        ...
      </publishing-interval>
      ...
    </store>
    ...
  </stores>
  ...
</ume-store>
\endcode
%example group

Name of statistics group being configured.
%descr group.name

(no default; must be specified)
%default group.name

Sets a default interval for all message types.
%descr group.name.default

Sets the interval for messages of type
\ref umestore_store_dmon_stat_msg_t.
%descr group.name.store

Sets the interval for messages of type \ref umestore_repo_dmon_stat_msg_t.
%descr group.name.source

Sets the interval for messages of type \ref umestore_rcv_dmon_stat_msg_t.
%descr group.name.receiver

Sets the interval for messages of type \ref umestore_disk_dmon_stat_msg_t.
%descr group.name.disk

Sets the interval for messages of types umestore_*_dmon_config_msg_t.
%descr group.name.config

Sets the interval for messages of type umestore_smart_heap_dmon_stat_msg_t.
%descr group.name.memory

Time, in seconds, between publishing the statistics group being configured.
%descr group.ivl

(no default; must be specified)
%default group.ivl

DEPRECATED:
The daemon-monitor element configures the Store Process for
\ref storedaemonstatistics.

Informatica requests users to migrate to using the UM configuration file 
to enable automatic monitoring with Protocol Buffer monitoring format for 
Store and DRO by setting \ref monitorformatcontext to "pb".
See \ref automaticmonitoring.
%descr daemon-monitor

\b Example:

Daemon Statistics are configured at both the daemon level and at the
Store level.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <daemon-monitor topic="bozo">
      <publishing-interval>
        ...
      </publishing-interval>
    </daemon-monitor>
  </daemon>
  ...
</ume-store>
\endcode
%example daemon-monitor

Topic name for used to publish daemon statistics.
%descr daemon-monitor.topic

umestore.monitor
%default daemon-monitor.topic

Controls if the daemon will respond to requests from monitoring applications.
See \ref daemoncontrolrequests for general information,
\ref storedaemoncontrolrequests for Store-specific requests.

\warning If misused, 
the Daemon Control Requests feature allows a user to interfere with
the messaging infrastructure in potentially disruptive ways.
By default, this feature is disabled. 
However, especially if you have enabled
the \ref umeelementremoteconfigchangesrequest,
Informatica recommends \ref securingdaemoncontrolrequests.
%descr remote-config-changes-request

\b Example:

Daemon Statistics are configured at both the daemon level and at the
Store level.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <daemon-monitor topic="bozo">
      <remote-config-changes-request allow="1"/>
        ...
      </publishing-interval>
    </daemon-monitor>
  </daemon>
  ...
</ume-store>
\endcode
%example remote-config-changes-request

Enables handling requests.
%descr remote-config-changes-request.allow

0
%default remote-config-changes-request.allow

Enable request handling.
%descr remote-config-changes-request.allow.1

Disable request handling.
%descr remote-config-changes-request.allow.0

Controls if the daemon will respond to requests from monitoring applications.
See \ref daemoncontrolrequests.
%descr remote-snapshot-request

\b Example:

Daemon Statistics are configured at both the daemon level and at the
Store level.
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <daemon-monitor topic="bozo">
      <remote-snapshot-request allow="1"/>
        ...
      </publishing-interval>
    </daemon-monitor>
  </daemon>
  ...
</ume-store>
\endcode
%example remote-snapshot-request

Enables handling requests.
%descr remote-snapshot-request.allow

0
%default remote-snapshot-request.allow

Enable request handling.
%descr remote-snapshot-request.allow.1

Disable request handling.
%descr remote-snapshot-request.allow.0

Pathname for LBM configuration file to be used when the Store
creates UM objects (context, receivers, sources).

When used as a child element of \ref umeelementdaemonmonitor "<daemon-monitor>",
configures the UM objects used for publishing \ref storedaemonstatistics.

Note that starting with UM version 6.13,
if one or more errors are discovered in the LBM configuration file,
the errors are written to the log file and the Store continues running.
I.e. errors in the LBM configuration file are treated as warnings.
See \ref configurationerrorhandling for an explanation.
%descr lbm-config

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <lbm-config>/etc/ump/store0.cfg</lbm-config>
    ...
    <daemon-monitor topic="bozo">
      <lbm-config>/etc/ump/store0_dmon.cfg</lbm-config>
      ...
    </daemon-monitor>
  </daemon>
  ...
</ume-store>
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

Address and port for the Store web-based monitor.
Format is "Address:Port", where "Address" is either an IP address of
one of the host's interfaces, or is "*" which allows the use of any
interface.
See \ref storewebmonitor for more information.

If omitted, the web monitor is disabled.
%descr web-monitor

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <web-monitor>*:8080</web-monitor>
    ...
  </daemon>
  ...
</ume-store>
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

Pathname for UM license file.
NOTE: starting with UM version 6.8, a license key is no longer required for Store operation.
This element is retained for backwards compatibility.
%descr lbm-license-file

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

\anchor xmlconfigtag
Pathname for LBM configuration file (in XML format) to be used when the Store
creates UM objects (context, receivers, sources).
I.e. options that control the UM library.

See \ref xmlconfigurationfiles for general information on XML-based LBM
configuration files.

See also \ref umeelementlbmconfig "<lbm-config>".
%descr xml-config

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <xml-config>/etc/ump/store01_um.xml</xml-config>
    ...
  </daemon>
  ...
</ume-store>
\endcode
%example xml-config

Allows the user to select an "application name" for the Store Process,
which can then used by the LBM XML configuration file to 
target a configuration to that Store using \ref umelementapplication.

See \ref xmlapplicationnames for more information on application names.
%descr xml-config.application-name

umestored
%default xml-config.application-name

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

Specifies a Group ID (GID) for daemon process (if run as root).
%descr gid

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <gid>1234</gid>
    ...
  </daemon>
  ...
</ume-store>
\endcode
%example gid

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr gid.xml:space

Trim whitespace.
%descr gid.xml:space.default

Retain whitespace exactly as entered.
%descr gid.xml:space.preserve

\b default
%default gid.xml:space

###

Contains the pathname for daemon process ID (PID) file.
%descr pidfile

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <pidfile>/var/run/store01.pid</pidfile>
    ...
  </daemon>
  ...
</ume-store>
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

Specifies a User ID (UID) for daemon process (if run as root).
%descr uid

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <uid>1234</uid>
    ...
  </daemon>
  ...
</ume-store>
\endcode
%example uid

Specifies how whitespace (tabs, spaces, linefeeds) are handled in the
element content.
See \ref xmlspaceattribute.
%descr uid.xml:space

Trim whitespace.
%descr uid.xml:space.default

Retain whitespace exactly as entered.
%descr uid.xml:space.preserve

\b default
%default uid.xml:space

###

Contains the path name of the Store log file.
See \ref storerollinglogs for more information.

If omitted, log messages are written to standard output.
%descr log

\b Example:
\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <log type="file" size="23" frequency="daily">/var/log/store01.log</log>
    ...
  </daemon>
  ...
</ume-store>
\endcode
%example log

Where to write log messages.
%descr log.type

Write log messages to a file.
%descr log.type.file

Write log messages to standard output.
%descr log.type.console

console
%default log.type

Time-frame by which to roll the log file.
%descr log.frequency

Do not roll the log file based on time.
%descr log.frequency.disable

Roll the log file at midnight.
%descr log.frequency.daily

Roll log file after approximately an hour,
but is not exact and can drift significantly over a period of time. 
%descr log.frequency.hourly

For internal Informatica use only.
Do not use.
%descr log.frequency.test

disable
%default log.frequency

Size (in MB, i.e. 2**20, or 1,048,576) of current log file at which it
is rolled. Specify 0 to disable rolling by log file size.
%descr log.size

10
%default log.size

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
m4_esyscmd([[[../share/xsd_doc.pl -d ume_config_descr.txt ume.xsd]]])m4_dnl

\m4_s1 umestoredconfigurationdtd umestored Configuration DTD

The DTD for UM Store configuration has evolved over time:

<table>
<tr><th>DTD Version <th>Release Date <th>Product Version <th>Supported Features
<tr><td>1.0 <td>Feb. 2007 <td>UME 1.0 <td>Persistent Stores
<tr><td>1.1 <td>April 2010 <td>UME 3.0.1 / UMQ 1.0 <td>Persistent Stores,
Queues and Ultra Load Balancing (ULB)
<tr><td>1.2 <td>March 2011 <td>UME 3.2 / UMQ 2.1 <td>Persistent Stores,
Queues, Ultra Load Balancing (ULB), Dead Letter Queue, Indexed Queuing and
Indexed ULB
<tr><td>1.3 <td>November 2016 <td>UM 6.10 <td>Addition of '`<xml-config>`'
element (under '`<daemon>`').
</table>

To assist the user with upgrades,
a more-recent version of the Store will accept an older version of
the Store configuration file.
For example, if your Store configuration file starts with this:
\code
<?xml version="1.0"?>
<ume-store version="1.0">
\endcode
the Store will parse the file according to DTD 1.0.
If you wish to use Store configuration settings that were not available in 1.0,
you will need to upgrade to a later DTD version.
<a href="https://ultramessaging.github.io/UM_Support.html">Contact UM Support</a> if you have trouble.

Here is the current DTD version:

\code
m4_include([[[ume.dtd]]])
\endcode

\m4_s1 storeconfigurationexample Store Configuration Example

Store Process with one Store.

\code
<?xml version="1.0"?>
<ume-store version="1.3">
  <daemon>
    <log>stored.log</log>
    <pidfile>stored.pid</pidfile>
    <web-monitor>*:15304</web-monitor>
  </daemon>

  <stores>
    <store name="test-store" port="14567">
      <ume-attributes>
        <option type="store" name="disk-cache-directory" value="cache"/>
        <option type="store" name="disk-state-directory" value="state"/>
        <option type="store" name="context-name" value="remote-store"/>
      </ume-attributes>
      <topics>
        <topic pattern="test.*" type="PCRE">
          <ume-attributes>
            <option type="store" name="repository-type" value="disk"/>
            <option type="store" name="repository-size-threshold" value="2048"/>
            <option type="store" name="repository-size-limit" value="209715200"/>
            <option type="store" name="repository-disk-file-size-limit" value="1073741824"/>
            <option type="store" name="source-activity-timeout" value="120000"/>
            <option type="store" name="receiver-activity-timeout" value="120000"/>
            <option type="store" name="retransmission-request-forwarding" value="0"/>
          </ume-attributes>
        </topic>
      </topics>
    </store>
  </stores>
</ume-store>
\endcode

\anchor optiontypesforumeattributeselements
\m4_pg optionsforastoresumeattributeselement "<option>" Element Details

The \ref umeelementoption "<option>" element is the primary construct for
setting Store configuration options.
It always appears inside a \ref umeelementumeattributes "<ume-attributes>"
block, which can appear in two places of your Store configuration file:
the \ref umeelementstore "<store>" element,
or the \ref umeelementtopic "<topic>" element.

The \ref umeelementoption "<option>" element is used to set three kinds
of Store configuration options
<ul>
<li>\ref optionsforum, for the underlying UM library.
<li>\ref optionsforatopicsume-attributeselement.
<li>\ref storeoptionsintopicelement.
</ul>

\m4_s1 optionsforum Setting LBM Configuration Options

The \ref umeelementoption "<option>" element can be used to set
LBM configuration options.
I.e. options that control the UM library.
Those options come in different scopes.
For the purposes of the Store, only the "context", "receiver", and "source"
scopes are used, as follows:
\code
<option type="lbm-context" name="context_option_name" value="desired_value"/>
<option type="lbm-receiver" name="receiver_option_name" value="desired_value"/>
<option type="lbm-source" name="source_option_name" value="desired_value"/>
\endcode

But the valid LBM scopes depend on the "<option>" element's ancestor:
<table>
<tr><th>Ancestor <th>Valid LBM <tt>type</tt> Attributes
<tr><td>\ref umeelementstore "<store>" <td>type="lbm-context"
<tr><td>\ref umeelementtopic "<topic>" <td>type="lbm-receiver"<br>type="lbm-source"
</table>

See the
<a href="m4_ifelse(m4_one,[[[1]]],[[[../]]])../Config/index.html">UM Configuration Guide</a>
for the full list of LBM configuration options.

\note Some UM options specify interfaces, which can be done by supplying the
device name of the interface.
Special care must be taken when supplying device names in an XML file.
See \ref interfacedevicenamesandxml for details.

Most Store deployments do not make heavy use of the
\ref umeelementoption "<option>" element to set LBM configuration
parameters.
Instead they use an LBM configuration file
(via the \ref umeelementlbmconfig "<lbm-config>"
or the \ref umeelementxmlconfig element)
for setting most of the desired LBM configuration options.
However, it is often desired to override one or more of those settings
based on an individual Store, or an individual topic within a Store.

<b>Example</b>

In this hypothetical example,
the Store loads a generic project-specific flat LBM configuration file:
\code
...
<daemon>
  <lbm-config>/etc/ump/generic.cfg</lbm-config>
</daemon>
...
\endcode

The file "generic.cfg" sets the
\ref transportlbtrmreceiversocketbuffercontext "receiver-side LBT-RM socket buffer size"
to 4 MB using:
\code
context transport_lbtrm_receiver_socket_buffer 4194304
\endcode

Since we want the Stores to avoid loss as much as possible,
the receive socket buffers should be made large (32 MB):
\code
...
<daemon>
  <lbm-config>/etc/ump/generic.cfg</lbm-config>
</daemon>
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="lbm-context" name="transport_lbtrm_receiver_socket_buffer" value="33554432"/>
    ...
  </ume-attributes>
  ...
</store>
\endcode

Finally, for the specific topic "EventStream",
one might want the initial NAK backoff interval to be longer than for
application receivers.
\code
...
<daemon>
  <lbm-config>/etc/ump/generic.cfg</lbm-config>
</daemon>
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="lbm-context" name="transport_lbtrm_receiver_socket_buffer" value="33554432"/>
    ...
  </ume-attributes>
  <topics>
    <topic pattern="EventStream" type="direct">
      <ume-attributes>
        <option type="lbm-receiver" name="transport_lbtrm_nak_initial_backoff_interval" value="500"/>
        ...
      </ume-attributes>
      ...
    </topic>
  </topics>
  ...
</store>
\endcode

\anchor storeoptions
\m4_s1 optionsforatopicsume-attributeselement Store Options in "<store>" Element

For Store configuration options, the \ref umeelementoption "<option>"
element must appear inside the \ref umeelementstore "<store>" element,
as follows:

\code
<store ...>
  <ume-attributes>
    <option type="store" name="store_option_name" value="desired_value"/>
  </ume-attributes>
</store>
\endcode

For example:
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="disk-cache-directory" value="/cache"/>
    ...
  </ume-attributes>
</store>
\endcode

These options apply to all repositories in this Store instance.

\m4_s2 umecfgdiskcachedirectory Store Option "disk-cache-directory"

Pathname for disk Store message cache directory.
Must be between 1 and 230 characters long.
It is the user's responsibility to create this directory;
the Store will not do so.

<b>Default:</b>
\verbatim
umestored-cache
\endverbatim
The Store looks for a sub-directory by that name in the current working
directory of the stored process.

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="disk-cache-directory" value="/var/ump/cache"/>
    ...
  </ume-attributes>
</store>
\endcode

\m4_s2 umecfgdiskstatedirectory Store Option "disk-state-directory"

Pathname for disk Store state directory.
Must be between 1 and 230 characters long.
It is the user's responsibility to create this directory;
the Store will not do so.

<b>Default</b> 
\verbatim
umestored-state
\endverbatim
The Store looks for a sub-directory by that name in the current working
directory of the Store Process.

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="disk-state-directory" value="/var/ump/state"/>
    ...
  </ume-attributes>
</store>
\endcode

\m4_s2 umecfgallowproxysource Store Option "allow-proxy-source"

Allows the Store to act as a proxy source in
case a registered source terminates.

<b>Default:</b>
\verbatim
0 (Disable)
\endverbatim

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="allow-proxy-source" value="1"/>
    ...
  </ume-attributes>
</store>
\endcode


\m4_s2 umecfgproxysourcerepoquorumrequired Store Option "proxy-source-repo-quorum-required"

Modifies the Store's proxy source election algorithm to
better conform to the general UM persistence design.

See \ref proxysourceelections for details.

<b>Default:</b>
\verbatim
0 (Disable)
\endverbatim

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="allow-proxy-source" value="1"/>
    <option type="store" name="proxy-source-repo-quorum-required" value="1"/>
    ...
  </ume-attributes>
</store>
\endcode

\m4_s2 umecfgcontextname Store Option "context-name"

Name of the Store that can be used by sources to
refer to the Store instead of the address:port.
Restricted to 128 characters in length, and may contain only alphanumeric
characters, hyphens, and underscores.

A Store runs in its own context, so the Store's context name can be used to
identify the Store. UM automatically resolves Store context names, which can
facilitate persistent operation across the \ref umrouter.
Store context names must be unique across the entire network.

See also \ref identifyingpersistentstores

<b>Default:</b>

None (Store must be referenced by address:port).

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="context-name" value="NEWYORK-1"/>
    ...
  </ume-attributes>
</store>
\endcode

\m4_s2 umecfgretransmissionrequestprocessingrate Store Option "retransmission-request-processing-rate"

Specifies the number of
retransmission requests processed by a Store per second across all topics.
The Store drops all retransmission requests that exceed this value.

<b>Default:</b>
\verbatim
262144
\endverbatim

<b>Example:</b>
\code
<store name="MyStore1" interface="10.1.2.3" port="12000">
  <ume-attributes>
    <option type="store" name="retransmission-request-processing-rate"
                         value="524288"/>
    ...
  </ume-attributes>
</store>
\endcode

\m4_s1 storeoptionsintopicelement Store Options in "<topic>" Element

For Store repository configuration options, the \ref umeelementoption "<option>"
element must appear inside the \ref umeelementtopic "<topic>" element,
as follows:

\code
<topic ...>
  <ume-attributes>
    <option type="store" name="store_option_name" value="desired_value"/>
  </ume-attributes>
</topic>
\endcode

For example:
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-type" value="disk"/>
    ...
\endcode

These options apply all repositories for sources that match the
specified topic(s).

\m4_s2 umecfgretransmissionrequestforwarding Topic Option "retransmission-request-forwarding"

If enabled (value="1"),
the Store forwards retransmission requests to sources if and only if the
Store does not have the data.
If disabled (value="0"), the Store services retransmission requests for data
it has, and does not forward requests to sources for data it does not have.
(This option should not be enabled if you anticipate using the
\ref requestmarkstoredmessageinvalid feature.)

<b>Default:</b>
\verbatim
0 (Store services retransmission requests and does not forward requests)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="retransmission-request-forwarding" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorytype Topic Option "repository-type"

Specifies how messages should be retained by the
Store.

<b>Possible Values</b>
<ul>
<li><b>"memory"</b> retains messages only in the (presumably volatile) main
memory of the Store.
<li><b>"disk"</b> retains messages to disk storage.
In addition, messages are cached in main memory for a time as well.
<li><b>"reduced-fd"</b> DEPRECATED, do not use.
Retains messages to disk storage
in a lower-performing way (compared to <b>"disk"</b>) that uses fewer OS File
Descriptors.
This type should not be used, as it will be removed in a future UM version.
<a href="https://ultramessaging.github.io/UM_Support.html">Contact UM Support</a> to devise a plan to migrate away from its use.
<li><b>"no-cache"</b> DEPRECATED, do not use.
Does not retain messages, only state information.
This type should not be used, as it will be removed in a future UM version.
<a href="https://ultramessaging.github.io/UM_Support.html">Contact UM Support</a> to devise a plan to migrate away from its use.
</ul>

<b>Default:</b>
\verbatim
memory
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-type" value="disk"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorysizethreshold Topic Option "repository-size-threshold"

Specifies the minimum number
of message bytes retained in the Store's memory cache.
The purpose of this option is for disk Stores to keep some messages in
memory even after they have been written to disk.
This allows for rapid recovery of recent messages.

For SPP Stores, includes message payload, headers, and Store structure overhead.
For RPP Stores, only includes message payload.

Note that the Store's memory cache size can fall below this threshold.
With RPP Stores,
if all required receivers have acknowledged consumption of all messages,
all messages will be deleted.

Also for RPP, the source LBM configuration may override this option
with \ref umerepositorysizethresholdsource.
In that case, the Store's repository-size-threshold value is used as
the maximum allowed value for ume_repository_size_threshold.
If the source exceeds this value, its registration is rejected.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
1024
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-size-threshold" value="2048"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorysizelimit Topic Option "repository-size-limit"

Specifies the maximum number
of message bytes retained in the Store's memory cache.
For \ref umecfgrepositorytype "repository-type" <b>"memory"</b>,
this represents the maximum size for the entire repository.
For \ref umecfgrepositorytype "repository-type" <b>"disk"</b>,
the total repository size is limited by
\ref umecfgrepositorydiskfilesizelimit.

Note that the design of UM's persistence allows a maximum of
2,147,483,647 messages (2**31 - 1) to be persisted.
Do not specify a limit that would allow more than 2,147,483,647 messages
to be stored.

For SPP Stores, includes message payload, headers, and Store structure overhead.
For RPP Stores, only includes message payload.

Also for RPP, the source LBM configuration may override this option
with \ref umerepositorysizelimitsource.
In that case, the Store's repository-size-limit value is used
the maximum allowed value for ume_repository_size_limit.
If the source exceeds this value, its registration is rejected.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
50331648 (48 MB)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-size-limit" value="67108864"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositoryagethreshold Topic Option "repository-age-threshold"

Specifies how long in seconds the repository keeps a
message available.
Pertains to a memory Store or the memory cache of a disk Store.
The repository reclaims space used to store messages that exceed this
threshold.
Note that if these deleted messages have been persisted to disk,
they are available to receivers for recovery.

This is a rarely-used option, typically only useful on a memory-only Store.

A value of 0 means message age is not considered in retention decisions.

<b>Default:</b>
\verbatim
0 (disabled)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-age-threshold" value="120"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskmaxasynccbs Topic Option "repository-disk-max-async-cbs"

This option is identical to \ref umecfgrepositorydiskmaxreadasynccbs
and sets the same underlying limit to outstanding async reads.

The original intent of this option was to simultaneously set both
\ref umecfgrepositorydiskmaxreadasynccbs and
\ref umecfgrepositorydiskmaxwriteasynccbs.
But Informatica subsequently determined that the async write
limit needed to be set to 1.
So this option was changed to update only the async read limit.

<b>Default:</b>
\verbatim
10,000 (callbacks)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-max-async-cbs" value="15000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskmaxwriteasynccbs Topic Option "repository-disk-max-write-async-cbs"

For topics with a
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>,
specifies the maximum number of outstanding async I/O callbacks for
writing messages to disk.
This option is deprecated, and if supplied,
must be set equal to 1.
(If supplied with any other value,
an error will be logged and the value will be ignored.)

<b>Default:</b>
\verbatim
1 (callback)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-max-write-async-cbs" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskmaxreadasynccbs Topic Option "repository-disk-max-read-async-cbs"

For topics with a
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>, specifies
the maximum number of outstanding async I/O callbacks for reading messages
from disk.
A low value can lead to severely slower message recovery rates by receivers.

<b>Default:</b>
\verbatim
10,000 (callbacks)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-max-read-async-cbs" value="15000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskfilesizelimit Topic Option "repository-disk-file-size-limit"

Specifies
the maximum amount of disk space, in bytes,
that will be used to store retained messages.
A minimum value of 196992 is enforced.

Note that the design of UM's persistence allows a maximum of
2,147,483,647 messages (2**31 - 1) to be persisted.
Do not specify a limit that would allow more than 2,147,483,647 messages
to be stored.

This option only applies for
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>.

Also for RPP, the source LBM configuration may override this option
with \ref umerepositorydiskfilesizelimitsource.
In that case, the Store's repository-disk-file-size-limit value is used as
the maximum allowed value for ume_repository_disk_file_size_limit.
If the source exceeds this value, its registration is rejected.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
104857600 (100 MB)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-file-size-limit" value="209715200"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskfilepreallocate Topic Option "repository-disk-file-preallocate"

For topics with a
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>, if set to 1, UM
pre-allocates a Store's cache files to match their maximum size on disk
(as configured by repository-disk-file-size-limit) upon creation, as
opposed to growing to that size as the Store receives new messages.
For ext3/4 and NTFS file systems, this options creates a sparse file, which
does not allocate all of the underlying data blocks.
Advantages of pre-allocation include better performance on rotating disks
due to less file fragmentation, and knowing that enough disk space exists
for any new source that registers. Disadvantage is the time to create the
cache files, especially if many sources register at once.

<b>Default:</b>
\verbatim
0 (do not pre-allocate)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-file-preallocate" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskasyncbufferlength Topic Option "repository-disk-async-buffer-length"

For topics with a
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>,
specifies the size of the buffers that will be used in async I/O
operations for reading and writing messages to disk.
A minimum value of 65664 is enforced.

<b>Default:</b>
\verbatim
1024000 (bytes)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-async-buffer-length" value="2097152"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskmessagechecksum Topic Option "repository-disk-message-checksum"

For topics with a
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>,
specifies whether the messages saved to disk should include a checksum
field for validation if the Store is restarted.

<b>Default:</b>
\verbatim
0 (disabled)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-message-checksum" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgsourceactivitytimeout Topic Option "source-activity-timeout"

Establishes the period of time in milliseconds from a
source's last activity to the release of the source's RegID. Stores return
an error to any new source requesting the source's RegID during this period.
If proxy sources are enabled (\ref umeproxysourcesource) the Store does not
release the source's RegID and UM elects a proxy source.
If neither proxy sources nor \ref umestatelifetimesource are configured,
the Store also deletes the source's state and cache.
Can be overridden by \ref umeactivitytimeoutsource.
See also \ref persistenceproxysources.

Note that \ref umecfgsourceactivitytimeout value should be set to at least double
the \ref umecfgkeepaliveinterval value.

<b>Default:</b>
\verbatim
30000 (30 seconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="source-activity-timeout" value="60000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgsourcestatelifetime Topic Option "source-state-lifetime"

Establishes the period of time in milliseconds from a
source's last activity to the deletion of the source's state and cache by
the Store, regardless of whether a proxy source has been created or not.
You can also configure \ref umestatelifetimesource for the source.
The Store uses whichever is shorter.
See also \ref persistenceproxysources.

<b>Default:</b>
\verbatim
0 (disabled)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="source-state-lifetime" value="0"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgreceiveractivitytimeout Topic Option "receiver-activity-timeout"

Establishes the period of time in milliseconds from a
receiver's last activity to the release of the receiver's RegID.
Stores return an error to any new request for the receiver's RegID during
this period.
Can be overridden by \ref umeactivitytimeoutreceiver.
See also \ref persistenceproxysources.

<b>Default:</b>
\verbatim
30000 (30 seconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="receiver-activity-timeout" value="45000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgreceiverstatelifetime Topic Option "receiver-state-lifetime"

Establishes the period of time in milliseconds from a
receiver's last activity to the deletion of the receiver's state and cache
by the Store. You can also configure \ref umestatelifetimereceiver for the
receiver.
The Store uses whichever is shorter.
See also \ref persistenceproxysources.

<b>Default:</b>
\verbatim
0 (disabled)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="receiver-state-lifetime" value="0"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgsourcecheckinterval Topic Option "source-check-interval"

Specifies the period in milliseconds a Store will check for
activity of sources and receivers.

<b>Default:</b>
\verbatim
750 (milliseconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="source-check-interval" value="900"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgkeepaliveinterval Topic Option "keepalive-interval"

Specifies the period in milliseconds a Store will generate
keepalive traffic to sources and receivers if there has been no traffic
required in the normal course of operation.

Note that \ref umecfgsourceactivitytimeout value should be set to at least double
the \ref umecfgkeepaliveinterval value.

<b>Default:</b>
\verbatim
3000 (3 seconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="keepalive-interval" value="5000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgreceivernewregistrationrollback Topic Option "receiver-new-registration-rollback"

Specifies an upper limit to the number of messages a
registering persistent receiver should recover during "late join".

\attention For most use cases, this option should be left at its default,
which effectively disables a limit.

The receiver can limit the number of messages that it can request for recovery
using the LBM configuration option \ref retransmitrequestmaximumreceiver.
If the request exceeds the limit configured in the Store's
topic option receiver-new-registration-rollback,
the receiver's recovery will be limited to the latter number
of messages.

Note that this limit interferes with the persistence guarantee of delivery.
If a limit of 1,000 is configured, and a receiver exits and restarts after
the source has sent 4,000 more messages,
the receiver might not be able to recover all 4,000 messages.
It might be limited to the most-recent 1,000 messages.

Also, note that a persistent receiver can set up a initial
sequence number callback using the LBM configuration option
\ref umerecoverysequencenumberinfofunctionreceiver.
This allows the application to specify a desired starting sequence
number.
If the application is written to use this approach,
Store topic option "receiver-new-registration-rollback"
and LBM configuration option retransmit_request_maximum should be
at their default values.

If used, the value for receiver-new-registration-rollback must be
between 1 and 2147483647 (maximum signed 32-bit integer).
The default value of 2147483647 effectively disables the limit.

<b>Default:</b>
\verbatim
2147483647
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="receiver-new-registration-rollback" value="2147483647"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgproxyelectioninterval Topic Option "proxy-election-interval"

Specifies the interval, in milliseconds,
used when electing a proxy source.
When a source, which requested that a proxy source be provided for it,
has been detected as no longer active, each Store eligible to provide a proxy
source for it waits for an amount of time which is randomized in the range
[0.5*proxy-election-interval .. 1.5*proxy-election-interval].
If no other Store has been elected to serve as the proxy source, the Store
declares itself as the proxy source.

<b>Default:</b>
\verbatim
60,000 (60 seconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="proxy-election-interval" value="80000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgstabilityackinterval Topic Option "stability-ack-interval"

Specifies the maximum amount of time in milliseconds that
stability acknowledgments will be batched before being sent to a source.
This batching is only enabled if \ref umecfgstabilityackminimumnumber
is set to greater than 1.

Batching stability ACKs can increase throughput of Stores (especially
memory Stores) significantly, but introduces a delay between when a message
is actually stable in the Store and when the source is notified of
message stability.

At high message rates, the stability ACKs will normally be triggered
by the received messages exceeding
\ref umecfgstabilityackminimumnumber "stability-ack-minimum-number".
However,
if the source publishing rate drops significantly, the stability-ack-interval
ensures an upper bound to the time required for stability ACKs.

<b>Default:</b>
\verbatim
200 (200 milliseconds)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="stability-ack-interval" value="50"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgstabilityackminimumnumber Topic Option "stability-ack-minimum-number"

Specifies the minimum number of message
fragment stability acknowledgments that must accumulate before a stability
ACK is sent to a source. With the default value of 1, stability ACKs are
sent immediately as soon as messages are stable. Increasing this value
causes stability ACKs to be batched, which can increase throughput of
Stores (especially memory Stores) significantly, but introduces a delay
between when a message is actually stable in the Store and when the
source is notified of message stability.

If using a stability ACK-based flight size on a persistent source in combination
with this option, it is advisable to make sure stability-ack-minimum-number
is set less than the source's flight size.
Otherwise, stability ACKs will only be sent upon expiration of the
\ref umecfgstabilityackinterval "stability-ack-interval" timer, resulting
in bursty stop-and-go sending.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
1 (fragment; no batching)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="stability-ack-minimum-number" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositoryallowreceiverpacedpersistence Topic Option "repository-allow-receiver-paced-persistence"

Specifies if the
repository allows receiver-paced persistence (RPP).
If allowed (value 1), the source
may request RPP with \ref umereceiverpacedpersistencesource.

Note that the Store cannot be directly configured to enable RPP;
the source <i>must</i> be configured to request it.
Otherwise, the repository defaults to SPP.
This option only <i>allows</i> the source to request it.

See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
0 (Store does not allow the source to specify RPP)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-allow-receiver-paced-persistence" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositoryallowackonreception Topic Option "repository-allow-ack-on-reception"

For RPP, specifies if the
repository allows "ack on reception" behavior.
If allowed (value 1), the source may request "ack on reception" with
\ref umerepositoryackonreceptionsource.
See \ref umerepositoryackonreceptionsource for more information about
"ack on reception" behavior.

Note that the Store cannot be directly configured to enable
"ack on reception"; the source <i>must</i> be configured to request it.
Otherwise, the repository defaults to acknowledging when messages are
written to disk.
This option only <i>allows</i> the source to request it.

Also note that for SPP Stores, this option is ignored.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
0 (Store does not allow the source to specify ack on reception behavior)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-allow-ack-on-reception" value="1"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgrepositorydiskwritedelay Topic Option "repository-disk-write-delay"

Specifies a delay in
milliseconds after a message is received before the message is
written to disk.
This option is for use with RPP,
and is intended to allow all required receivers to acknowledge
consumption of messages within the write delay time.
This deletes the messages from the memory cache before they
are written to disk.
If all required receivers acknowledge consumption within the delay time,
the Store never needs to write messages to disk.

This option only applies for
\ref umecfgrepositorytype "repository-type" <b>"disk"</b>.

For RPP, the source LBM configuration may override this option 
with \ref umewritedelaysource.
In that case, the Store's repository-disk-write-delay value is used as
the maximum allowed value for ume_write_delay.
If the source exceeds this value, its registration is rejected.

For RPP, see \ref rppconfigurationspecifics
for interactions between this and other configuration options.
See \ref receiverpacedpersistenceoperations for general information on RPP.

<b>Default:</b>
\verbatim
0 (milliseconds, no delay)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="repository-disk-write-delay" value="5000"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_s2 umecfgsourceflightsizebytesmaximum Topic Option "source-flight-size-bytes-maximum"

For RPP, specifies the
maximum number of in-flight payload bytes that the source is allowed to
configure with \ref umeflightsizebytessource.
If the source exceeds this value, its registration is rejected.

See \ref persistenceflightsize for more information.

<b>Default:</b>
\verbatim
4194304 (4 MB)
\endverbatim

<b>Example:</b>
\code
<topic pattern="EventStream" type="direct">
  <ume-attributes>
    <option type="store" name="source-flight-size-bytes-maximum" value="8388608"/>
    ...
  </ume-attributes>
</topic>
\endcode

\m4_pg specialconfigurationtopics Special Configuration Topics

\m4_s1 storelossrepair Store Loss Repair

The persistent Store uses a normal UM receiver to get messages from the source.
The Store is subject to the same potential \ref packetloss scenarios as an
application subscriber,
and uses the same loss repair techniques as a subscriber.

Informatica recommends enabling \ref offtransportrecoveryotr on the Store
and application subscribers.

\m4_s1 persistencebuffersizes Persistence Buffer Sizes

There are two memory buffers that need to be properly sized to get the
desired level of performance and reliability for persistence:
<ul>
<li>Source retention buffer, also known as the late join buffer.
<li>Store message cache.
</ul>

This analysis assumes that you are using disk-based Stores.

The sizing depends on how sensitive your publishing application is to being
slowed down in the event of packet loss.
The Stores are designed to write messages to disk in sequence-number order.
So in the event of packet loss, newly received messages must be buffered
in the Store's message cache while the Store waits for retransmission of
the lost messages.
If the source's message rate is high and the time required to repair the
packet loss is significant, the Store's cache must be configured to be large.

Note that this affects the flight size configuration also.
For SPP Stores, message stability is acknowledged to the source after
the messages is successfully written to disk.
But for messages being kept in the Store's message cache waiting for
lost packet retransmission, stability acknowledgement is delayed.
All messages sent during this time are said to be "in flight".
To avoid the publisher being blocked on flight size,
the flight size limit might need to be made large.
It is not unusual for our performance-sensitive users to configure the
flight size limit to be in the tens of thousands.

Finally, the source's retention buffer (late join buffer) should be sized
the same as the flight size limit.

\m4_s1 calculatingoptionsforspp Calculating Options for SPP

Determine the following for your application:
<ul>
<li>avg_msg_size - The source's average size of application messages,
in bytes.
<li>avg_msg_rate - The source's average message send rate,
in datagrams per second.
</ul>

The following formulas calculate minimum recommended values of some
configuration options:
\verbatim
ume_flight_size = 3 * (ume_ack_batching_interval/1,000) * avg_msg_rate
ume_flight_size_bytes = ume_flight_size * avg_msg_size
ume_repository_size_threshold = ume_flight_size_bytes
ume_repository_size_limit = 1.2 * ume_repository_size_threshold
\endverbatim

If \ref umecfgstabilityackminimumnumber is greater than 1,
the value of \ref umecfgstabilityackinterval needs to be added in as follows:
\verbatim
ume_flight_size = 3 * ((ume_ack_batching_interval + stability-ack-interval)/1,000)
                  * avg_msg_rate
\endverbatim
The other parameters must then be recalculated.

For example:
\verbatim
avg_msg_size = 1024 bytes            (hypothetical use case)
avg_msg_rate = 10,000 datagrams/sec  (hypothetical use case)

ume_flight_size = 3 * (100/1000) * 10000 = 3000
ume_flight_size_bytes = 3000 * 1024 = 3,072,000
ume_repository_size_threshold = 3,072,000
ume_repository_size_limit = 1.2 * 3072000 = 3,686,400
\endverbatim

Note that application deviations (e.g. bursts) from the averages can result in
unexpected disk writes and blocking imposed on the source.
To reduce the chances of blocking,
the values for avg_msg_size and/or avg_msg_rate can be increased
(with the subsequent configuration values recalculated).

\m4_s1 rppconfigurationspecifics RPP Configuration Specifics

With RPP, there is a non-obvious interaction between the settings for:
<ul>
<li>Store configuration option \ref umecfgrepositorysizelimit "repository-size-limit",
<li>Store configuration option \ref umecfgrepositorysizethreshold "repository-size-threshold"
<li>Store configuration option \ref umecfgrepositorydiskwritedelay "repository-disk-write-delay",
<li>Source LBM configuration option \ref umerepositoryackonreceptionsource,
<li>Source LBM configuration options \ref umeflightsizebytessource and
\ref umeflightsizesource.
<li>Receiver LBM configuration option \ref umeackbatchingintervalcontext.
<li>Store LBM configuration options
\ref umecfgstabilityackinterval "stability-ack-interval" and
\ref umecfgstabilityackminimumnumber "stability-ack-minimum-number".
</ul>

The source and Store can enter a state where the sending rate is severely
limited by flight size,
even though the Store is relatively idle.

To avoid this issue, you need to analyze your usage patterns and set
your configuration options appropriately.
Determine the following for your application:
<ul>
<li>avg_msg_size - The source's average size of application messages,
in bytes.
<li>avg_msg_rate - The source's average message send rate,
in datagrams per second.
</ul>

Next you need to decide how long you want to set
\ref umecfgrepositorydiskwritedelay "repository-disk-write-delay".
The idea is that you want to avoid writing to disk during normal operation,
so you should set it long enough that all normally-operating receivers
have a chance to acknowledge consumption of the messages during the
write delay time.
Remember that when a receiver gets a message,
it might delay sending consumption for \ref umeackbatchingintervalcontext
milliseconds (defaults to 100).

You also need to take into account heavy bursts of traffic,
where receivers might store significant numbers of messages in their
socket buffers, and it can take time for the receivers to work their way
through all of them.

But you don't want to make the repository-disk-write-delay larger than
necessary because it can lead to very high memory usage in the Store.
We generally see repository-disk-write-delay being set to values
as low as 1000 (1 sec) and as high as 5000 (5 sec).

The following formulas calculate minimum recommended values of some
configuration options:
\verbatim
ume_flight_size = 3 * (ume_ack_batching_interval/1,000) * avg_msg_rate
ume_flight_size_bytes = ume_flight_size * avg_msg_size
ume_repository_size_threshold =
        (avg_msg_size * avg_msg_rate * (repository-disk-write-delay/1,000))
        + ume_flight_size_bytes
ume_repository_size_limit = 1.2 * ume_repository_size_threshold
\endverbatim
If \ref umecfgstabilityackminimumnumber is greater than 1,
the value of \ref umecfgstabilityackinterval needs to be added in as follows:
\verbatim
ume_flight_size = 3 * ((ume_ack_batching_interval + stability-ack-interval)/1,000)
                  * avg_msg_rate
\endverbatim
The other parameters must then be recalculated.

For example:
\verbatim
avg_msg_size = 1024 bytes            (hypothetical use case)
avg_msg_rate = 10,000 datagrams/sec  (hypothetical use case)
repository-disk-write-delay = 2500  (2.5 sec, chosen by user)

ume_flight_size = 3 * (100/1000) * 10000 = 3000
ume_flight_size_bytes = 3000 * 1024 = 3,072,000
ume_repository_size_threshold = (1024 * 10000 * (2500/1000)) + 3072000 = 28,672,000
ume_repository_size_limit = 1.2 * 28672000 = 34,406,400
\endverbatim

Note that application deviations (e.g. bursts) from the averages can result in
unexpected disk writes and blocking imposed on the source.
To reduce the chances of blocking,
the values for avg_msg_size and/or avg_msg_rate can be increased
(with the subsequent configuration values recalculated).

\m4_pg storedaemonstatistics Store Binary Daemon Statistics

\note The C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

See \ref exampleprotocolfiles for the protocol buffer definition files.

\m4_s1 storedaemonstatisticsstructures Store Daemon Statistics Structures

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

The different message types are:

<ul>
<li> \ref LBM_UMESTORE_DMON_MPG_SMART_HEAP_STATS
<li> \ref LBM_UMESTORE_DMON_MPG_STORE_STATS
<li> \ref LBM_UMESTORE_DMON_MPG_REPO_STATS
<li> \ref LBM_UMESTORE_DMON_MPG_DISK_STATS
<li> \ref LBM_UMESTORE_DMON_MPG_RCV_STATS
<li> \ref LBM_UMESTORE_DMON_MPG_STORE_CONFIG
<li> \ref LBM_UMESTORE_DMON_MPG_STORE_PATTERN_CONFIG
<li> \ref LBM_UMESTORE_DMON_MPG_STORE_TOPIC_CONFIG
<li> \ref LBM_UMESTORE_DMON_MPG_REPO_CONFIG
<li> \ref LBM_UMESTORE_DMON_MPG_RCV_CONFIG
</ul>

Each one has a specific structure associated with it, as detailed in
umedmonmsgs.h.

Note that message types ending with "_CONFIG" are in the config category,
while message types ending with "_STATS" are in the stats category.
See \ref daemonstatisticsstructures for information on how the two
categories are handled differently.

\m4_s2 storedaemonstatisticsbyteswapping Store Daemon Statistics Byte Swapping

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

A monitoring application receiving these messages must detect if there
is an endian mismatch (see \ref daemonstatisticsbinarydata).
The header structure \ref umestore_dmon_msg_hdr_t contains a 16-bit field
named `magic` which is set equal to \ref LBM_UMESTORE_DMON_MAGIC.
The receiving application should compare it to \ref LBM_UMESTORE_DMON_MAGIC
and \ref LBM_UMESTORE_DMON_ANTIMAGIC.
Anything else would represent a serious problem.

If the receiving app sees:
\code
  magic == LBM_UMESTORE_DMON_MAGIC
\endcode
then it can simply access the binary fields directly.
However, if it sees:
\code
  magic == LBM_UMESTORE_DMON_ANTIMAGIC
\endcode
then <i>most</i> (but not all) binary fields need to be byte-swapped.
See \ref exampleumedmon_c
for an example, paying special attention to the macros `COND_SWAPxx` (which
<i>conditionally</i> swaps based on the magic test) and the functions
`byte_swapXX()` (which performs the byte swapping).

However, there are some binary fields which must never be swapped, regardless
of the endian.
This is indicated in the documentation.
For example, \ref umestore_store_dmon_config_msg_t_stct::store_iface
says "NOTE: This field should NOT be byte-swapped."
Here's how that field might be accessed:
\code
  in.s_addr = msg->store_iface;
  printf("Store IP address / port: %s / %d\n",
      inet_ntoa(in), COND_SWAP16(msg_swap, msg->store_port));
\endcode
As you can see, `store_iface` is not byte swapped, but `store_port`
(conditionally) is swapped.

\m4_s2 storedaemonstatisticsstructuresstringbuffers Store Daemon Statistics String Buffers

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

There are some messages which contain string buffers at the ends of the
messages.
Strings in these data structures are always null-terminated.
Be aware that these messages are not sent as fixed-length equal to the
size of the data structure, but rather are sent with only the bytes
required by the string (including the final null).
For example, the structure \ref umestore_store_pattern_dmon_config_msg_t
contains the field
\ref umestore_store_pattern_dmon_config_msg_t_stct::pattern_buffer
which is `char` array of size `LBM_UMESTORE_DMON_TOPIC_PATTERN_STRLEN`.
If `pattern_buffer` is set to ".*", then only 3 bytes (including the
null string terminator) are sent for that field.

(Contrast this with \ref umrouterdaemonstatisticsstructuresstringbuffers.)

This becomes more complicated when there are multiple strings in one
message.
For example, consider \ref umestore_store_dmon_config_msg_t.
This message contains three strings: Store name, cache directory name, and
state directory name.
But a single `char` array is declared:
\code
  char string_buffer[LBM_UMESTORE_DMON_STORE_NAME_STRLEN + (2 * LBM_UMESTORE_DMON_FILENAME_MAX_STRLEN)
\endcode
The three strings are packed into that buffer, only taking up as much space as
is necessary.
I.e. if the three strings are "a", "b", and "c", only 6 bytes of the buffer
will be consumed (each string has a null).

To make it easier for the code to find the three strings, the structure
has three offset variables: `store_name_offset`, `disk_cache_dir_offset`,
and `disk_state_dir_offset`.
These are byte offsets from the start of the entire structure.
So, to access the Store name, the monitoring application might use:
\code
  umestore_store_dmon_config_msg_t *store_config_msg = ... /* ptr to incoming msg */
  char *state_dir_name = (char *)store_config_msg +
                         store_config_msg->store_name_offset;
\endcode
(The practice of using offsets from the start of the structure allows for
greater flexibility in ensuring inter-version compatibility.)

\m4_s2 storedaemonstatisticsstructuresretxcounts Store Daemon Statistics Retx Counts

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

There is a set of fields in \ref umestore_store_dmon_stat_msg_t which
give statistics on recovery operations initiated by receivers:

<ul>
<li>\ref umestore_store_dmon_stat_msg_t_stct::ume_retx_req_rcv_count
<li>\ref umestore_store_dmon_stat_msg_t_stct::ume_retx_req_serviced_count
<li>\ref umestore_store_dmon_stat_msg_t_stct::ume_retx_req_drop_count
</ul>

The web monitor's \ref storewebmonitorstorepage has a manual function
labeled \ref resetratestats "Reset Rate Stats" which clears those
`"ume_retx_..._count"` fields.
This is a useful function for users who use the web monitor as their
primary monitoring tool, but for users who depend on the published
Daemon Statistics, it can be disruptive for the counts to be cleared
on-demand.

The field \ref umestore_store_dmon_stat_msg_t_stct::ume_retx_stat_interval
contains the seconds since the last \ref resetratestats "Reset Rate Stats"
operation.
If the user has not used \ref resetratestats "Reset Rate Stats", then
`ume_retx_stat_interval` contains the seconds since the Store's startup.

\m4_s1 storedaemonstatisticsconfiguration Store Daemon Statistics Configuration

\note the C-style binary structure format of daemon statistics is
DEPRECATED and may be removed in a future release.
Informatica requests that users migrate to protobuf-based format.
See \ref monitoringumdaemons.

There are two places in the Store configuration file that
Daemon Statistics are configured:
<ul>
<li>The \ref umeelementdaemonmonitor inside the \ref umeelementdaemon
configures all aspects of the Store Daemon Statistics feature,
including publishing intervals, for all Store instances in a Store Process.
<li>The \ref umeelementpublishinginterval inside a \ref umeelementstore
configures only the publishing intervals of a Store instance.
</ul>

Here is an example of configuring daemon statistics.

\code
<ume-store version="1.3">
<daemon>
  <daemon-monitor topic="bozo">
    ...
    <publishing-interval>
      <group name="default" ivl="3"/>
      <group name="config" ivl="120"/>
    </publishing-interval>
    <remote-snapshot-request allow="1"/>
    <remote-config-changes-request allow="1"/>
  </daemon-monitor>
<daemon>
<stores>
  <store name="store0" port="12000">
    <publishing-interval>
      <group name="default" ivl="6"/>
      <group name="config" ivl="120"/>
    </publishing-interval>
    ...
  </store>
  <store name="store1" port="12001">
    ...
  </store>
</stores>
\endcode

In this example, all stats-type messages are (conditionally) published on a
3-second interval, except those of store0, which are published (conditionally)
on a 6-second interval.
All config-type messages are published (unconditionally) on a 120-second interval.

\m4_s1 storedaemoncontrolrequests Store Daemon Control Requests

The Store Process supports a monitoring application to send a specific
set of requests to control the operation of Daemon Statistics, and
other operations of the Store.
The \ref umeelementremotesnapshotrequest "<remote-snapshot-request>"
and \ref umeelementremoteconfigchangesrequest "<remote-config-changes-request>"
elements control whether the Store enables the
\ref daemoncontroller operation (both default to disabled).

\warning If misused, 
the Daemon Control Requests feature allows a user to interfere with
the messaging infrastructure in potentially disruptive ways.
By default, this feature is disabled. 
However, especially if you have enabled
\ref umeelementremoteconfigchangesrequest,
Informatica recommends \ref securingdaemoncontrolrequests.

If enabled, the monitoring application can send a request message to the
Store in the form of a topicless unicast immediate "request" message
(see lbm_unicast_immediate_request() with NULL for topic).
The format of the message is a simple ascii string, with or without null
termination.
Due to the simple format of the message, no data structure is defined for it.

When the Store receives and validates the request, it sends a UM response
message back to the requesting application containing a status message (which
is <i>not</i> null-terminated).
If the status was OK, the Store also performs the requested action.

\m4_s2 storedaemoncontrolrequestaddressing Store Daemon Control Request Addressing

Since Daemon Control Requests are sent as UIM messages,
you must use a target string to address the request to the desired
Store Process.
The general form of a UIM target address is described in \ref uimaddressing,
but is illustrated by this example:
\verbatim
TCP:10.29.3.46:12009
\endverbatim
where 10.29.3.46:12009 is the IP and Port of the Daemon Control context
UIM port.
These are typically configured using the \ref requesttcpinterfacecontext and
\ref requesttcpportcontext options in the LBM configuration file
specified by the \ref umeelementlbmconfig contained within the
\ref umeelementdaemonmonitor.

\m4_s2 storedaemoncontrolrequesttypes Store Daemon Control Request Types

The example program \ref exampleumedcmd_c
demonstrates the correct way to send the messages and receive the responses.
See \ref umedcmdmanpage for usage details.

<b>REQUEST TYPES ENABLED BY
\ref umeelementremotesnapshotrequest "<remote-snapshot-request>":</b>

\par `version`
The Store returns in its response the value of
\ref LBM_UMESTORE_DMON_VERSION.
No daemon statistics messages are published.

\par `snap memory`
The Store immediately publishes the memory usage message
\ref LBM_UMESTORE_DMON_MPG_SMART_HEAP_STATS.

\par `snap src`
The Store immediately publishes the source repository statistics message(s)
\ref LBM_UMESTORE_DMON_MPG_REPO_STATS.

\par `snap rcv`
The Store immediately publishes the receiver statistics message(s)
\ref LBM_UMESTORE_DMON_MPG_RCV_STATS.

\par `snap disk`
The Store immediately publishes the disk statistics message(s)
\ref LBM_UMESTORE_DMON_MPG_DISK_STATS.

\par `snap store`
The Store immediately publishes the Store statistics message(s)
\ref LBM_UMESTORE_DMON_MPG_STORE_STATS.

\par `snap config`
The Store immediately publishes the Store config category messages
\ref LBM_UMESTORE_DMON_MPG_STORE_CONFIG,
\ref LBM_UMESTORE_DMON_MPG_STORE_PATTERN_CONFIG,
\ref LBM_UMESTORE_DMON_MPG_STORE_TOPIC_CONFIG,
\ref LBM_UMESTORE_DMON_MPG_REPO_CONFIG, and
\ref LBM_UMESTORE_DMON_MPG_RCV_CONFIG

<b>REQUEST TYPES ENABLED BY
\ref umeelementremoteconfigchangesrequest "<remote-config-changes-request>":</b>

A Store Process can have multiple Store instances.
But the UIM message is sent to the Daemon Control context within
the Store Process.

Except as noted,
the following requests can either be applied to all Store instances in the
Store Process, or to just one Store instance.
To apply the request to one Store instance,
the Store name (as specified in the \ref umeelementstore attribute "name")
should be specified in double quotes.

\par memory \a N
Set the publishing interval for memory usage.
This is only available on a Store Process basis.
A Store instance may not be supplied.
<br>For example: `memory 5`

\par src \a N
Set the publishing interval for source repository statistics messages.
This request can be preceded by a Store instance name in double quote marks to
only set the publishing interval for that Store.
<br>For example: `"store1" src 5`

\par rcv \a N
Set the publishing interval for receiver statistics messages.
This request can be preceded by a Store instance name in double quote marks to
only set the publishing interval for that Store.
<br>For example: `"store1" rcv 5`

\par disk \a N
Set the publishing interval for disk statistics messages.
This request can be preceded by a Store instance name in double quote marks to
only set the publishing interval for that Store.
<br>For example: `"store1" disk 5`

\par store \a N
Set the publishing interval for Store statistics messages.
This request can be preceded by a Store instance name in double quote marks to
only set the publishing interval for that Store.
<br>For example: `"store1" store 5`

\par config \a N
Set the publishing interval for config category messages.
This request can be preceded by a Store instance name in double quote marks to
only set the publishing interval for that Store.
<br>For example: `"store1" config 5`

For the following requests,
a Store instance <i>must</i> be supplied as part of the request.
It is supplied as an IP and Port,
as specified in the \ref umeelementstore attributes "interface" and "port".
Note that the following requests are <i>not</i> related to the
Daemon Statistics feature, but are nonetheless enabled by
\ref umeelementremoteconfigchangesrequest "<remote-config-changes-request>".

\par mark \a INTFC \a PORT \a SRC_REGID \a SQN
Mark as invalid the message with sequence number <i>SQN</i>
from the source with registration ID <i>SRC_REGID</i>
on the Store instance at <i>INTFC</i>:<i>PORT</i>.
<br>For example: `mark 10.29.3.16 12000 127025183 500`
<br>Note that only one sequence number can be specified.
See \ref requestmarkstoredmessageinvalid for more information.

\par deregister \a INTFC \a PORT \a SRC_REGID \a RCV_REGID
Deregister the receiver with registration ID <i>RCV_REGID</i>
associated with the source with registration ID <i>SRC_REGID</i>
on the Store instance at <i>INTFC</i>:<i>PORT</i>.
<br>For example: `deregister 10.29.3.16 12000 127025183 127025184`
<br>Note that only one receiver registration ID can be specified.
See \ref requestderegisterreceiver for more information.

\m4_s2 requestmarkstoredmessageinvalid Request: Mark Stored Message Invalid

There are occasions when a user might want to mark one or more messages
in a Store's repository as invalid,
to prevent them from being delivered to a recovering receiver.
This can be useful if a misbehaving publisher sends a "poison" message that
causes receivers to crash;
having that message in the Store's repository means that restarting the failed 
receiver will just cause it to crash again when the message is recovered.

This message marking feature is provided by the daemon
command-and-control feature \ref storedaemoncontrolrequests.
Note that if there is more than one Store instance in this QC group,
the request needs to be sent multiple times,
once for each Store instance IP/Port.

\warning If misused, 
the Daemon Control Requests feature allows a user to interfere with
the messaging infrastructure in potentially disruptive ways.
By default, this feature is disabled. 
However, especially if you have enabled
\ref umeelementremoteconfigchangesrequest,
Informatica recommends \ref securingdaemoncontrolrequests.

\warning When a message is marked invalid with this feature,
that mark is *NOT* saved onto disk.
If the marked message resides on disk and the Store is restarted,
it loses its invalid mark and becomes subject to delivery to recovering
receivers.
Invalid messages may need to be re-marked as invalid after a Store restart.

\warning The message marking feature is incompatible with the
\ref umecfgretransmissionrequestforwarding "retransmission-request-forwarding"
Store option.
If you have configured the Store instance to enable the
\ref umecfgretransmissionrequestforwarding "retransmission-request-forwarding"
option,
and a recovering receiver requests a message that has been marked as invalid,
the Store instance will forward the recovery request to the source.
If the source still has the message in its retention buffer,
the Store will supply it to the receiver.

Daemon Control requests can be sent by the example program
\ref exampleumedcmd_c.
Alternatively, that program's source code can be used as a guide for
writing your own Store management program.
See \ref umedcmdmarkmode for full details.

\m4_s2 requestderegisterreceiver Request: Deregister Receiver

There are occasions when a user might want to deregister a failed receiver
from a Store.
This will delete the Store's state information for that receiver.

This receiver deregistration feature is provided by the Daemon
command-and-control feature \ref storedaemoncontrolrequests.

\warning If misused, 
the Daemon Control Requests feature allows a user to interfere with
the messaging infrastructure in potentially disruptive ways.
By default, this feature is disabled. 
However, especially if you have enabled
\ref umeelementremoteconfigchangesrequest,
Informatica recommends \ref securingdaemoncontrolrequests.

A receiver's state information is stored per-source.
For example,
if an application creates a persistent receiver for topic X,
and there are two sources for topic X,
the Store will save two sets of state information for that receiver,
one for each source for X.
To fully clean up a failed receiving application,
you need to deregister every pairing of receiver registration ID (RegID)
associated with that receiver with every source RegID.
And that must be repeated for each Store instance that the receiver was
registered with.
(Session IDs may not be used.)

Once deregistered,
the state and cache files are deleted and cannot be restored.

Note that if there is more than one Store instance in this QC group,
the request needs to be sent multiple times,
once for each Store instance IP/Port.

\note If you use this feature to deregister a receiver that is still running,
that receiving application is not informed of the deregistration, and it
will continue to receive messages from the source and will attempt to
acknowledge them to the Store.
However, the Store will discard these acknowledgements as invalid and
will log warnings to its log file.
The receiving application will not be aware of the acknowledgement discards.

Daemon Control Requests can be sent by the example program
\ref exampleumedcmd_c.
Alternatively, that program's source code can be used as a guide for
writing your own Store management program.
See \ref umedcmdderegistermode for full details.

\m4_s1 umedcmdmanpage umedcmd Man Page

The `umedcmd` example program sends \ref daemoncontrolrequests to
a Store Process.
Source code for `umedcmd` can be found with the other example programs;
see \ref exampleumedcmd_c.

\note UM version 6.13 has a known issue running `umedcmd` on Windows.
See \ref bug10897 "Known Issue 10897".

The `umedcmd` command has 3 modes of operation:
<ul>
<li>\ref umedcmdpublishmode "publish"
- used to control the publishing of Daemon Statistics by the Persistent Store.
<li>\ref umedcmdmarkmode "mark"
- used to mark messages in a Store instance as invalid.
<li>\ref umedcmdderegistermode "deregister"
- used to deregister and delete state information
for a receiver that is currently registered with a Store instance.
</ul>

Each mode has a different usage pattern,
which is determined by the value passed to the "-m" command-line option.

\m4_s2 umedcmdpublishmode umedcmd Publish Mode

This form of the umedcmd command is used to control the publishing of
Daemon Statistics by the Persistent Store.

\verbatim
m4_esyscmd([[[../share/get_usage.pl -p unused -u publish_usage -H unused ../../src/example/umedcmd.c]]])m4_dnl
\endverbatim

The "-m mode" command-line option is optional in this usage.
If supplied, it must be supplied as "-m publish".
Omitting it defaults to publish mode.

The "-T target_string" contains the unicast immediate message destination
address of the Daemon Control context UIM port
(see \ref storedaemoncontrolrequestaddressing).

The parameter "command_string" is optional.
If supplied, it should be enclosed in single quotes.
If omitted, the program enters an interactive mode in which the user
can enter any number of commands (when used interactively,
do not enclose the command string in single quotes).
In interactive mode, use "h" for a brief help screen, and "q" to quit.

Valid command strings are:

\verbatim
m4_esyscmd([[[../share/get_usage.pl -p unused -u unused -H publish_help_msg ../../src/example/umedcmd.c]]])m4_dnl
\endverbatim

Note that most of the commands can optionally be preceded by
a Store instance name in double quotes.
Supplying it causes the command to apply only to the named Store instance.
Omitting this causes the command to apply to <i>all</i> Store instances
in the target Store Program.

For example:
\verbatim
umedcmd -c dstats.cfg -m publish -T TCP:10.29.3.16:12009 '"store1" src 5'
\endverbatim

In this example, the Store Process's Daemon Control context has its
UIM port configured as 12009
(see \ref storedaemoncontrolrequestaddressing),
and the Store instance is configured for the name "store1".
(with the \ref umeelementstore attribute "name").
The source repository statistics are set to a publishing interval of 5 seconds.

\m4_s2 umedcmdmarkmode umedcmd Mark Mode

This form of the umedcmd command is used to mark persisted messages as invalid.
This prevents their delivery to recovering receivers.
See \ref requestmarkstoredmessageinvalid.

\verbatim
m4_esyscmd([[[../share/get_usage.pl -p unused -u mark_usage -H unused ../../src/example/umedcmd.c]]])m4_dnl
\endverbatim

The "-m mark" command-line option must be supplied.

The "-T target_string" contains the unicast immediate message destination
address of the Daemon Control context UIM port
(see \ref storedaemoncontrolrequestaddressing).

The "-i store_interface" and "-p store_port" are required parameters which
identify the desired Store instance within the Store Process,
as specified in the \ref umeelementstore attributes "interface" and "port".

The "-s src_regid" parameter is required to identify the specific source
that sent the invalid message.

The command-line option "-S sqn_string" specifies the sequence number(s)
of the messages that should be marked invalid.
If omitted, the program enters an interactive mode in which the user
can enter any number of sequence number strings.

A sequence number string can specify multiple sequence numbers and/or
ranges of sequence numbers.
A range is two sequence numbers separated by a dash.
The string can consist of one or more sequence numbers or ranges,
separated by commas.
The string should be enclosed in quotes.
For example:
\verbatim
-S "100,110-112,220"
\endverbatim
This specifies sequence numbers 100, 110, 111, 112, 220.
Note that the `umedcmd` command parses the sequence number string and issues
a separate request to the Store instance for each sequence number.

If "-S sqn_string" is omitted from the command line,
the program enters an interactive mode in which the user
can enter any number of sequence number strings.
In interactive mode, use "h" for a brief help screen, and "q" to quit.

For example:
\verbatim
umedcmd -c dstats.cfg -m mark -T TCP:10.29.3.16:12009 -i 10.29.3.16 -p 12000 -s 127025183 -S "500"
\endverbatim

In this example, the Store Process's Daemon Control context has its
UIM port configured as 12009
(see \ref storedaemoncontrolrequestaddressing),
and the Store instance is configured for port 12000
(with the "port" attribute of the \ref umeelementstore).
The source registration ID is 127025183.
The message with sequence number 500 is marked invalid.

\note If there is more than one Store instance in this QC group,
the command needs to be executed multiple times,
once for each Store instance IP/Port.

\m4_s2 umedcmdderegistermode umedcmd Deregister Mode

This form of the umedcmd command is used to deregister a failed receiver.
This deletes the state information for that receiver.
See \ref requestderegisterreceiver.

\verbatim
m4_esyscmd([[[../share/get_usage.pl -p unused -u deregister_usage -H unused ../../src/example/umedcmd.c]]])m4_dnl
\endverbatim

The "-m deregister" command-line option must be supplied.

The "-T target_string" contains the unicast immediate message destination
address of the Daemon Control context UIM port
(see \ref storedaemoncontrolrequestaddressing).

The "-i store_interface" and "-p store_port" are required parameters which
identify the desired Store instance within the Store Process,
as specified in the \ref umeelementstore attributes "interface" and "port".

The "-s src_regid" and "-r rcv_regid" parameters combine to identify
the specific receiver state that will be deleted.
Receiver state is stored according to a <i>pair</i> of
registration IDs: source, receiver.
(Session IDs may not be used.)
For example, lets say there are two persisted sources for the same topic with
registration IDs 100 and 200.
A receiver with registration ID 300 will have two sets of state:
state for the pair 100, 300 and state for the pair 200, 300.

Note that the "-r rcv_regid" parameter can have a comma-separated list
of receiver registration IDs.
This is handy if you need to de-register all receivers for a particular
source.
The rcv_regid should be enclosed in quotes.
Note that `umedcmd` command parses the receiver registration IDs and
issues separate request to the Store instance for each rcv_regid.

Also note that if "-r rcv_regid" is omitted from the command line,
the program enters an interactive mode in which the user
can enter any number of receiver registration IDs.
In interactive mode, use "h" for a brief help screen, and "q" to quit.

For example:
\verbatim
umedcmd -c dstats.cfg -m deregister -T TCP:10.29.3.16:12009 -i 10.29.3.16 -p 12000 -s 127025183 -r "127025184"
\endverbatim

In this example, the Store Process's Daemon Control context has its
request port configured as 12009
(see \ref storedaemoncontrolrequestaddressing),
and the Store instance is configured for port 12000
(with the "port" attribute of the \ref umeelementstore).
The source registration ID is 127025183 and the
receiver registration ID is 127025184.
This pair of registration IDs is used by the Store instance to delete the
receiver state.

\note If there is more than one Store instance in this QC group,
the command needs to be executed multiple times,
once for each Store instance IP/Port.
Also, if there is more than one source for the same topic that the
receiver is registered for,
the command needs to be executed multiple times,
once for each source registration ID.

\m4_pg storewebmonitor Store Web Monitor

\note The Store web monitor functionality is deprecated
in favor of \ref monitoringcollectorservicemcs "MCS".
We do not plan to remove existing web monitor functionality,
and will continue to support it in its current state.
But we do not plan to enhance the web monitor in the future.

The built-in web monitor (configured in the Store configuration file)
is a rich source of information about the health of a Store.
This section contains a page-by-page guide to reading and interpreting the
output of a UM web monitor, with just a couple example sources and one
receiver using a single Store.

\warning The Store's web monitor is not designed to be a highly-secure
feature.
Anybody with access to the network can access the web monitor pages.

Users are expected to prevent unauthorized access to the web
monitor through normal firewalling methods.
Users who are unable to limit access to a level consistent with their
overall security needs should disable the Store web monitor
(using \ref umeelementwebmonitor "<web-monitor>").
See \ref webmonsecurity for more information.

\m4_s1 storewebmonitorindexpage Store Web Monitor Index Page

Here is an image of the Web Monitor's <i>Index</i> (main) page:

<center>
\image html webmon_index.png
\image latex webmon_index.png
</center>

The web monitor's index page tells what build of UM is running.

The "Stores" link displays the \ref storewebmonitorstorespage.

\m4_s1 storewebmonitorstorespage Store Web Monitor Stores Page

Here is an image of the Web Monitor's <i>Stores</i> page:

<center>
\image html webmon_stores.png
\image latex webmon_stores.png
</center>

This page shows all the Stores configured under the `umestored` process.
If you had 5 Stores configured, they would be numbered Store 0 through Store 4.
Our example has only one Store configured, "ume-test-store".

Each Store name is a clickable link, which displays the
\ref storewebmonitorstorepage for that Store.

\m4_s1 storewebmonitorstorepage Store Web Monitor Store Page

Here is an image of the Web Monitor's <i>Store</i> page:

<center>
\image html webmon_store.png
\image latex webmon_store.png
</center>

This page shows the following information about the Store.

<table>
<tr><th>Item <th>Description

<tr><td>Interface <td>This Store is listening on all interfaces (0.0.0.0)
on port 38401.

<tr><td>Cache Dir <td>Pathname for disk Store message cache directory.
This would be configured as a Store option in the Store
configuration file.
For example:
<br>\ref umecfgdiskcachedirectory "<option type=\"store\" name=\"disk-cache-directory\" value=\"cache/\" />"

<tr><td>State Dir <td>Pathname for disk Store state directory.
This would be configured as a Store option in the Store configuration
file.
For example:
<br>\ref umecfgdiskstatedirectory "<option type=\"store\" name=\"disk-state-directory\" value=\"state/\" />"

<tr><td>Configured Retransmission Request Processing Rate <td>Current value
for the Store's
\ref umecfgretransmissionrequestprocessingrate "retransmission-request-processing-rate"
option setting.

<tr><td>Total Seconds Used for Rate Calculations <td>Accumulating counter that
displays the number of seconds since the last rate reset.
The Web Monitor divides the Retransmission Request Received, Retransmission
Request Service and Retransmission Request Drop totals by the Total Seconds
to calculate the rates displayed.
If you click the Reset Rate Stats, the Web Monitor resets this value to zero.

<tr><td>Retransmission Request Received Rate <td>Number of retransmission
requests received per second.

<tr><td>Retransmission Request Service Rate <td>Number of retransmission
requests serviced per second.

<tr><td>Retransmission Request Drop Rate <td>Number of retransmission requests
dropped per second.
Requests are dropped if the rate of retransmission requests exceeds the
configured retransmission request rate.

<tr><td>Retransmission Request Total Dropped <td>The number of retransmission
requests since the time the Store was started.

<tr><td>Patterns <td>Specifies the wildcard pattern used to select topics for
which a Store will provide persistence services.
This would be configured as a topic option in the Store configuration
file.
For example:
\ref umeelementtopic "<topic pattern=\"test.*\" type=\"PCRE\">"

<tr><td>Topics <td>Displays the topic names and Registration ID (Session ID)
for any sources publishing on the topic.
The screen examples display one topic, test1 - 2504558780(39307788).
Each Registration ID (Session ID) is a clickable link, which displays the
\ref storewebmonitorsourcepage for that source.

\anchor resetratestats
<tr><td>Reset Rate Stats <td>Click the Reset Rate Stats link to reset the
retransmission rates.
After clicking the link, The Web Monitor rests Total Seconds Used for Rate
Calculations to zero and displays a page with the Store number and the message,
'`Rate Statistics have been reset`'.
</table>

\m4_s1 storewebmonitorsourcepage Store Web Monitor Source Page

Here is an image of the Web Monitor's <i>Source</i> page:

<center>
\image html webmon_source.png
\image latex webmon_source.png
</center>

The first line in the page contains is interpreted as follows:

<table>
<tr><td>2504558780 <td>The source's registration ID.

<tr><td>10.29.3.42.14392 <td>The IP address and port of the source's LBM
configuration option, \ref requesttcpportcontext.

<tr><td>3958260924 <td>The source's transport session index.

<tr><td>1161732811 <td>The source's topic index within the transport session,
3958260924.
</table>

The remaining fields are described in the following table:

<table>
<tr><th>Source Page Item <th>Description

<tr><td>Topic <td>test is the source's topic string.

<tr><td>Session ID <td>39307788 is the source's Session ID.

<tr><td>Last Activity <td>09:19:39.501350 is the timestamp when the Store
last heard from the source, including keepalives sent by UM

<tr><td>Repository <td>disk is the type of repository.
Possible values are <b>"memory"</b> or <b>"disk"</b>.

<tr><td>Receiver Paced Persistence <td>Setting for Receiver-paced Persistence
(RPP), which is a repository option both the repository and source must enable.
A value of 0 means RPP is not enabled and the repository is using the default
Source-paced persistence.
A value of 1 means RPP is enabled.

<tr><td>Message Map: 3120 <td>The total number of message fragments the Store
has for this source, both on disk and in memory.
These are UM-level fragments, not IP-level fragments. UM messages are
fragmented into roughly 8 kilobyte chunks for UDP-based protocols (LBT-RM and
LBT-RU) and into roughly 64 kilobyte chunks for LBT-TCP.
The majority of application messages tend to be well under the fragment
boundaries, so the value after "Message Map" could be used as a rough estimate
of the number of messages in the Store from this particular source.
It's at least a strict upper bound.

<tr><td>Window: [0, 9d5, c2f] <td>Window format is: trail_sqn, mem_trail_sqn,
lead_sqn
<br><br>
- trail_sqn, 0, is the trailing sequence number, which is the oldest sequence
number in the Store for this source.
In most cases, this starts at 0 and stays there for a while.
The trailing sequence number changes if the Store reaches a disk file size
limit and then deletes the oldest messages.
<br><br>
- mem_trail_sqn, 9d5, is the trailing sequence number for messages in memory.
It is the oldest sequence number still in memory.
Typically, you might have more sequence numbers on disk than you do in memory,
or possibly the same number.
<br><br>
- lead_sqn, c2f, is the leading sequence number, which is the newest sequence
number in the Store.
<br><br>
Note: For a memory Store, the first and second values would always be the same.
The oldest sequence number in memory is the oldest in the Store, so only two
values are displayed.
The trailing sequence number and the leading sequence number.

<tr><td>Memory: 55986 / 65000 / 50331648 <td>Memory format is: repository
memory size / repository size threshold / repository size limit
<br><br>
- repository memory size, 55986, is the number of bytes of messages in memory,
which includes headers and Store overhead.
<br><br>
- repository size threshold, 65000, is the
\ref umecfgrepositorysizethreshold "repository-size-threshold" topic
option found in the Store configuration file.
<br><br>
- repository size limit, 50331648, is the Store's
\ref umecfgrepositorysizelimit "repository-size-limit" topic option
found in the Store configuration file.
<br><br>
You would expect the number of bytes in memory to be under the threshold most
of the time, but it could spike above it before going back down if the Store
is really busy momentarily. It should never go above the limit.

<tr><td>Age Threshold: 0 <td>Age Threshold, 0, is the Store's
\ref umecfgrepositoryagethreshold "repository-age-threshold" topic
option found in the Store configuration file.

<tr><td>Sync: [c2f, c2f, c2f] <td>Pertains to disk
repositories only. Sync format is: sync_complete_sqn, sync_sqn, contig_sqn
<br><br>
- sync_complete_sqn, c2f, Most recent sequence number that the Operating
System has confirmed persisting to disk.
<br><br>
- sync_sqn, c2f, Most recent sequence number for which the Store has initiated
persisting to disk, but the Operating System has not confirmed completion of
persistence.
<br><br>
- contig_sqn, c2f, Most recent sequence number that along with the trail_sqn,
creates a range of sequence numbers with no sequence number gaps.
For example, if trail_sqn = 0 and the Store has persisted all eleven messages
with sequence numbers 0 through 10, contig_sqn would equal 10.
contig_sqn would also be 10 if a receiver declared message sequence number 7
unrecoverably lost.
contig_sqn would be 6 if message sequence number 7 was not persisted, but not
declared lost.

<tr><td>In progress: 0 / 0 <td>Pertains to disk repositories only.
In progress format is: num_ios_pending / num_read_ios_pending
<br><br>
- num_ios_pending, 0, Number of disk writes the Store has submitted to the
Operation System.
A disk write refers to the Store persisting a message to disk.
<br><br>
- num_read_ios_pending, 0, Number of disk reads that the Store has submitted
to the Operating System.
A disk read, for example, results from an application retransmission request.

<tr><td>Offsets: 0 / 190320 / 4294967296 <td>Pertains to disk
repositories only.
Offsets format is: start_offset, offset, max_offset
<br><br>
- start_offset, 0, The relative location of the first message, trail_sqn, in
the disk.
<br><br>
- offset, 190320, The relative location of where the message, contig_sqn plus
one will be written.
<br><br>
- max_offset, 4294967296, The maximum size of the cache file.

<tr><td>Active ULBs: 0 high 0 <td>ULB stands for Unrecoverable Loss Burst.
A little extra work is required to keep cache files consistent when the Store
gets an unrecoverable loss burst, because unrecoverable loss bursts are
delivered all at once for lots of messages, rather than one at a time like
normal unrecoverable loss messages.
<br><br>
Active ULB is the number of unrecoverable loss burst events the Store is
dealing with at the moment.
It'll go to zero after the ULB has been resolved.
<br><br>
The high number (0) is the highest sequence number reported among any
unrecoverable loss burst event, and is not reset after the ULB is handled;
it increments throughout the process life of the Store.
<br><br>
<b>WARNING</b>: If you see any number other than 0 here, the Store is losing
large numbers of messages, and they are likely not being persisted.

<tr><td>Loss: 0 ULBs 0 <td>These values are counters for number of
unrecoverable loss messages (Loss) and for number of unrecoverable burst loss
messages (ULB).
These start at 0 when the Store starts up and aren't reset until the Store
exits.
They don't include any loss events that were persisted to disk from a previous
run, only new loss events since the Store started.
There are cases with UME 2.0 where one individual Store could legitimately
report some unrecoverable loss, or maybe even unrecoverable loss bursts.
<br><br>
<b>WARNING</b>: If you see any number other than 0 for either of these
counters, you should investigate.

<tr><td>Drops: 0 / 0 <td>If the Store is nearing the
\ref umecfgrepositorysizelimit "repository-size-limit" and gets another
message, the Store will intentionally drop a message.
A drop requires a bit of work on the Store's part.
<br><br>
The first 0 is the number of active drops, which are drops that are currently
being worked on.
<br><br>
The second 0 is the total number of drops that have happened for this Store
since it was started.
Some people want a low \ref umecfgrepositorysizelimit "repository-size-limit"
and therefore lots of intentional drops can occur.
Some don't want to drop any message the whole day -
so the interpretation of the values is up to you.

<tr><td>LBM Stats <td>These represent transport-level statistics for the
underlying receivers in the Store for the source.
The example shown is for a TCP source, so not too many stats are available
(stats for a TCP source are less important from a monitoring perspective).
<br><br>
Statistics for an LBT-RM or LBT-RU source, however, show number of NAKs sent,
which is important.
Ideally, the number of NAKs sent should be 0.
A few NAKs from a Store throughout the day is not an emergency.
It can be, however, an early warning sign of more severe problems, and should
be taken seriously.
<br><br>
If you see a non-zero number of NAKs here, take a look at the overall network
load the Store's machine is attempting to handle, particularly in very busy
periods and spikes; it may be too much.

<tr><td>Receivers <td>Registration IDs and accompanying Session ID for the
receivers listening on the source's topic.
Click on the receiver Registration ID (Session ID) to display the
\ref storewebmonitorreceiverpage to review information about
the receivers for that persisted topic.
</table>

\m4_s1 storewebmonitorreceiverpage Store Web Monitor Receiver Page

Here is an image of the Web Monitor's <i>Receiver</i> page:

<center>
\image html webmon_receiver.png
\image latex webmon_receiver.png
</center>

The first line in the page contains is interpreted as follows:

<table>
<tr><td>2504558781 <td>The receiver's registration ID.

<tr><td>10.29.3.42.14393 <td>The IP address and port of the source's LBM
configuration option, \ref requesttcpportcontext.

<tr><td>1510613393 <td>The receiver's transport session index.

<tr><td>1161732811 <td>The source's topic index within the transport session,
1510613393.
</table>

The remaining fields are described in the following table:

<table>
<tr><th>Receiver Page Item <th>Description

<tr><td>Topic <td>The topic that the receiver is listening on.

<tr><td>Last Activity <td>09:09:35.981110 is the timestamp of when the Store
last heard from the receiver, including keepalives sent by UM.

<tr><td>Source RegID <td>Registration ID of the source publishing on the topic.
Click on the Registration ID link to display the \ref storewebmonitorsourcepage.

<tr><td>Source Session ID <td>The Session ID of the Source sending messages
on the topic.

<tr><td>ACK <td>c93 is the last message sequence number the receiver
acknowledged.
</table>

\m4_eof
