# um-ref
um-ref is a Claude Code skill that teaches Claude about the Ultra Messaging product.

It is primarily focused on customer-facing knowledge, not internals,
but there are some internals information that can be helpful to users
and is therefore being made open.

## Quickstart

This assumes you already have Claude Code installed (i.e. `~/.claude` exists). It also assumes you're using Claude Code on Unix.

### Preparation

```
cd $HOME/.claude
mkdir skills      # May fail if the dir already exists.
cd skills
wget https://github.com/UltraMessaging/um-ref/raw/main/um-ref.tgz
tar xzf um-ref.tgz
rm um-ref.tgz
```

### Customers

Download the document zip file for your UM version from here: https://ultramessaging.github.io/um_doc.html
Expand it on your local file system where Claude will be able to access it.

Define the environment variables:
* LBM_INC - point at the "include/lbm" directory of your UM installation. For example: `$HOME/UMP_6.17.1.1/Linux-glibc-2.17-x86_64/include/lbm`
* LBM_DOC - point at the "doc" directory of the document tree you downloaded above.
You might want to add these to your .bashrc file (or equiv).

Finally, invoke Claude Code and issue the prompt:
```
Do you have access to the /um-ref skill and the associated include and doc files?
```
Let us know if it doesn't work.

### Internal Informatica

Define the environment variable "LBM_REPO" to point at the "lbm" directory of a UM source tree. For example:

```
export LBM_REPO=$HOME/Perforce/sfordsf_REL_6_17_1/29West/lbm
```
You might want to add this to your .bashrc file (or equiv).

Finally, invoke Claude Code and issue the prompt:
```
Do you have access to the /um-ref skill and the associated source files?
```

## Normal Usage

I often start out a session with the prompt:
```
Using the /um-ref skill, please blah blah blah...
```
However, Claude should automatically invoke the skill when it detects UM-related keywords in your prompt (e.g. `lbm`, `transport_lbtrm_*`, `umestored`, `DRO`, etc.).

## Structure

The total amount of UM knowledge is large enough that it is a waste of context (and tokens) for Claude to read all of it every time. So the "SKILL.md" file has a high-level tutorial on UM. There are additional files and tools that are deeper dives into specific areas. The SKILL.md directs Claude to use those deeper dives as needed.

For some lookups, Claude goes straight into your source tree or headers directory (referenced by `LBM_REPO` or `LBM_INC`). For example, that's where it accesses `lbm.h` for the C API. This ensures that Claude is looking at the right version of the file.

In other cases, there are files that are generated using python tools that read source files and output summaries. These summary files should be refreshed periodically by running "build.sh". For example, "dotnet_api.md" and "java_api.md".

## Customization

I frequently tell Claude to enhance the skill by adding knowledge it has gained while performing a task. I usually start with:
```
Do you have knowledge that should be added to the /um-ref skill? Any new deep dive files?
```
I usually follow Claude's advice.

We welcome pull requests from customers.

## Versioning

This skill was developed with UM version 6.17.1.
It should be useful for older versions but might sometimes think that a feature is available that isn't present in your version.
In my experience this rarely causes a problem. If you see it happening frequently, you can ask Claude to examine the release
notes doc for your version and update the skill accordingly.
