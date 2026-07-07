#!/usr/bin/env python3
"""
gen_java_api.py - Scan Java source files and produce java_api.md.

For every public API function/constructor that has a Doxygen (Javadoc)
description directly preceding it, emit:
  - the containing class
  - the function signature
  - the cleaned-up Doxygen description

A "public API function" here means:
  - a method or constructor (must have parentheses in its signature)
  - declared in a `public class` and marked `public`, OR
  - declared in a `public interface` and not explicitly `private`/`protected`
  - has a `/** ... */` block immediately preceding it

Default scan root is the com/latencybusters/lbm package under
../../../src/java/ (relative to this script's location in the
um-ref skill directory). Output is written to java_api.md in the
script's directory.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from pathlib import Path

# Things that look like they might be a function but aren't (control flow,
# initializer blocks, etc.).
NON_FUNCTION_KEYWORDS = {
    "if", "while", "for", "switch", "catch", "return", "throw", "new",
    "synchronized",  # synchronized(this){...} blocks
}

DOXYGEN_RE = re.compile(r"/\*\*(?P<body>.*?)\*/", re.DOTALL)


def clean_doxygen(raw: str) -> str:
    """Strip the /** */ markers and leading-asterisk decoration, then
    dedent so that no line accidentally renders as a code block."""
    body = re.sub(r"^/\*\*", "", raw)
    body = re.sub(r"\*/\s*$", "", body)
    lines = []
    for line in body.splitlines():
        # Drop a leading "  *" or "  * " from each line (Javadoc style).
        stripped = re.sub(r"^\s*\*\s?", "", line)
        lines.append(stripped.rstrip())
    # Trim leading/trailing blank lines.
    while lines and not lines[0].strip():
        lines.pop(0)
    while lines and not lines[-1].strip():
        lines.pop()
    if not lines:
        return ""
    # Normalize tabs to spaces *before* computing the common prefix so
    # mixed tab/space indentation in the source still dedents cleanly.
    lines = [ln.expandtabs(4) for ln in lines]
    # Dedent: find common leading whitespace among non-empty lines and
    # strip it. Markdown treats 4+ leading spaces as a code block, which
    # we don't want for prose paragraphs.
    non_empty = [ln for ln in lines if ln.strip()]
    common = None
    for ln in non_empty:
        m = re.match(r" *", ln)
        prefix = m.group(0) if m else ""
        if common is None:
            common = prefix
        else:
            i = 0
            while i < len(common) and i < len(prefix) and common[i] == prefix[i]:
                i += 1
            common = common[:i]
            if not common:
                break
    if common:
        lines = [ln[len(common):] if ln.startswith(common) else ln
                 for ln in lines]
    return "\n".join(lines)


def class_kind(content: str, class_name: str) -> str | None:
    """Return 'class', 'interface', 'enum', or None for the top-level
    public type matching class_name. Falls back to any public type."""
    pat = re.compile(
        r"\bpublic\s+(?:abstract\s+|final\s+|static\s+)*"
        r"(?P<kind>class|interface|enum)\s+(?P<name>\w+)"
    )
    first = None
    for m in pat.finditer(content):
        if first is None:
            first = m
        if m.group("name") == class_name:
            return m.group("kind")
    return first.group("kind") if first else None


def collapse_signature(text: str) -> str | None:
    """Given text starting at (or just before) a candidate signature,
    return the signature string (everything up to but not including the
    first '{' or ';' that terminates the declaration), or None if no
    signature can be found."""
    # Track parens/angle brackets so we don't terminate at a '{' or ';'
    # that lives inside a default value or generic bound.
    depth_paren = 0
    depth_angle = 0
    end = -1
    for i, ch in enumerate(text):
        if ch == '(':
            depth_paren += 1
        elif ch == ')':
            depth_paren -= 1
        elif ch == '<':
            depth_angle += 1
        elif ch == '>':
            depth_angle -= 1
        elif ch in '{;' and depth_paren == 0 and depth_angle == 0:
            end = i
            break
    if end < 0:
        return None
    sig = text[:end]
    # Collapse internal whitespace to single spaces.
    sig = re.sub(r"\s+", " ", sig).strip()
    return sig if sig else None


def looks_like_function(sig: str) -> bool:
    """Return True if sig looks like a method/constructor (has '(' and is
    not an assignment to a field initializer that happens to call a
    function)."""
    paren = sig.find('(')
    if paren < 0:
        return False
    head = sig[:paren]
    # Field initializers like `public Foo bar = something(` would have '='
    # in the head.
    if '=' in head:
        return False
    # Identify the token immediately before '(' as the method name.
    m = re.search(r"(\w+)\s*$", head)
    if not m:
        return False
    name = m.group(1)
    if name in NON_FUNCTION_KEYWORDS:
        return False
    return True


def signature_method_name(sig: str) -> str:
    """Extract the method/constructor name from a signature string."""
    head = sig.split('(', 1)[0].rstrip()
    m = re.search(r"(\w+)\s*$", head)
    return m.group(1) if m else "?"


def is_publicly_accessible(sig: str, owner_kind: str) -> bool:
    """Decide whether a signature is part of the public API.
    For classes/enums: must contain `public`.
    For interfaces: must NOT contain `private` or `protected` (other
    methods are implicitly public)."""
    head = sig.split('(', 1)[0]
    tokens = set(re.findall(r"\b\w+\b", head))
    if owner_kind == "interface":
        return not (tokens & {"private", "protected"})
    # class or enum
    return "public" in tokens


def extract_signature_after(content: str, start: int) -> str | None:
    """Walk forward from `start` (just past the */ of the Doxygen block),
    skipping whitespace and Java annotations, and return the signature
    string for the immediately following declaration, if any."""
    pos = start
    n = len(content)
    while pos < n:
        # Skip whitespace.
        while pos < n and content[pos].isspace():
            pos += 1
        if pos >= n:
            return None
        # Skip line comments.
        if content.startswith("//", pos):
            nl = content.find("\n", pos)
            if nl < 0:
                return None
            pos = nl + 1
            continue
        # Another Doxygen block means the original comment didn't actually
        # attach to a declaration.
        if content.startswith("/**", pos):
            return None
        # Skip plain block comments between the Doxygen and the declaration.
        if content.startswith("/*", pos):
            close = content.find("*/", pos + 2)
            if close < 0:
                return None
            pos = close + 2
            continue
        # Skip annotations: @Foo or @Foo(...).
        if content[pos] == '@':
            # Skip the identifier.
            m = re.match(r"@\s*\w+(?:\.\w+)*", content[pos:])
            if not m:
                return None
            pos += m.end()
            # Optional argument list — match balanced parens.
            while pos < n and content[pos].isspace():
                pos += 1
            if pos < n and content[pos] == '(':
                depth = 0
                while pos < n:
                    if content[pos] == '(':
                        depth += 1
                    elif content[pos] == ')':
                        depth -= 1
                        if depth == 0:
                            pos += 1
                            break
                    pos += 1
            continue
        # We're at the first non-whitespace, non-annotation character —
        # this should be the start of the declaration.
        return collapse_signature(content[pos:])
    return None


def extract_api(filepath: Path):
    try:
        content = filepath.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        content = filepath.read_text(encoding="latin-1")
    class_name = filepath.stem
    kind = class_kind(content, class_name)
    if kind is None:
        # Not a public top-level type — skip the whole file.
        return []

    entries = []
    for m in DOXYGEN_RE.finditer(content):
        doxy_raw = m.group(0)
        sig = extract_signature_after(content, m.end())
        if not sig:
            continue
        if not looks_like_function(sig):
            continue
        if not is_publicly_accessible(sig, kind):
            continue
        entries.append({
            "class": class_name,
            "kind": kind,
            "method": signature_method_name(sig),
            "signature": sig,
            "doxygen": clean_doxygen(doxy_raw),
        })
    return entries


def render_markdown(by_class: dict[str, list[dict]]) -> str:
    out = []
    out.append("# Java API Reference")
    out.append("")
    out.append("Auto-generated from Javadoc-documented public API in the "
               "`com.latencybusters.lbm` package.")
    out.append("")

    for cls in sorted(by_class):
        entries = by_class[cls]
        kind = entries[0]["kind"]
        out.append(f"## {cls}")
        out.append("")
        out.append(f"*{kind}* `com.latencybusters.lbm.{cls}`")
        out.append("")
        # De-dup identical signatures (rare, but possible).
        seen = set()
        for e in entries:
            if e["signature"] in seen:
                continue
            seen.add(e["signature"])
            out.append(f"### {e['method']}")
            out.append("")
            out.append("```java")
            out.append(e["signature"])
            out.append("```")
            out.append("")
            if e["doxygen"]:
                out.append(e["doxygen"])
                out.append("")
    return "\n".join(out).rstrip() + "\n"


def main(argv=None):
    here = Path(__file__).resolve().parent
    _lbm_repo = os.environ.get('LBM_REPO')
    if not _lbm_repo:
        sys.exit("error: LBM_REPO environment variable is not set")
    default_root = Path(_lbm_repo) / "src" / "java" / "com" / "latencybusters" / "lbm"
    default_out = here / "java_api.md"

    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", type=Path, default=default_root,
                    help=f"Directory to scan recursively for .java files "
                         f"(default: {default_root})")
    ap.add_argument("--out", type=Path, default=default_out,
                    help=f"Output markdown file (default: {default_out})")
    args = ap.parse_args(argv)

    if not args.root.is_dir():
        print(f"error: --root not a directory: {args.root}", file=sys.stderr)
        return 2

    java_files = sorted(args.root.rglob("*.java"))
    if not java_files:
        print(f"warning: no .java files under {args.root}", file=sys.stderr)

    by_class: dict[str, list[dict]] = {}
    total = 0
    for jf in java_files:
        for entry in extract_api(jf):
            by_class.setdefault(entry["class"], []).append(entry)
            total += 1

    md = render_markdown(by_class)
    args.out.write_text(md, encoding="utf-8")
    print(f"Scanned {len(java_files)} files; "
          f"emitted {total} API entries across {len(by_class)} classes -> "
          f"{args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
