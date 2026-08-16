---
name: um-ref-setup
description: One-time setup checklist for the um-ref skill. Consulted when SKILL.md's environment check finds no UM source configured (no LBM_REPO/LBM_INC/LBM_DOC env var and, on Linux/WSL, no lbm_repo/lbm_inc/lbm_doc symlink).
---

# um-ref setup

This file is followed **only when** SKILL.md's environment check finds
no UM source configured. If any of `LBM_REPO`, `LBM_INC`, `LBM_DOC` is
set — or, on Linux/WSL, any of the `lbm_repo` / `lbm_inc` / `lbm_doc`
symlinks exists in the working directory — setup is already done; skip
this file.

The goal is to give the skill **one** of three independent UM sources
plus a working `python` command. Walk the user through the questions
below in order; don't ask for everything at once.

---

## Step 1 — Pick a UM source

Ask the user: **do you have the UM source tree available, or only the
customer distribution (headers + HTML docs)?**

- **Full source tree available** (internal engineer): `LBM_REPO` /
  `lbm_repo` — a checkout of the UM source. Contains `src/lib/lbm/lbm.h`,
  `doc/Config/reference/config-data.xml`, `doc/*/index.m4`, example
  apps, product source. This is the most capable source; prefer it if
  available.
- **Customer distribution**: `LBM_INC` / `lbm_inc` (public headers,
  `lbm.h` etc.) and/or `LBM_DOC` / `lbm_doc` (unzipped HTML docs from
  the customer portal). Either one alone is enough for many tasks;
  both together cover almost everything. `lbmopt.py` and `xmlopt.py`
  fall back to bundled config sources if neither is set, so per-option
  lookup works without any UM source at all.

Ask for the **path** to whichever they have. If they have more than
one, set all of them.

**Version check.** This skill is version-locked to UM **6.17.1** (see
the Version banner in SKILL.md). Once the user gives a path, verify
by reading the version string from one of:
- Source: `<repo>/src/lib/lbm/lbm.h` — grep for `LBM_VERS_*` macros.
- Headers: `<inc>/lbm.h` — same grep.
- Docs: `<doc>/index.html` (or similar) — the version usually appears
  in the header/title.

If the version differs, tell the user once — the skill will still work
for most tasks, but option defaults and behavior specifics may diverge.
The tools use the bundled 6.17.1 data unless they find a repo path.

---

## Step 2 — Choose env vars vs. symlinks (Linux/WSL only)

On **Windows (Git Bash)** this choice doesn't exist — always use env
vars. Native symlinks require admin/Developer Mode, and `ln -s` in Git
Bash silently makes a *copy*, not a link. Skip to Step 3.

On **Linux/WSL**, both work; the trade-off is:

- **Env vars (`.bashrc`)** — global; the skill sees the source from any
  working directory. **Downside:** every command that expands
  `$LBM_REPO/...` triggers a permission prompt in Claude Code.
- **Symlinks (per-project)** — created as `./lbm_repo`, `./lbm_inc`,
  `./lbm_doc` inside the project directory the user runs Claude from.
  No permission prompts. **Downside:** you have to create them again
  in each project directory. Also, if the user typically works in one
  place (e.g. always `~/proj/foo`), one set of symlinks is fine.

SKILL.md **prefers symlinks** on Linux/WSL for this reason. Recommend
symlinks if the user works out of a single project directory; recommend
env vars if they bounce between projects. Doing both is also fine —
symlinks win when present, env vars cover the rest.

### Setting env vars (Linux/WSL or Windows)

Add whichever of these apply to `~/.bashrc`:

```bash
export LBM_REPO=/absolute/path/to/um/source
export LBM_INC=/absolute/path/to/um/include
export LBM_DOC=/absolute/path/to/unzipped/html/docs
```

Then `source ~/.bashrc` (or open a new shell). Verify with
`printenv LBM_REPO LBM_INC LBM_DOC`.

### Setting symlinks (Linux/WSL only)

From the project directory the user runs Claude from:

```bash
ln -s /absolute/path/to/um/source     lbm_repo
ln -s /absolute/path/to/um/include    lbm_inc
ln -s /absolute/path/to/unzipped/docs lbm_doc
```

Verify with `ls -l lbm_repo lbm_inc lbm_doc`.

---

## Step 3 — Ensure `python` is Python 3

The skill's helper tools (`lbmopt.py`, `xmlopt.py`, and the `gen_*`
scripts) invoke `python`, not `python3`. This is deliberate — on
Windows/Git Bash, `python3` usually doesn't exist but `python` does
and is Python 3, so the tools work out of the box there.

Check: `python --version` — needs 3.6 or newer.

- **If missing on Linux/WSL** (some distros ship only `python3`):
  ```bash
  mkdir -p ~/.local/bin
  ln -s "$(command -v python3)" ~/.local/bin/python
  ```
  Then ensure `~/.local/bin` is on `PATH`. Check with
  `echo "$PATH" | tr ':' '\n' | grep -F ~/.local/bin`. If it's not
  there, add to `~/.bashrc`:
  ```bash
  export PATH="$HOME/.local/bin:$PATH"
  ```

- **If `python` exists but points at Python 2** (rare now): repoint the
  symlink at `python3` as above. Don't rely on the system `python`
  being Python 3.

---

## Step 4 — Confirm

Once the user has set up whichever of the three sources they have and
`python` resolves to Python 3, verify by re-running the environment
check from SKILL.md §0:

```bash
printenv LBM_REPO LBM_INC LBM_DOC
# Linux/WSL only, from the project directory:
ls -d lbm_repo lbm_inc lbm_doc 2>/dev/null
python --version
```

At least one of the three UM sources should print a path (env var) or
show as a symlink; `python` should print 3.x. Skill is now usable.

---

## Optional — only for skill maintainers

`build.sh` regenerates `java_api.md` and `dotnet_api.md` from upstream
sources and is bash-only. Regular users don't need to run it — the
generated files are checked into the skill. If the user is maintaining
this skill (not just using it), they need a real bash on `PATH`; Git
Bash on Windows is fine.
