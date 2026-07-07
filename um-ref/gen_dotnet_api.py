#!/usr/bin/env python3
"""
gen_dotnet_api.py - Scan C# source files and produce dotnet_api.md.

For every public API function/constructor/delegate that has a C# XML
documentation comment ('///' lines) directly preceding it, emit:
  - the containing class (or namespace, for top-level delegates)
  - the function signature
  - the cleaned-up XML documentation

A "public API function" here means:
  - a method, constructor, or delegate declaration (must have parens)
  - declared in a `public class`/`public struct`/`public interface` and
    marked `public` (or implicitly public if inside a `public interface`)
  - has a `///` doc-comment block immediately preceding it

Default scan root is the lbmcs/ directory under ../../../src/dotnet/
(relative to this script's location in the um-ref skill directory).
SDM (lbmcs/sdm/) and example/ programs are excluded. Output is
written to dotnet_api.md in the script's directory.
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
    "if", "while", "for", "foreach", "switch", "catch", "return", "throw",
    "new", "lock", "using", "fixed", "checked", "unchecked",
}

# Modifiers and type keywords we strip when extracting a method/identifier
# name. (Used only for context, not name extraction.)
TYPE_KEYWORDS = {"class", "struct", "interface", "enum", "delegate"}

DOC_LINE_RE = re.compile(r"^\s*///")


def clean_doc(lines: list[str]) -> str:
    """Strip the leading '///' from each line and outdent. Lines may
    contain XML doc tags; we collapse <summary>...</summary> wrappers
    into plain prose so the markdown renders cleanly."""
    stripped = []
    for line in lines:
        m = re.match(r"^(\s*)///\s?(.*)$", line)
        if not m:
            continue
        stripped.append(m.group(2).rstrip())
    # Trim leading/trailing blank lines.
    while stripped and not stripped[0].strip():
        stripped.pop(0)
    while stripped and not stripped[-1].strip():
        stripped.pop()
    if not stripped:
        return ""
    # Drop <summary>/</summary> wrappers (both standalone-line and inline)
    # since they're noise in markdown. Other XML doc tags (<param>,
    # <remarks>, <returns>, <exception>, <seealso>, <list>, etc.) are
    # left intact — they're the C# equivalent of Javadoc's @-tags.
    out = []
    for line in stripped:
        line = re.sub(r"</?summary>", "", line)
        if not line.strip() and out and not out[-1].strip():
            continue  # collapse runs of blank lines
        out.append(line.rstrip())
    while out and not out[0].strip():
        out.pop(0)
    while out and not out[-1].strip():
        out.pop()
    return "\n".join(out).rstrip()


def collapse_signature(text: str) -> str | None:
    """Given text starting at (or just before) a candidate signature,
    return the signature string (everything up to but not including the
    first '{' or ';' that terminates the declaration), or None if no
    signature can be found.

    For C#, properties end with `{` (start of accessor block) but have
    no parens. Methods/constructors end with either `;` (extern,
    interface, abstract, expression-bodied) or `{`. Delegates end with
    `;`."""
    depth_paren = 0
    depth_angle = 0
    depth_bracket = 0  # for [attributes] inside the signature line
    end = -1
    in_str = None
    i = 0
    n = len(text)
    while i < n:
        ch = text[i]
        # Skip strings, since they may contain { ; etc.
        if in_str:
            if ch == "\\":
                i += 2
                continue
            if ch == in_str:
                in_str = None
            i += 1
            continue
        if ch in ("'", '"'):
            in_str = ch
            i += 1
            continue
        if ch == '/' and i + 1 < n and text[i + 1] == '/':
            # Line comment - skip to newline.
            nl = text.find('\n', i)
            i = n if nl < 0 else nl
            continue
        if ch == '/' and i + 1 < n and text[i + 1] == '*':
            # Block comment.
            close = text.find('*/', i + 2)
            i = n if close < 0 else close + 2
            continue
        if ch == '(':
            depth_paren += 1
        elif ch == ')':
            depth_paren -= 1
        elif ch == '<':
            depth_angle += 1
        elif ch == '>':
            depth_angle -= 1
        elif ch == '[':
            depth_bracket += 1
        elif ch == ']':
            depth_bracket -= 1
        elif ch in '{;' and depth_paren == 0 and depth_angle == 0 and depth_bracket == 0:
            end = i
            break
        elif ch == '=' and i + 1 < n and text[i + 1] == '>' and depth_paren == 0 and depth_angle == 0 and depth_bracket == 0:
            # Expression-bodied member: `=> expr;`. Treat the `=>` as
            # the terminator of the signature.
            end = i
            break
        i += 1
    if end < 0:
        return None
    sig = text[:end]
    sig = re.sub(r"\s+", " ", sig).strip()
    return sig if sig else None


def looks_like_function(sig: str) -> bool:
    """Return True if sig looks like a method / constructor / delegate."""
    paren = sig.find('(')
    if paren < 0:
        return False
    head = sig[:paren]
    # Field initializers like `public Foo bar = something(` would have '='
    # in the head before '('.
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
    """Extract the method/constructor/delegate name from a signature."""
    head = sig.split('(', 1)[0].rstrip()
    m = re.search(r"(\w+)\s*$", head)
    return m.group(1) if m else "?"


def is_publicly_accessible(sig: str, owner_kind: str) -> bool:
    """Decide whether a signature is part of the public API.
    For class/struct/enum: must contain `public`.
    For interfaces: must NOT contain `private`/`protected`/`internal`."""
    head = sig.split('(', 1)[0]
    tokens = set(re.findall(r"\b\w+\b", head))
    if owner_kind == "interface":
        return not (tokens & {"private", "protected", "internal"})
    return "public" in tokens


# Matches public type declarations. Modifiers like `unsafe`, `abstract`,
# `sealed`, `static`, `partial` may appear in any order around `public`.
TYPE_DECL_RE = re.compile(
    r"\b(?:public|unsafe|abstract|sealed|static|partial)"
    r"(?:\s+(?:public|unsafe|abstract|sealed|static|partial))*"
    r"\s+(?P<kind>class|struct|interface|enum)\s+(?P<name>\w+)"
)


def find_top_type(content: str) -> tuple[str, str] | None:
    """Find the first public top-level type in the file. Returns
    (kind, name) or None."""
    for m in TYPE_DECL_RE.finditer(content):
        # Make sure 'public' is one of the modifiers (interface members
        # default to public, but the type itself must be public).
        decl_start = m.start()
        # Find the start of the declaration line.
        line_start = content.rfind('\n', 0, decl_start) + 1
        line = content[line_start:m.end()]
        if 'public' in re.findall(r"\b\w+\b", line):
            return m.group("kind"), m.group("name")
    return None


NAMESPACE_RE = re.compile(r"^\s*namespace\s+([\w.]+)", re.MULTILINE)


def find_namespace(content: str) -> str:
    """Return the (first) namespace declared in the file, or empty string."""
    m = NAMESPACE_RE.search(content)
    return m.group(1) if m else ""


def skip_to_decl(content: str, start: int) -> int | None:
    """From `start` (just past the last `///` line), walk forward
    skipping whitespace, line comments (//), block comments,
    preprocessor directives (#if etc.), and C# attributes ([...]).
    Return the position of the first character of the actual
    declaration, or None if we hit another doc-comment block first."""
    pos = start
    n = len(content)
    while pos < n:
        # Skip whitespace.
        while pos < n and content[pos].isspace():
            pos += 1
        if pos >= n:
            return None
        # Another /// doc comment means our previous block didn't
        # actually attach to a declaration.
        if content.startswith("///", pos):
            return None
        # Skip non-doc line comments.
        if content.startswith("//", pos):
            nl = content.find("\n", pos)
            if nl < 0:
                return None
            pos = nl + 1
            continue
        # Skip block comments.
        if content.startswith("/*", pos):
            close = content.find("*/", pos + 2)
            if close < 0:
                return None
            pos = close + 2
            continue
        # Skip preprocessor directives (#if, #endif, #pragma, ...).
        if content[pos] == '#':
            nl = content.find("\n", pos)
            if nl < 0:
                return None
            pos = nl + 1
            continue
        # Skip attribute blocks: [Foo], [Foo(...)], possibly multiple.
        if content[pos] == '[':
            depth = 0
            in_str = None
            while pos < n:
                ch = content[pos]
                if in_str:
                    if ch == '\\':
                        pos += 2
                        continue
                    if ch == in_str:
                        in_str = None
                    pos += 1
                    continue
                if ch in ('"', "'"):
                    in_str = ch
                    pos += 1
                    continue
                if ch == '[':
                    depth += 1
                elif ch == ']':
                    depth -= 1
                    if depth == 0:
                        pos += 1
                        break
                pos += 1
            continue
        return pos
    return None


def find_doc_blocks(content: str):
    """Yield (block_start_line_idx, block_end_offset) tuples for each
    contiguous run of /// doc-comment lines."""
    lines = content.splitlines(keepends=True)
    # Track byte offsets for each line.
    offsets = [0]
    for ln in lines:
        offsets.append(offsets[-1] + len(ln))

    i = 0
    while i < len(lines):
        if DOC_LINE_RE.match(lines[i]):
            start = i
            while i < len(lines) and DOC_LINE_RE.match(lines[i]):
                i += 1
            yield (start, i, offsets[i])
        else:
            i += 1


def extract_api(filepath: Path):
    try:
        content = filepath.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        content = filepath.read_text(encoding="latin-1")

    top = find_top_type(content)
    if top is None:
        return []
    top_kind, top_name = top
    namespace = find_namespace(content)

    # Map every byte offset to the innermost enclosing type name. This
    # lets nested types be detected so we can skip their members.
    enclosing = compute_enclosing_types(content)

    lines = content.splitlines(keepends=True)
    line_offsets = [0]
    for ln in lines:
        line_offsets.append(line_offsets[-1] + len(ln))

    entries = []
    seen_offsets = set()

    for block_start, block_end, end_offset in find_doc_blocks(content):
        decl_start = skip_to_decl(content, end_offset)
        if decl_start is None:
            continue
        if decl_start in seen_offsets:
            continue
        seen_offsets.add(decl_start)
        sig = collapse_signature(content[decl_start:])
        if not sig:
            continue
        if not looks_like_function(sig):
            continue

        # Decide which "owner type" this declaration belongs to. If the
        # innermost enclosing type is the file's top-level type, attribute
        # to it. Namespace-scope delegates have no enclosing type — they
        # become their own top-level entry.
        encl = enclosing.get(decl_start)
        head_tokens = sig.split('(', 1)[0].split()
        is_namespace_delegate = (encl is None and "delegate" in head_tokens)
        if is_namespace_delegate:
            owner = signature_method_name(sig)
            owner_kind = "delegate"
        elif encl == top_name:
            owner = top_name
            owner_kind = top_kind
        else:
            # Either no enclosing type (and not a delegate) or nested in
            # a non-top-level type. Skip — we only document the public
            # top-level type's members and namespace-scope delegates.
            continue

        if not is_publicly_accessible(sig, owner_kind):
            continue

        doc = clean_doc(lines[block_start:block_end])
        entries.append({
            "class": owner,
            "kind": owner_kind,
            "namespace": namespace,
            "method": signature_method_name(sig),
            "signature": sig,
            "doc": doc,
        })
    return entries


def compute_enclosing_types(content: str) -> dict[int, str]:
    """For each byte offset, record the name of the innermost enclosing
    type (class/struct/interface/enum). Offsets outside any type get no
    entry. Implementation: scan with the same brace-aware loop, and on
    each '{' check whether the immediately preceding (whitespace/comment-
    stripped) text contains a type declaration; if so, push a new
    enclosing type."""
    n = len(content)
    result = {}
    depth = 0
    type_stack: list[tuple[int, str | None]] = []  # (depth, name) or None for non-type
    i = 0
    in_str = None
    in_char = False
    in_line_comment = False
    in_block_comment = False
    in_verbatim = False

    # Also record kinds.
    # Public bookkeeping returned via closure; but we only need names
    # at this stage; for kind, callers fall back to "class".

    # Helper: for a '{' at position i, look backward to figure out if it
    # opens a type body. We scan back over whitespace, then check the
    # last identifier-or-clause.
    def lookbehind_type_decl(brace_pos: int) -> str | None:
        # Walk back from just before brace_pos, skipping whitespace,
        # comments, attributes, and base-clause `: Foo, Bar`.
        j = brace_pos - 1
        # Skip whitespace and comments.
        while j >= 0:
            c = content[j]
            if c.isspace():
                j -= 1
                continue
            # End of block comment?
            if c == '/' and j - 1 >= 0 and content[j - 1] == '*':
                # find matching /*.
                op = content.rfind('/*', 0, j - 1)
                if op < 0:
                    return None
                j = op - 1
                continue
            # End of line comment? Hard to detect backwards; punt.
            break
        if j < 0:
            return None
        # Pull back the last "line-ish" segment. We'll collect up to the
        # previous `;` or `}` or `{` (excluding) — that bounds the
        # declaration head.
        start = j
        depth_paren = 0
        depth_angle = 0
        while start >= 0:
            c = content[start]
            if c == ')':
                depth_paren += 1
            elif c == '(':
                depth_paren -= 1
            elif c == '>':
                depth_angle += 1
            elif c == '<':
                depth_angle -= 1
            elif depth_paren == 0 and depth_angle == 0 and c in ';{}':
                start += 1
                break
            start -= 1
        if start < 0:
            start = 0
        head = content[start:brace_pos]
        # Strip line comments and block comments inside head.
        head = re.sub(r"//[^\n]*", "", head)
        head = re.sub(r"/\*.*?\*/", "", head, flags=re.DOTALL)
        m = TYPE_DECL_RE.search(head)
        if m:
            return m.group("name")
        # Could also be implicitly-public interface/etc. Catch
        # `interface X` / `class X` / `struct X` without `public`.
        m = re.search(r"\b(class|struct|interface|enum)\s+(\w+)", head)
        if m:
            return m.group(2)
        return None

    while i < n:
        # Record innermost type for this offset.
        innermost = None
        for d, name in reversed(type_stack):
            if name is not None:
                innermost = name
                break
        if innermost is not None:
            result[i] = innermost

        ch = content[i]
        if in_line_comment:
            if ch == '\n':
                in_line_comment = False
            i += 1
            continue
        if in_block_comment:
            if ch == '*' and i + 1 < n and content[i + 1] == '/':
                in_block_comment = False
                i += 2
                continue
            i += 1
            continue
        if in_str is not None:
            if in_verbatim:
                if ch == '"':
                    if i + 1 < n and content[i + 1] == '"':
                        i += 2
                        continue
                    in_str = None
                    in_verbatim = False
                    i += 1
                    continue
                i += 1
                continue
            if ch == '\\':
                i += 2
                continue
            if ch == in_str:
                in_str = None
                i += 1
                continue
            i += 1
            continue
        if in_char:
            if ch == '\\':
                i += 2
                continue
            if ch == "'":
                in_char = False
            i += 1
            continue
        if ch == '/' and i + 1 < n and content[i + 1] == '/':
            in_line_comment = True
            i += 2
            continue
        if ch == '/' and i + 1 < n and content[i + 1] == '*':
            in_block_comment = True
            i += 2
            continue
        if ch == '"':
            in_str = '"'
            i += 1
            continue
        if ch == '@' and i + 1 < n and content[i + 1] == '"':
            in_str = '"'
            in_verbatim = True
            i += 2
            continue
        if ch == "'":
            in_char = True
            i += 1
            continue
        if ch == '{':
            tname = lookbehind_type_decl(i)
            depth += 1
            type_stack.append((depth, tname))
            i += 1
            continue
        if ch == '}':
            if type_stack and type_stack[-1][0] == depth:
                type_stack.pop()
            depth -= 1
            i += 1
            continue
        i += 1
    return result


def render_markdown(by_class: dict[str, list[dict]]) -> str:
    out = []
    out.append("# .NET API Reference")
    out.append("")
    out.append("Auto-generated from XML-doc-commented public API in the "
               "`com.latencybusters.lbm` namespace (lbmcs/ source).")
    out.append("")
    out.append("## Contents")
    out.append("")
    for cls in sorted(by_class):
        anchor = cls.lower()
        out.append(f"- [{cls}](#{anchor})")
    out.append("")

    for cls in sorted(by_class):
        entries = by_class[cls]
        kind = entries[0]["kind"]
        ns = entries[0].get("namespace") or "com.latencybusters.lbm"
        out.append(f"## {cls}")
        out.append("")
        out.append(f"*{kind}* `{ns}.{cls}`")
        out.append("")
        seen = set()
        for e in entries:
            if e["signature"] in seen:
                continue
            seen.add(e["signature"])
            out.append(f"### {e['method']}")
            out.append("")
            out.append("```csharp")
            out.append(e["signature"])
            out.append("```")
            out.append("")
            if e["doc"]:
                out.append(e["doc"])
                out.append("")
    return "\n".join(out).rstrip() + "\n"


def main(argv=None):
    here = Path(__file__).resolve().parent
    _lbm_repo = os.environ.get('LBM_REPO')
    if not _lbm_repo:
        sys.exit("error: LBM_REPO environment variable is not set")
    default_root = Path(_lbm_repo) / "src" / "dotnet" / "lbmcs"
    default_out = here / "dotnet_api.md"

    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", type=Path, default=default_root,
                    help=f"Directory to scan recursively for .cs files "
                         f"(default: {default_root})")
    ap.add_argument("--out", type=Path, default=default_out,
                    help=f"Output markdown file (default: {default_out})")
    args = ap.parse_args(argv)

    if not args.root.is_dir():
        print(f"error: --root not a directory: {args.root}", file=sys.stderr)
        return 2

    cs_files = []
    for f in sorted(args.root.rglob("*.cs")):
        # Exclude SDM subdirectory.
        rel = f.relative_to(args.root)
        if any(part == "sdm" for part in rel.parts):
            continue
        cs_files.append(f)
    if not cs_files:
        print(f"warning: no .cs files under {args.root}", file=sys.stderr)

    by_class: dict[str, list[dict]] = {}
    total = 0
    for cf in cs_files:
        for entry in extract_api(cf):
            by_class.setdefault(entry["class"], []).append(entry)
            total += 1

    md = render_markdown(by_class)
    args.out.write_text(md, encoding="utf-8")
    print(f"Scanned {len(cs_files)} files; "
          f"emitted {total} API entries across {len(by_class)} classes -> "
          f"{args.out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
