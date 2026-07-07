#!/usr/bin/env python3
"""
lbmopt.py — query tool for config-data.xml

Usage:
  lbmopt.py <name>                  show scope(s) and default(s) for an option
  lbmopt.py <name> <scope>          full dump for name+scope
  lbmopt.py --search <keyword>      list options whose name contains keyword
  lbmopt.py --list-scopes           list all known scopes
  lbmopt.py --scope <scope>         list all options in a scope
"""

import re
import sys
import os

# Locate config-data.xml. Priority:
#   1. ./lbm_repo/doc/Config/reference/config-data.xml   (symlink in cwd —
#                                                         no env var, no
#                                                         permission prompt)
#   2. $LBM_REPO/doc/Config/reference/config-data.xml    (internal, live)
#   3. <this-script-dir>/config-data.xml                 (bundled fallback,
#                                                         version-locked to
#                                                         the skill release)
# LBM_DOC (the built HTML tree) does not contain the raw XML, so it is
# not a candidate here — customers without LBM_REPO fall through to the
# bundled copy.
def _find_repo_xml():
    rel = os.path.join('doc', 'Config', 'reference', 'config-data.xml')
    for base in (os.path.abspath('lbm_repo'), os.environ.get('LBM_REPO')):
        if base and os.path.isfile(os.path.join(base, rel)):
            return os.path.join(base, rel)
    return None

_repo_xml = _find_repo_xml()
_bundled  = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                         'config-data.xml')
if _repo_xml:
    XML = _repo_xml
elif os.path.isfile(_bundled):
    XML = _bundled
else:
    sys.exit("error: config-data.xml not found. Create an lbm_repo "
             "symlink in the cwd, set LBM_REPO, or place config-data.xml "
             "alongside this script.")


def clean(text):
    """Strip inner tags and normalise whitespace."""
    text = re.sub(r'<[^>]+>', ' ', text)
    text = re.sub(r'\\ref\s+\S+', '', text)   # doxygen \ref
    text = re.sub(r'\\note\b', 'NOTE:', text)
    text = re.sub(r'\\warning\b', 'WARNING:', text)
    text = re.sub(r'&lt;', '<', text)
    text = re.sub(r'&gt;', '>', text)
    text = re.sub(r'&amp;', '&', text)
    text = re.sub(r'&[a-zA-Z][a-zA-Z0-9]*;', '', text)  # unknown entities
    text = re.sub(r'\s+', ' ', text)
    return text.strip()


def load_options(xml_path):
    with open(xml_path) as f:
        content = f.read()
    options = []
    for block in re.finditer(r'<option>(.*?)</option>', content, re.DOTALL):
        b = block.group(1)
        scope_m  = re.search(r'<scope>(.*?)</scope>', b)
        name_m   = re.search(r'<name>([^<\n]+)</name>', b)
        if not (scope_m and name_m):
            continue
        scope   = scope_m.group(1).strip()
        name    = name_m.group(1).strip()
        default_m = re.search(r'<default-value>(.*?)</default-value>', b, re.DOTALL)
        if default_m:
            default = clean(default_m.group(1))
        else:
            # Some options define their default via <switch-values> instead
            # of <default-value>. Two shapes:
            #   1) boolean:  <value-true default="all">...</value-true>
            #                <value-false>...</value-false>
            #   2) enum:     <value default="all">
            #                    <string-name>"epoll"</string-name>
            #                </value>
            # `default="..."` can be "all", "Unix", "Windows", "Linux".
            # Multiple platform-specific defaults may coexist on one option
            # (e.g. select on Unix, wincompport on Windows).
            defaults = []
            for m in re.finditer(
                r'<(value-true|value-false|value)\s+default="([^"]+)"([^>]*)>'
                r'(.*?)</\1>',
                b, re.DOTALL,
            ):
                kind, plat, _rest, body = m.groups()
                if kind == 'value-true':
                    val = '1 (true)'
                elif kind == 'value-false':
                    val = '0 (false)'
                else:
                    # Enum value: pick the <string-name> if present, else
                    # the <const-name>, else literal "(default)".
                    sn = re.search(r'<string-name>(.*?)</string-name>',
                                   body, re.DOTALL)
                    cn = re.search(r'<const-name>(.*?)</const-name>',
                                   body, re.DOTALL)
                    val = clean(sn.group(1)) if sn else (
                        clean(cn.group(1)) if cn else '(default)')
                if plat == 'all':
                    defaults.append(val)
                else:
                    defaults.append(f"{val} ({plat} default)")
            default = ', '.join(defaults) if defaults else '(none)'
        units_m = re.search(r'<units>(.*?)</units>', b, re.DOTALL)
        units   = clean(units_m.group(1)) if units_m else ''
        dtype_m = re.search(r'<datatype>(.*?)</datatype>', b, re.DOTALL)
        dtype   = clean(dtype_m.group(1)) if dtype_m else ''
        group_m = re.search(r'<group>(.*?)</group>', b, re.DOTALL)
        group   = clean(group_m.group(1)) if group_m else ''
        desc_m  = re.search(r'<description>(.*?)</description>', b, re.DOTALL)
        desc    = clean(desc_m.group(1)) if desc_m else ''
        long_m  = re.search(r'<long-desc>(.*?)</long-desc>', b, re.DOTALL)
        long    = clean(long_m.group(1)) if long_m else ''

        # enumerated values
        enums = []
        for val in re.finditer(r'<value([^>]*)>(.*?)</value>', b, re.DOTALL):
            attrs = val.group(1)
            vb    = val.group(2)
            is_default = 'default' in attrs
            names_v = re.findall(r'<string-name>([^<]+)</string-name>', vb)
            vdesc_m = re.search(r'<description>(.*?)</description>', vb, re.DOTALL)
            vdesc   = clean(vdesc_m.group(1)) if vdesc_m else ''
            enums.append({
                'names':   [n.strip().strip('"').rstrip(',').strip('"') for n in names_v],
                'default': is_default,
                'desc':    vdesc,
            })

        options.append({
            'scope': scope, 'name': name, 'default': default,
            'units': units, 'dtype': dtype, 'group': group,
            'desc': desc, 'long': long, 'enums': enums,
        })
    return options


