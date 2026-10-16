# CLAUDE.md — working on this repo

This repo is the upstream source for the `um-ref` Claude Code skill.
Its `um-ref/` subdirectory mirrors what lives at
`~/.claude/skills/um-ref/` on an installed machine. Users install by
cloning this repo and copying `um-ref/` into `~/.claude/skills/`; see
`README.md` for the user-facing workflow.

## Workflow overrides for this repo

The user's global `~/.claude/CLAUDE.md` says not to modify git repos
without being asked. **For this repo, that rule is relaxed for routine
skill work:** committing edits and pushing to `main` is the expected
mode of contribution. You still confirm before destructive operations
(force-push, reset --hard, branch deletion, history rewrites).

Trunk-based development. No PR review. Push directly to `main`.
Commit messages are short, lowercase, imperative
(e.g. `retire VERSION file; clone commit anchors BASE`).

## Editing the skill content

- Files under `um-ref/` are skill instructions that other Claudes load
  when the skill triggers. Write for that audience.
- Do **not** invoke the `/um-ref` skill while working on this repo —
  the content here *is* that skill's source, and loading it during a
  authoring session risks conflating live-install state with the
  upstream copy.
- Generated files must not be hand-edited, and a merge always takes
  upstream's version of them. They are:
  `java_api.md`, `dotnet_api.md`, `config-data.xml`,
  `index-ume.m4`, `index-dro.m4`. Regenerate via `build.sh`.

## Live copy vs. this repo

The live skill, `~/.claude/skills/um-ref/`, is a copy of `um-ref/`,
not a link. Edits are tried out live first, then saved here. The live
copy is outside git, so git can't protect unsaved edits in it; the
order of the steps below matters. Diff before copying in either
direction: `diff -r ~/.claude/skills/um-ref um-ref`.

- **Save** (live to repo): copy the live files over `um-ref/`
  (`cp -a`, which keeps exec bits and mod times) and read the diff
  before committing. The repo is public, so check for personal
  context: user IDs, home paths, Perforce workspace names, scratch-file
  patterns, notes or todo files. Leave those in the live copy only.
  Commit.
- **Update** (pick up upstream): **save first**, then `git pull`. If
  the live edits aren't ready to share, commit them locally anyway
  and push later. Git then merges upstream with them. Pulling first
  and then deploying overwrites the unsaved live edits.
  - Resolve conflicts by intent. Never silently drop either side.
    If both sides changed the same fact, default, or example, ask the
    user which is right.
  - Generated files (above) always take upstream's version:
    `git checkout origin/main -- um-ref/<file>`.
- **Deploy** (repo to live): only after the diff shows live has
  nothing unsaved. Make live match `um-ref/`, including files upstream
  removed: `rsync -a --delete um-ref/ ~/.claude/skills/um-ref/`.
- **Push**: with write access, push to `main` (see above). Without it,
  push to a fork and open a pull request.
