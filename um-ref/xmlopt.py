#!/usr/bin/env python3
r"""
xmlopt.py — query tool for Store and DRO XML configuration options.

Sources:
  ume  = doc/UME/index.m4    (Store / umestored config)
  dro  = doc/Gateway/index.m4 (DRO / tnw-gateway config)

The %descr/%default/%example section (between %top and __EOF__) covers the
XML element hierarchy.  For the Store, the \m4_s2 umecfg* section below
__EOF__ covers <ume-attributes><option type="store" ...> values.

Usage:
  xmlopt.py ume <id>            summary (description + default) for element-id
  xmlopt.py dro <id>            same for DRO
  xmlopt.py ume <id> --full     include example XML
  xmlopt.py dro <id> --full     same for DRO
  xmlopt.py ume --list          list all element ids
  xmlopt.py dro --list          same for DRO
  xmlopt.py ume --search <kw>   list ids containing keyword
  xmlopt.py dro --search <kw>   same for DRO

Element-id conventions (same in both files):
  <element>               e.g.  store
  <element>.<attribute>   e.g.  store.name
  <element>.<attr>.<val>  e.g.  store.name.default   (enumerated value)

For Store <ume-attributes> options (type="store"):
  xmlopt.py ume store-opt <name>    e.g.  store-opt source-activity-timeout
  xmlopt.py ume store-opt --list
"""  # noqa: W605

import re
import sys
import os

# Locate the m4 sources for each guide. Priority per source:
#   1. ./lbm_repo/doc/<Guide>/index.m4       (symlink in cwd — no env var,
#                                             no permission prompt)
#   2. $LBM_REPO/doc/<Guide>/index.m4        (internal, live source)
#   3. <this-script-dir>/index-<key>.m4      (bundled fallback,
#                                             version-locked to the skill
#                                             release)
# LBM_DOC (built HTML) is not a candidate — the parser is m4-specific.
_script_dir = os.path.dirname(os.path.abspath(__file__))

_REPO_PATHS = {
    'ume': ('UME',     'index-ume.m4'),
    'dro': ('Gateway', 'index-dro.m4'),
}

def _locate(key):
    guide, bundled_name = _REPO_PATHS[key]
    for base in (os.path.abspath('lbm_repo'), os.environ.get('LBM_REPO')):
        if base:
            p = os.path.join(base, 'doc', guide, 'index.m4')
            if os.path.isfile(p):
                return p
    p = os.path.join(_script_dir, bundled_name)
    if os.path.isfile(p):
        return p
    return None

SOURCES = {k: _locate(k) for k in _REPO_PATHS}
if not any(SOURCES.values()):
    sys.exit("error: no m4 sources found. Create an lbm_repo symlink in "
             "the cwd, set LBM_REPO, or place index-ume.m4 / index-dro.m4 "
             "alongside this script.")


# ---------------------------------------------------------------------------
# Shared text helpers
# ---------------------------------------------------------------------------

def clean(text):
    """Strip m4/doxygen markup and normalise whitespace."""
    text = re.sub(r'\\ref\s+\S+', '', text)
    text = re.sub(r'\\b\s', '', text)
    text = re.sub(r'\\note\b', 'NOTE:', text)
    text = re.sub(r'\\warning\b', 'WARNING:', text)
    text = re.sub(r'<[^>]+>', '', text)          # HTML tags
    text = re.sub(r'&lt;', '<', text)
    text = re.sub(r'&gt;', '>', text)
    text = re.sub(r'&amp;', '&', text)
    text = re.sub(r'&[a-zA-Z][a-zA-Z0-9]*;', '', text)
    text = re.sub(r'\s+', ' ', text)
    return text.strip()


def wrap(text, width=78, indent='  '):
    words = text.split()
    lines, line = [], indent
    for w in words:
        if len(line) + len(w) + 1 > width:
            lines.append(line)
            line = indent + w
        else:
            line += (' ' if line.strip() else '') + w
    if line.strip():
        lines.append(line)
    return '\n'.join(lines)


# ---------------------------------------------------------------------------
# Parser for %top … __EOF__ section
# ---------------------------------------------------------------------------

