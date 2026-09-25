# CLAUDE.md — working on this repo

This repo is the upstream source for the `um-ref` Claude Code skill.
Its `um-ref/` subdirectory mirrors what lives at
`~/.claude/skills/um-ref/` on an installed machine. Users install,
update, and contribute changes via the companion `um-ref-merge` skill;
see `README.md` for the user-facing workflow.

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
- Generated files must not be hand-edited — the `um-ref-merge` merge
  tooling always takes upstream for them. They are:
  `java_api.md`, `dotnet_api.md`, `config-data.xml`,
  `index-ume.m4`, `index-dro.m4`. Regenerate via `build.sh`.

## Syncing with a live install

Users often ask you to move edits between `~/.claude/skills/um-ref/`
and this repo's `um-ref/` subdir. Verify with `diff -rq` before and
after; keep updates additive when the user says so.
