# UM application configuration — deep dive

Companion to `SKILL.md`. Read this when the task involves writing,
auditing, or reasoning about a UM application configuration. For
per-option lookup (defaults, units, types, allowed values), use
`config-data.xml` — that's the source the Configuration Guide is
generated from. This file is for the *prose*: how config flows, what
the moving parts mean, and the small set of cross-option traps that
keep biting people.

This file does **not** cover daemon config (Store, DRO, SRS, lbmrd).
For those see `store_config.md`, `dro_details.md` / `dro_config.md`,
and the Operations Guide.

## 1. Three sources of option values, in precedence order

UM resolves an option's value at object-creation time from three
inputs, applied in this order:

1. **Factory defaults** — built into the library. Always present.
2. **Plain-text config file** (`lbm_config()` or env
   `LBM_FLIGHT_CONFIG_FILENAME` analog) — overwrites the
   process-global *current default attributes*. This shifts UM's
   defaults for every object created after the call.
3. **XML config + custom attributes object** — overlaid at object
   creation. The XML file populates an internal *XML config table*;
   a custom attributes object (from `lbm_*_attr_create_from_xml()`
   or `lbm_*_attr_create()`) holds per-object overrides.

At create time, if the create call has `attr=NULL`, UM copies the
current default attributes. Otherwise UM uses the passed attributes
object as the base. Then UM overlays applicable XML-config-table
options that were not already explicitly set on the attributes.
Finally a small subset of options can still be changed post-create
with `lbm_*_setopt()`.

The ordering matters: a plain-text option set in step 2 stays "tagged
as set" and is **not** overwritten by the XML default in step 3.

## 2. The lbm_*_attr_create vs lbm_*_attr_create_from_xml gotcha

`lbm_*_attr_create()` populates from current default attributes
(factory defaults + plain-text). It does **not** look at the XML
config table. So if you set a default in `test.xml`, then call
`lbm_context_attr_create()` (the non-`from_xml` form), the XML
default is silently ignored. The XML's `<allow>`/`<deny>` constraints
**are** still enforced at create time, so this can also fail in a
confusing way: "I set the default to 13000 in XML, why does my code
get 12000 from the plain-text file *and* fail with a deny error?"

Rule of thumb: always use `lbm_*_attr_create_from_xml()` (with a
descriptive object name, even an empty one), so the XML config
table participates. The `_from_xml` form is also safe when no XML
file has been read — it degrades to the plain `_create` behavior.

## 3. XML config — recommended structure

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<um-configuration version="1.0">
  <templates>
    <template name="...">
      <options type="context"> ... </options>
      <options type="source">  ... </options>
    </template>
  </templates>
  <applications>
    <application name="..." template="...">
      <contexts>
        <context name="...">
          <sources>
            <topic topicname="..."> <options type="source"> ... </options> </topic>
          </sources>
          <receivers>
            <topic topicname="..."> <options type="receiver"> ... </options> </topic>
          </receivers>
        </context>
      </contexts>
      <event-queues>
        <event-queue name="..."/>
      </event-queues>
    </application>
  </applications>
