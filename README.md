# um-ref

um-ref is a Claude Code skill that teaches Claude about the Ultra Messaging product.

It is primarily focused on customer-facing knowledge, not internals,
but there are some internals information that can be helpful to users
and is therefore being made open.

## Prerequisites

- Claude Code installed (`~/.claude` exists).
- `git` on your PATH.
- A Unix-like environment (Linux, macOS, WSL).

## Install

Clone this repo somewhere convenient:

```
git clone https://github.com/UltraMessaging/um-ref
```

Then, in that directory, launch Claude Code and ask:

```
Please install the skill in this repo.
```

Claude will copy the `um-ref/` subdirectory into `~/.claude/skills/um-ref/`.
Keep the clone: it's how you update the skill and contribute changes.

## Environment variables

### Customers

Download the document zip file for your UM version from
https://ultramessaging.github.io/um_doc.html and expand it locally.

Set:

- `LBM_INC` — the `include/lbm` directory of your UM installation.
  Example: `$HOME/UMP_6.17.1.1/Linux-glibc-2.17-x86_64/include/lbm`
- `LBM_DOC` — the `doc` directory of the document tree you downloaded above.

Add these to your `.bashrc` (or equivalent). Verify with:

```
Do you have access to the /um-ref skill and the associated include and doc files?
```

### Internal Informatica

Set `LBM_REPO` to point at the `lbm` directory of a UM source tree.
Example:

```
export LBM_REPO=$HOME/Perforce/sfordsf_REL_6_17_1/29West/lbm
```

Add to `.bashrc`. Verify with:

```
Do you have access to the /um-ref skill and the associated source files?
```

## Update

To pick up newer skill content while preserving any local edits, ask
Claude, in your clone:

```
Please update my um-ref skill from this repo.
```

Claude first saves your local edits to the clone as a commit, then
runs `git pull`, so git merges upstream changes with yours. Then it
copies the result to your active skill. If you run `git pull`
yourself, have Claude save your edits first: the active skill is
outside git, so pulling and then copying the repo over it loses them.

## Customize

You are encouraged to have Claude enhance your local skill as you use it:

```
Do you have knowledge that should be added to the /um-ref skill? Any new deep dive files?
```

Claude edits `~/.claude/skills/um-ref/` in place. Updates merge with
those edits rather than overwrite them.

## Contribute

Pull requests are welcome. When you have local edits you'd like to
contribute:

```
Please save my um-ref skill changes to this repo.
```

Claude copies your active skill into the clone, checks the diff for
personal details that don't belong in a public repo, and commits.
Push to your fork and open a pull request via the GitHub web UI or
`gh pr create`.

## Normal Usage

I often start a session with:

```
Using the /um-ref skill, please blah blah blah...
```

Claude should also invoke the skill automatically when it detects UM-related
keywords in your prompt (e.g. `lbm`, `transport_lbtrm_*`, `umestored`, `DRO`).

## Structure

The total amount of UM knowledge is large enough that it is a waste of
context (and tokens) for Claude to read all of it every time. The
`SKILL.md` file has a high-level tutorial on UM; additional files are
deeper dives into specific areas that `SKILL.md` directs Claude to
consult as needed.

For some lookups, Claude goes straight into your source tree or headers
directory (referenced by `LBM_REPO` or `LBM_INC`). For example, that's
where it accesses `lbm.h` for the C API. This ensures Claude sees the
right version.

A handful of files are generated from UM source by Python tools
(`gen_java_api.py`, `gen_dotnet_api.py`) and refreshed periodically via
`build.sh`. Those files — `java_api.md`, `dotnet_api.md`, plus the
bundled `config-data.xml`, `index-ume.m4`, and `index-dro.m4` — must not
be hand-edited; when merging, always take the upstream copy.

## Versioning

This skill was developed with UM version 6.17.1. It should be useful for
older versions but might sometimes think a feature is available that
isn't present in your version. In my experience this rarely causes a
problem. If you see it happening frequently, you can ask Claude to
examine the release notes doc for your version and update the skill
accordingly.