def fmt_option(opt):
    lines = []
    lines.append(f"Option : {opt['name']}")
    lines.append(f"Scope  : {opt['scope']}")
    lines.append(f"Type   : {opt['dtype']}")
    if opt['units']:
        lines.append(f"Units  : {opt['units']}")
    lines.append(f"Default: {opt['default']}")
    if opt['group']:
        lines.append(f"Group  : {opt['group']}")
    lines.append("")
    if opt['desc']:
        lines.append(f"Description:\n  {opt['desc']}")
        lines.append("")
    if opt['long']:
        # wrap at 78 chars
        words = opt['long'].split()
        line = "  "
        wrapped = []
        for w in words:
            if len(line) + len(w) + 1 > 78:
                wrapped.append(line)
                line = "  " + w
            else:
                line += (" " if line.strip() else "") + w
        if line.strip():
            wrapped.append(line)
        lines.append("Detail:\n" + "\n".join(wrapped))
        lines.append("")
    if opt['enums']:
        lines.append("Values:")
        for e in opt['enums']:
            marker = " [DEFAULT]" if e['default'] else ""
            names_str = ", ".join(e['names']) if e['names'] else "(unnamed)"
            lines.append(f"  {names_str}{marker}")
            if e['desc']:
                lines.append(f"    {e['desc']}")
    return "\n".join(lines)


def main():
    args = sys.argv[1:]
    if not args:
        print(__doc__)
        sys.exit(0)

    opts = load_options(XML)

    if args[0] == '--list-scopes':
        scopes = sorted(set(o['scope'] for o in opts))
        for s in scopes:
            count = sum(1 for o in opts if o['scope'] == s)
            print(f"  {s:30} ({count} options)")
        return

    if args[0] == '--search' and len(args) >= 2:
        kw = args[1].lower()
        matches = [o for o in opts if kw in o['name'].lower()]
        if not matches:
            print(f"No options matching '{kw}'")
            return
        # group by name
        by_name = {}
        for o in matches:
            by_name.setdefault(o['name'], []).append(o['scope'])
        for name, scopes in sorted(by_name.items()):
            print(f"  {name}  [{', '.join(scopes)}]")
        return

    if args[0] == '--scope' and len(args) >= 2:
        scope = args[1].lower()
        matches = sorted(set(o['name'] for o in opts if o['scope'] == scope))
        if not matches:
            print(f"No options for scope '{scope}'")
            return
        for name in matches:
            # find default
            for o in opts:
                if o['name'] == name and o['scope'] == scope:
                    print(f"  {name:60} default={o['default']}")
                    break
        return

    # positional: name [scope]
    name = args[0]
    scope_filter = args[1].lower() if len(args) >= 2 else None

    matches = [o for o in opts if o['name'] == name]
    if not matches:
        # fuzzy: substring
        matches = [o for o in opts if name.lower() in o['name'].lower()]
        if matches:
            by_name = {}
            for o in matches:
                by_name.setdefault(o['name'], []).append(o['scope'])
            print(f"No exact match for '{name}'. Did you mean:")
            for n, scopes in sorted(by_name.items()):
                print(f"  {n}  [{', '.join(scopes)}]")
        else:
            print(f"Option '{name}' not found.")
        sys.exit(1)

    if scope_filter:
        matches = [o for o in matches if o['scope'] == scope_filter]
        if not matches:
            print(f"Option '{name}' not found in scope '{scope_filter}'.")
            sys.exit(1)
        print(fmt_option(matches[0]))
    else:
        if len(matches) == 1:
            # Single match — print summary + ask for full dump hint
            o = matches[0]
            print(f"{o['name']}  scope={o['scope']}  default={o['default']}")
            if o['units']:
                print(f"  units: {o['units']}")
            print(f"  {o['desc']}")
            print(f"\n(Use: lbmopt.py {name} {o['scope']} for full detail)")
        else:
            # Multiple scopes — list them
            print(f"'{name}' exists in multiple scopes:")
            for o in matches:
                print(f"  scope={o['scope']:20} default={o['default']}")
            print(f"\n(Use: lbmopt.py {name} <scope> for full detail)")


if __name__ == '__main__':
    main()