</um-configuration>
```

Key points:

- `<application name="...">` matches the application name supplied at
  startup. Prefer `lbm_config_xml_file(file, appname)`; otherwise set
  `LBM_XML_CONFIG_FILENAME` and `LBM_XML_CONFIG_APPNAME`. The
  application name is **not** the executable name.
- The `<applications>` element is closed: an unmatched application
  name causes init to fail. Either name every app, include an unnamed
  `<application>` element as a fallback, or restrict app names.
- Templates name a reusable bag of options. Apply via
  `template="name"`. If multiple templates set the same option, the
  *last* template wins.
- `<context>`, `<event-queue>` etc. can also be unnamed; an unnamed
  XML element only matches an unnamed object. Pass `NULL` as the
  name in the `_attr_create_from_xml()` call to match.
- Object-name character set is restrictive: alphanumeric, `-`, `_`,
  ≤127 chars. Template/application names allow any printable ASCII,
  ≤99 chars. (They're case-sensitive.)
- All UM **option scopes, names, and values** are case-insensitive.

## 3a. Full resolution order for source/receiver options

When UM resolves options for a source or receiver at object-creation
time, it applies XML config layers in this order. Each layer
**overwrites** options set by prior layers (last layer wins per
option). Source: `lbm_xmlcfg_fill_src_attr()` /
`lbm_xmlcfg_check_src_topic()` in `lbmxmlcfg.c`.

| Layer | XML element | Provenance |
| --- | --- | --- |
| 1 | `<application template="A,B,C">` | Application-level templates, left to right |
| 2 | `<contexts template="...">` | Wrapper-element template (applies to all contexts) |
| 3 | `<context template="...">` | Context-level templates |
| 4 | `<context><options type="...">` | Context-level direct options |
| 5 | `<sources template="...">` / `<receivers template="...">` | Wrapper-element template for all topics in that container |
| 6 | `<topic template="...">` | Per-topic templates |
| 7 | `<topic><options type="...">` | Per-topic direct options |

Layers 2 and 5 are often omitted in configs — they're the
`template=` attribute on the *wrapper* elements (`<contexts>`,
`<sources>`, `<receivers>`), not on the individual `<context>` or
`<topic>`. When present, they insert a template layer between the
application and context (layer 2) or between the context and topic
(layer 5).

Within a template list like `template="A,B,C"`, templates are
applied left to right. Since each application of a template
overwrites prior values, **the last template in the list wins** for
any given option.

Context options (`<options type="context">`) defined in templates
at **any** of layers 1–5 also apply. This is not a scoping error:
a source-level template at layer 5 will still apply its context-
scope options (UM applies all scope types from every layer).

### The `usroptmask` protection

At `lbm_src_topic_alloc()` / `lbm_rcv_topic_lookup()` time (the
"check" path), options that the application has explicitly set via
`lbm_*_attr_str_setopt()` are **protected** — XML config will not
overwrite them. At `lbm_*_attr_create_from_xml()` time (the "fill"
path used for initial population), there is no protection — XML
always wins. The practical effect: an application that creates
attributes from XML and then calls `setopt()` will have its setopt
values survive the later topic-alloc check.

## 3b. Topic matching — first match wins

When UM resolves which `<topic>` entry applies to a given topic name
(for sources or receivers), the algorithm is:

1. **Exact match first.** UM looks up the topic name in a hash map
   of `topicname="..."` entries. If found, that entry wins
   **regardless of its position** in the XML document. No further
   matching occurs.

2. **Pattern scan — first match wins.** Only if no exact match
   exists, UM walks the pattern list (`pattern="..."` entries) in
   document order and **stops at the first match**. It does NOT
   accumulate options from multiple matching patterns.

This has practical consequences for config authoring:

- Putting a more-specific pattern before a less-specific one is
  correct and load-bearing: `^OR\.OC\.PENDING\.[0-9]*[0-1]$` before
  `^OR\.OC\.[0-9]*[0-1]$` ensures PENDING topics get their own
  config rather than falling into the broader bucket.

- If two patterns overlap and a topic matches both, only the
  **first** pattern's options apply. There is no "merge" — the
  second pattern's options are invisible for that topic.

- An exact `topicname=` entry is a guaranteed override that can't
  be shadowed by a pattern earlier in the file. Use it for
  exceptions.

Source: `lbm_xmlcfg_src_match_rule()` in `lbmxmlcfg.c` — the
pattern scan at line ~4218 walks `src_list_pat_allow` (a linked list
in insertion/document order) and `break`s on first match.

## 4. allow / deny — option values vs topic names

The same `order` attribute is used in two places, with the same
semantics: `"allow,deny"` means "default deny if no rule matched";
`"deny,allow"` means "default allow if no rule matched". The
*last-matching* rule wins when multiple match.

### Constraining option values

```xml
<option name="ordered_delivery" order="deny,allow">
  <deny>0</deny>
</option>
```

This denies value 0 only; everything else falls through to the
default `allow`. The reverse `order="allow,deny"` with `<allow>1</allow>`
permits only `1` and denies all else.

### Restricting topic subscription/publication

```xml
<receivers order="allow,deny">
  <topic topicname="general_info" rule="allow"/>
  <topic topicname="alerts" rule="allow"/>
</receivers>
```

Allows only those two topic names for receivers; denies everything
else. The same shape works for `<sources>`. Last-rule-wins lets you
write overlap rules:

```xml
<receivers order="deny,allow">
  <topic pattern="^trade" rule="deny"/>
  <topic pattern="^trade\.NASD" rule="allow"/>
</receivers>
```

`trade.NASD.xyz` matches both; the allow is later, so it's allowed.
`trade.abc` only matches deny. `quote` matches neither, default is
allow.

**Wildcard receivers bypass `<topic>` rules.** If you restrict
topics, also restrict (or disable) wildcard receivers, or your
constraint is decorative:

```xml
<receivers order="allow,deny">
  <topic topicname="general_info" rule="allow"/>
  <topic topicname="alerts" rule="allow"/>
