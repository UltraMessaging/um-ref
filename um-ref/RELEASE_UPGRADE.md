# Upgrading this skill to a new UM release

This is a checklist for the human (the skill maintainer) to run when
a new UM release ships. Claude can assist with the diffs and edits
inside each step, but the sequencing and judgment calls are
human-driven.

The skill's content falls into two categories:

- **Generated** — `java_api.md`, `dotnet_api.md`. Rebuilt by
  `build.sh` from upstream sources. Manual edits are pointless;
  they get overwritten.
- **Hand-curated** — `SKILL.md`, `config_details.md`, `dro_details.md`,
  `store_config.md`. Updated by reading upstream `.m4` and `.xml`
  diffs and selectively pulling in what changed.

The LBM_REPO environment variable points into the desired UM
source tree.

## Checklist

### 1. Set up the new release's workspace

- Sync the new release into a fresh Perforce workspace
  (`sfordsf_REL_6_NN_M`).
- Update the `LBM_REPO` environment variable to point at the new
  workspace. All scripts (`lbmopt.py`, `xmlopt.py`, `build.sh`,
  `gen_java_api.py`, `gen_dotnet_api.py`) read `$LBM_REPO` at
  runtime; no edits needed.
- If you use `~/.claude/skills/um-ref` as a symlink to whichever
  release you're "primarily" on, re-point it once you're done with
  the upgrade.

### 2. Bump the version banner

In `SKILL.md`, near the top:

```
**Version:** this skill describes **UM 6.NN.M**. ...
```

Update to the new version. Don't skip this — Claude reads it on
every load and uses it to flag mismatches.

### 3. Refresh generated and bundled reference files

```
./build.sh
```

This does two jobs from the new release:

- Regenerates `java_api.md` and `dotnet_api.md` from
  `$LBM_REPO/src/java/com/latencybusters/lbm/` and
  `$LBM_REPO/src/dotnet/lbmcs/`.
- Copies `config-data.xml`, `index-ume.m4`, and `index-dro.m4` from
  `$LBM_REPO/doc/` into the skill directory. These are the bundled
  fallbacks that `lbmopt.py` / `xmlopt.py` use when a user of the
  skill has no repo access.

The script fails with a clear message if `LBM_REPO` isn't set or a
source file is missing.

Spot-check the API-doc diff against the previous release's outputs —
large swings in entry counts (way up or way down) suggest the
generators hit a parsing snag. Modest swings are normal.

### 4. Diff `config-data.xml`

```
p4 diff2 -dub //...<old>/lbm/doc/Config/reference/config-data.xml \
              //...<new>/lbm/doc/Config/reference/config-data.xml
```

Skim for:

- **New `<option>` elements** — a new option means a new feature.
  Decide whether the feature is significant enough to mention in
  `SKILL.md` (rare) or `config_details.md` (sometimes).
- **Changed `<default-value>`** — defaults sometimes get tightened
  to fix bugs (the `ume_sri_request_maximum` situation in 6.17.1
  is the kind of thing that might get fixed in a later release).
  If a default change invalidates advice in `config_details.md`'s
  interrelated-options table (§11), update the table.
- **Removed/deprecated options** — flag in `config_details.md` if
  any current advice references them.

You don't have to read the whole diff. The `<option>` open/close
tags make it easy to grep `^[+-]\s*<option>` in the unified diff
output.

### 5. Diff each prose `index.m4`

```
p4 diff2 -dub //...<old>/lbm/doc/<area>/index.m4 \
              //...<new>/lbm/doc/<area>/index.m4
```

For `<area>` ∈ `{Design, UME, Gateway, Config, Operations}`.

Cheap signal first — get a section-level outline of changes:

```
diff <(grep -E '^\\m4_pg|^\\m4_s1' OLD/index.m4) \
     <(grep -E '^\\m4_pg|^\\m4_s1' NEW/index.m4)
```

This shows new/removed/renamed sections, which is usually all you
need. Read full prose only for sections that:

- Are net-new (`+\m4_pg new_anchor New Section Title`)
- Have substantive prose changes the skill currently summarizes
  — i.e., a section we already cover in `SKILL.md` or
  `config_details.md`. Use `grep -i 'keyword'` against the skill
  files to check coverage before deciding.