def load_pct_section(path):
    """
    Parse the %descr / %default / %example block between %top and __EOF__.
    Returns dict keyed by element-id:
      { 'desc': str, 'default': str|None, 'example': str|None }
    """
    with open(path) as f:
        lines = f.readlines()

    # Find the %top line and the __EOF__ line
    top_line = next((i for i, l in enumerate(lines) if l.startswith('%top ')), None)
    eof_line = next((i for i, l in enumerate(lines)
                     if l.strip() == '__EOF__' and i > (top_line or 0)), None)
    if top_line is None:
        return {}
    end = eof_line if eof_line is not None else len(lines)

    section = lines[top_line:end]

    # Collect all %descr, %default, %example markers with their line positions
    markers = []
    for i, line in enumerate(section):
        for tag in ('%descr ', '%default ', '%example '):
            if line.startswith(tag):
                markers.append((i, tag.strip(), line[len(tag):].strip()))

    results = {}

    for mi, (pos, tag, eid) in enumerate(markers):
        if tag != '%descr':
            continue

        # Description = prose text immediately before this %descr marker
        # Scan backwards from pos to find the prose block
        prose_lines = []
        scan = pos - 1
        while scan >= 0:
            l = section[scan].rstrip()
            if l.startswith('%') or l == '###':
                break
            prose_lines.insert(0, l)
            scan -= 1
        desc = clean(' '.join(prose_lines))

        # Default = look for a %default <eid> entry after this point
        default_val = None
        for j in range(mi + 1, len(markers)):
            npos, ntag, neid = markers[j]
            if ntag == '%default' and neid == eid:
                # value is the line(s) immediately before this %default
                val_lines = []
                vscan = npos - 1
                while vscan >= 0:
                    l = section[vscan].rstrip()
                    if l.startswith('%') or l == '###':
                        break
                    val_lines.insert(0, l)
                    vscan -= 1
                default_val = clean(' '.join(val_lines)) or None
                break
            # Stop searching at next %descr for a different id prefix
            # (don't cross into a sibling element's block)
            if ntag == '%descr' and not neid.startswith(eid):
                break

        # Example = code block before a %example <eid> marker
        example_val = None
        for j in range(mi + 1, len(markers)):
            npos, ntag, neid = markers[j]
            if ntag == '%example' and neid == eid:
                # Extract \code ... \endcode block before this line
                block_lines = []
                in_code = False
                for vscan in range(npos - 1, max(0, npos - 60), -1):
                    pass  # find range
                # Forward scan from after the %descr to the %example
                code_text = []
                in_code = False
                for vscan in range(pos + 1, npos):
                    l = section[vscan].rstrip()
                    if l.strip() == r'\code':
                        in_code = True
                        code_text = []
                    elif l.strip() == r'\endcode':
                        in_code = False
                    elif in_code:
                        code_text.append(l)
                if code_text:
                    example_val = '\n'.join(code_text)
                break
            if ntag == '%descr' and not neid.startswith(eid + '.') and neid != eid:
                break

        results[eid] = {
            'desc': desc,
            'default': default_val,
            'example': example_val,
        }

    return results


# ---------------------------------------------------------------------------
# Parser for UME \m4_s2 umecfg* store option sections (below __EOF__)
# ---------------------------------------------------------------------------

def load_store_options(path):
    r"""
    Parse \m4_s2 umecfg<anchor> Store Option "<name>" sections.
    Returns dict keyed by option name (lowercased):
      { 'anchor': str, 'desc': str, 'default': str|None, 'example': str|None }
    """
    with open(path) as f:
        content = f.read()

    results = {}
    pattern = re.compile(
        r'\\m4_s2\s+umecfg\w+\s+(?:Store|Topic) Option "([^"]+)"(.*?)(?=\\m4_s[12]\s|\\m4_pg\s|\Z)',
        re.DOTALL
    )
    for m in pattern.finditer(content):
        name = m.group(1)
        body = m.group(2)

        # Description = text before <b>Default
        desc_m = re.split(r'<b>Default', body, maxsplit=1)
        desc = clean(desc_m[0]) if desc_m else ''

        # Default = between \verbatim and \endverbatim
        default_m = re.search(r'\\verbatim(.*?)\\endverbatim', body, re.DOTALL)
        default = default_m.group(1).strip() if default_m else None

        # Example = between \code and \endcode (last occurrence)
        examples = re.findall(r'\\code(.*?)\\endcode', body, re.DOTALL)
        example = examples[-1].strip() if examples else None

        results[name.lower()] = {
            'name': name,
            'desc': desc,
            'default': default,
            'example': example,
        }

    return results