</receivers>
<wildcard-receivers order="allow,deny"/>   <!-- empty: deny all -->
```

## 5. XInclude for shared XML fragments

```xml
<xi:include xmlns:xi="http://www.w3.org/2001/XInclude" href="path-or-url"/>
```

`href` accepts local paths, `http:`, or `ftp:` (no `https`/`sftp`).
The included file must be a **single root element** — don't try to
include a bare list of `<option>` siblings.

Common use: per-topic transport address bindings (these are
disallowed inside `<template>`), factored into a shared file and
re-included from each `<application>`. Avoids hand-replicating the
same 26 topic→address mappings across 100 application elements.

## 6. xml:space and quoting weirdness

XML elements that take text values (`<log>`, `<allow>`, etc.) trim
leading/trailing whitespace and collapse internal runs by default.
If you literally need a leading space or preserved newlines in the
value, set `xml:space="preserve"` on the element.

Interface device names are a separate quoting trap: UM's config
parser uses double quotes around the device name to distinguish it
from a CIDR string. In an XML attribute, you can't include literal
quotes, so use `&quot;` entities:

```xml
<option name="resolver_multicast_interface" default-value="&quot;en0&quot;"/>
```

Same for compound options like `monitor_transport_opts` where a
nested device-name value also needs `&quot;`.

## 7. Configuration error handling

Since UM 6.13, `lbm_config()` and XML parsing log errors and
**continue**, returning `LBM_FAILURE` only at the end. The main
practical effects:

- A typo in a flat-file option logs an error; the rest of the file
  is still applied. Easy to silently overlook a misspelled option,
  so check return values *and* the logger output.
- An XML file with a structural error (bad element, unmatched tags)
  is rejected wholesale — none of the options are applied.
- An XML file with a valid structure but an unknown `<option name>`
  applies the rest and logs the bad option. Same diligence rule.
- Why this is useful: a master config can include options for a
  newer UM version; older instances log a warning but still run.

The Store and DRO configs do *not* use this lenient mode — errors
in those are fatal. UM (library) config errors loaded by the Store
or DRO daemons *do* use the lenient mode.

## 8. Specifying network interfaces

UM's `*_interface` options accept three forms:

- **CIDR** — `192.168.0.0/24`. The prefix length doesn't have to
  match the host's actual netmask; UM scans interfaces and picks the
  first whose IP starts with the masked network. So `10.0.0.0/8` is
  the standard "any 10.* interface" trick (avoids the loopback).
  Without `/n`, an exact-match `/32` is implied — the option's value
  must equal the interface's IP.
- **Device name** — must be in double quotes: `"en0"`. In XML, the
  quotes have to be `&quot;` entities.
- **DNS hostname** — `myhost.mydomain.com` or `myhost.mydomain.com/24`.
  Resolved at config-parse time; doesn't track DNS changes.

On a multi-homed host, *always* specify the resolver multicast
interface explicitly. UM's "first multicast-capable, non-loopback
interface" default depends on OS reporting order, which can change
across kernels and even hardware moves. Setting
`resolver_multicast_interface` also changes the LBT-RM and MIM
interfaces (the same option drives all three).

## 9. Hostname resolution

Any config option that takes an IP address (with a few documented
exceptions) accepts a DNS hostname as of UM 6.10. Names are resolved
**at parse time**, not at use time — change a hostname's IP and the
running app keeps the old IP until restart (or until the config is
re-read).

Names normally hit `/etc/hosts` first on Unix; the strict DNS
resolver isn't necessarily involved.

## 10. Port assignments

Many UM port options are ranges. Each UM instance picks a free port
in the range. If the range is too narrow (or competing software
allocates inside it), instance startup fails. Two common collisions:

- **Ephemeral port range overlap.** The OS hands out ephemeral ports
  dynamically; UM ranges that intersect can be silently stolen.
  Keep UM port ranges outside the ephemeral range (Wikipedia has
  per-OS ranges).
- **Other middleware** allocating in the same range — vet UM ranges
  against everything else on the host.

### Network vs host byte order

When setting ports via the C `*_setopt` binary form:

- **Range options** (`*_port_low`, `*_port_high`): host order.
- **Specific port options** (`transport_tcp_port`, `*_destination_port`):
  network order — wrap with `htons()`.

Each option's `<byte-order>` field in `config-data.xml` documents the
required byte order. String-form `setopt` calls (and config files)
don't have this distinction; the parser handles it.

## 11. Interrelated options — common pairs that must match

Several option pairs encode timer relationships. Setting them
independently produces NAK storms, false timeouts, or undetected
loss. The recurring rule of thumb: *the timeout side has to be a
multiple of the check/keepalive side* so that a single missed check
doesn't trigger the timeout.

| Concern | Options | Rule of thumb |
| --- | --- | --- |
| LBT-RM/RU NAK storms | `transport_*_nak_backoff_interval`, `transport_*_nak_generation_interval` | gen ≥ 2× backoff (gives the source a full backoff window to retransmit before the next NAK fires). |
| Tail loss visibility | `transport_topic_sequence_number_info_interval`, `…_active_threshold`, `transport_*_nak_generation_interval` | active_threshold (sec) ≥ (4× TSNI interval + NAK gen interval) ÷ 1000. |
| Undetected loss (stale delivery controller) | `delivery_control_loss_check_interval`, `transport_*_activity_timeout`, `transport_*_nak_generation_interval` | activity_timeout > loss_check + NAK gen; NAK gen ≥ 4× loss_check. Always enable loss_check_interval for UMP. |
| Late Join transport drop | `retransmit_request_generation_interval`, `transport_*_activity_timeout` | RX-req interval < activity_timeout (otherwise the transport times out *during* late-join recovery). |
| LBT-IPC receiver deafness | `transport_lbtipc_activity_timeout`, `transport_lbtipc_sm_interval` | activity ≥ 2× sm_interval. |
| Erroneous LBT-RM/RU session timeout | `transport_lbt*_activity_timeout`, `transport_lbt*_sm_maximum_interval` | activity ≥ 3× sm_maximum_interval. |
| Store activity timeout | `ume_store_activity_timeout`, `ume_store_check_interval` | activity ≥ 5× check. |
| Unicast resolver timeout | `resolver_unicast_activity_timeout`, `resolver_unicast_check_interval` | activity ≥ 5× check (or both 0 to disable notifications). |
| Store registration hangs | `ume_sri_request_*`, `transport_topic_sequence_number_info_request_*`, `transport_*_activity_timeout` | request duration (interval × maximum) ≥ 2× activity_timeout. **The shipped defaults violate this** — typically need to double `ume_sri_request_maximum` and `transport_topic_sequence_number_info_request_maximum`. |
| Bad multicast address range | `transport_lbtrm_multicast_address_low/high` | Don't reverse them. Reversed values silently produce a huge range, leading to weird allocations and errors. |

When in doubt for a UMP receiver, enable
`delivery_control_loss_check_interval`. It has a per-receiver scan
cost, but without it a fatally-rare class of unrecoverable loss
goes both unreported *and* loses the next buffered message. For
latency-sensitive apps with many receivers, the alternative is to
have the publisher delay deletion by `2 × TSNI_interval +
NAK_generation_interval` (default ≈ 70 s) before deleting a source
that's gone idle.

## 12. Reading config-data.xml

`config-data.xml` is the lookup index for individual options. Each
`<option>` element gives:

- `<scope>` — `context`, `source`, `receiver`, `wildcard_receiver`,
  `event_queue`, or `hfx`. Determines which `<options type="...">`
  block in the XML config it belongs in, and which API call sets it.
- `<datatype>` — `int`, `long`, `string`, `boolean`, etc. Controls
  binary `setopt` form.
- `<description>` / `<long-desc>` — prose; same content the
  generated HTML reference shows.
- `<default-value>` — the factory default. Many options have
  conditional defaults (per-platform, per-product); look for
  `<value-list>` or `<enumerated-values>` for the full picture.
- `<enumerated-values>` — for enum options, lists string names,
  numeric constants, and per-value descriptions. The string name is
  what goes into a config file; the C constant is what `setopt` takes
  in binary form.
- `<units>`, `<byte-order>` — when applicable.
- `<may-be-set-during-operation>` — whether `lbm_*_setopt()` works
  on a created object (vs only on attributes pre-create).

When the user asks "what does option X do," `grep '<name>X</name>'`
in `config-data.xml` then read the surrounding `<option>` block.

## 13. The shipped recipe configurations

The Configuration Guide includes a few "recipe" configs in section
**Example Configuration Scenarios** (`\m4_pg
exampleconfigurationscenarios` in `index.m4`). Useful starting
points, not gospel:

- **Highest throughput.** Bump `source implicit_batching_minimum_length`
  (default 2048) up to 8192. Trades latency for batch-size efficiency.
- **Lowest latency.** Set both `mim_implicit_batching_minimum_length`
  and `source implicit_batching_minimum_length` to 1 (effectively
  disables implicit batching). Set `receiver ordered_delivery 0` if
  the app can handle arrival-order. Disable Nagle on TCP responses
  with `context response_tcp_nodelay 1`. On small LANs, drop
  `transport_lbtrm_nak_backoff_interval` to ~10 ms for faster
  recovery.
- **Multicast sources by default.** `source transport LBT-RM` plus
  modest `transport_lbtrm_data_rate_limit` and
  `transport_lbtrm_retransmit_rate_limit`. Always start small on
  rate limits and raise after testing.

## 14. Pre-4.0 / pre-3.3 compatibility configs

Two recipes exist to coexist with very old UM versions
(`reestablishpre40topicresolution`, `reestablishprelbm33preume20portdefaults`).
Don't enable these unless you're forced to interop with an old
deployment — they revert security/scalability fixes that have been
the default for a decade. The 3.3-era port defaults have a single-
env-var alternative: `LBM_USE_ORIG_DEFAULT_PORTS=1`.