- Touch persistence pitfalls, threading, or transport reliability
  (skill is opinionated about these areas; new info is more likely
  to be load-bearing).

Skip:

- Marketing/intro changes.
- New man pages (those go in `doc/<area>/index.m4` but rarely
  affect application coding).
- Anything inside `\m4_pg grp*` sections (those are auto-generated
  per-option ref material, redundant with `config-data.xml`).

### 6. Update hand-curated files

For each item flagged in steps 4–5:

- **New API helper or callback** that affects an existing
  pattern → update the relevant section of `SKILL.md`.
- **New config option for an existing concern** → update
  `config_details.md`. Add to §11 if it joins an existing
  interrelated set; add a new section if it introduces a new
  concept.
- **Defaults shifted** → check `config_details.md` §11 and
  the "shipped defaults are too low" notes in `SKILL.md` §20
  ("Configuration"). If Informatica fixed something I called out
  as a workaround, *remove* the workaround note.
- **Deprecation/removal** → search both `SKILL.md` and
  `config_details.md` for the option/feature name and either
  remove the reference or annotate it.

When in doubt, write less. A skill that confidently says "X works
this way in 6.17.1" ages better than one that hedges every
sentence.

### 7. Smoke-test

Open a fresh Claude Code session in the new workspace and ask a
small question that touches the changed area. Verify Claude:

- Quotes the right new version in any version-conditional advice.
- Doesn't recommend removed/deprecated APIs.
- Pulls the right file (e.g., `config_details.md`, not `SKILL.md`)
  for config questions.

If something's off, that's usually a hint that a hand-curated file
needs another small edit.

### 8. Commit, tag, then stamp VERSION

The release lands in two commits: a content commit that carries the
actual release, plus a follow-up "stamp VERSION" commit that writes
`git describe --tags --long` output into `um-ref/VERSION`. The stamp
step is what lets a user read their installed `um-ref/VERSION` and
know exactly which commit they installed from — not just "which
tagged release" but "which specific commit on `main`."

**8a. Content commit + tag.**

```
git add um-ref/
git commit -m "release <SEMVER>"
git tag release-<SEMVER>
```

`<SEMVER>` picks the human-readable release name. Convention:

- Bump the **minor** (`1.0` → `1.1`) for content additions,
  clarifications, and generated-file refreshes — changes a 3-way
  merge should handle cleanly against a user's customized active
  skill.
- Bump the **major** (`1.x` → `2.0`) for changes likely to invalidate
  a user's local customizations: file renames, structural rewrites,
  or removals of content the user may have edited. A major bump is a
  signal to users to review their local edits carefully before
  updating.

**8b. Stamp VERSION with the describe string.**

```
git describe --tags --long > um-ref/VERSION
git add um-ref/VERSION
git commit -m "stamp VERSION"
git push origin main --tags
```

After 8b, `um-ref/VERSION` contains a string like
`release-1.1-0-g<hash>`. The hash points at 8a's commit — the tagged
release. Contributions between releases follow the same pattern (see
`um-ref-merge`'s Step 10-C): a content commit, then a stamp commit
that writes `release-<PREV>-<N>-g<hash>`.

The `um-ref-merge` skill does not parse VERSION programmatically —
it trusts whatever commit the user has checked out — so the stamp
is purely a human-facing marker of "which commit was I on at install
time." That's still enough to identify BASE unambiguously, since a
user with a VERSION file can read the `-g<hash>` suffix and check
out that commit directly.

The content commit (8a) includes the generated `java_api.md` and
`dotnet_api.md`, plus the bundled `config-data.xml`, `index-ume.m4`,
and `index-dro.m4` — a fresh clone should be usable in customer mode
without anyone having to set `LBM_REPO`.

## When this runbook is overkill

For point releases (6.17.1 → 6.17.2), most of this is unnecessary.
Run `build.sh`, diff `config-data.xml` for default changes, bump
the version banner, done. Skip the prose diffs unless you know a
guide changed substantively.

The full runbook is for major and minor release jumps (6.17 → 6.18,
6.x → 7.x).