# ---------------------------------------------------------------------------
# Formatting
# ---------------------------------------------------------------------------

def fmt_pct(eid, entry, full=False):
    lines = [f"Element : {eid}"]
    if entry['desc']:
        lines.append('')
        lines.append(wrap(entry['desc']))
    if entry['default'] is not None:
        lines.append('')
        lines.append(f"Default : {entry['default']}")
    if full and entry['example']:
        lines.append('')
        lines.append('Example:')
        for l in entry['example'].splitlines():
            lines.append('  ' + l)
    return '\n'.join(lines)


def fmt_store_opt(name, entry, full=False):
    lines = [f"Store option : {entry['name']}"]
    if entry['desc']:
        lines.append('')
        lines.append(wrap(entry['desc']))
    if entry['default'] is not None:
        lines.append('')
        lines.append(f"Default : {entry['default']}")
    if full and entry['example']:
        lines.append('')
        lines.append('Example:')
        for l in entry['example'].splitlines():
            lines.append('  ' + l)
    return '\n'.join(lines)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def usage():
    print(__doc__)
    sys.exit(0)


def main():
    args = sys.argv[1:]
    if len(args) < 2:
        usage()

    source = args[0].lower()
    if source not in SOURCES:
        print(f"Unknown source '{source}'. Use 'ume' or 'dro'.")
        sys.exit(1)

    path = SOURCES[source]
    if path is None:
        guide, bundled = _REPO_PATHS[source]
        sys.exit(
            f"error: no source found for '{source}'. Set LBM_REPO (looks "
            f"for doc/{guide}/index.m4), or place {bundled} alongside "
            f"this script."
        )
    cmd = args[1]
    full = '--full' in args

    # ---- store-opt subcommand (UME only) ----
    if cmd == 'store-opt':
        if source != 'ume':
            print("store-opt is only available for 'ume'.")
            sys.exit(1)
        opts = load_store_options(path)
        if len(args) < 3 or args[2] == '--list':
            for name in sorted(opts):
                d = opts[name]['default'] or '(none)'
                print(f"  {name:50} default={d}")
            return
        name = args[2].lower()
        if name not in opts:
            # fuzzy
            matches = [k for k in opts if name in k]
            if matches:
                print(f"No exact match for '{name}'. Did you mean:")
                for m in sorted(matches):
                    print(f"  {m}")
            else:
                print(f"Store option '{name}' not found.")
            sys.exit(1)
        print(fmt_store_opt(name, opts[name], full=full))
        return

    # ---- --list ----
    if cmd == '--list':
        data = load_pct_section(path)
        for eid in sorted(data):
            d = data[eid]['default']
            suffix = f"  default={d}" if d else ''
            print(f"  {eid}{suffix}")
        return

    # ---- --search ----
    if cmd == '--search':
        if len(args) < 3:
            print("Usage: xmlopt.py <ume|dro> --search <keyword>")
            sys.exit(1)
        kw = args[2].lower()
        data = load_pct_section(path)
        matches = [eid for eid in sorted(data) if kw in eid.lower()]
        if not matches:
            print(f"No element ids matching '{kw}'")
        for eid in matches:
            d = data[eid]['default']
            suffix = f"  default={d}" if d else ''
            print(f"  {eid}{suffix}")
        return

    # ---- element-id lookup ----
    eid = cmd
    data = load_pct_section(path)
    if eid not in data:
        matches = [k for k in data if eid.lower() in k.lower()]
        if matches:
            print(f"No exact match for '{eid}'. Did you mean:")
            for m in sorted(matches):
                print(f"  {m}")
        else:
            print(f"Element id '{eid}' not found.")
        sys.exit(1)
    print(fmt_pct(eid, data[eid], full=full))


if __name__ == '__main__':
    main()
