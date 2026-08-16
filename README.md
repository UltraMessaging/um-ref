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
Please install the um-ref skill from this repo.
```

Claude will copy the `um-ref/` subdirectory into `~/.claude/skills/um-ref/`,
including the `VERSION` file that future updates and merges rely on.

### The um-ref-merge companion skill

Updating your installed skill safely, and contributing changes back, both
go through a 3-way merge. That logic lives in a separate skill,
[`um-ref-merge`](https://github.com/UltraMessaging/um-ref-merge).
Install it once:

```
cd $HOME/.claude/skills
git clone https://github.com/UltraMessaging/um-ref-merge
```

If you never plan to update or contribute, you can skip this. Most users
should install it.

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

To pick up newer skill content while preserving any local edits, `git pull`
this repo and ask Claude:

```
Please update my um-ref skill from this repo.
```

Claude uses the `um-ref-merge` skill to perform a 3-way merge, protecting
customizations you (or Claude on your behalf) made to your active skill.

## Customize

You are encouraged to have Claude enhance your local skill as you use it:

```
Do you have knowledge that should be added to the /um-ref skill? Any new deep dive files?
```

Claude edits `~/.claude/skills/um-ref/` in place. Those edits are yours until
you either overwrite them (via an update) or contribute them back.

## Contribute

Pull requests are welcome. When you have local edits you'd like to
contribute:

```
Please merge my um-ref skill changes back to this repo.
```

Claude uses the `um-ref-merge` skill to produce a 3-way merge on a branch
in your clone, ready for you to open a pull request via the GitHub web UI
or `gh pr create`.

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
be hand-edited; the merge tooling always takes the upstream copy.

## Versioning

The `um-ref/VERSION` file records which skill release the installed
content corresponds to. This is the anchor `um-ref-merge` uses to identify
BASE for 3-way merges. Do not edit it by hand.

This skill was developed with UM version 6.17.1. It should be useful for
older versions but might sometimes think a feature is available that
isn't present in your version. In my experience this rarely causes a
problem. If you see it happening frequently, you can ask Claude to
examine the release notes doc for your version and update the skill
accordingly.
