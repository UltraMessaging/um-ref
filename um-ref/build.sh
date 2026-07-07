#!/usr/bin/env bash
# Refresh generated / bundled reference files for the um-ref skill.
#
# Run this manually after the upstream sources change. It:
#   1. Regenerates java_api.md and dotnet_api.md from
#      $LBM_REPO/src/{java,dotnet}/.
#   2. Copies config-data.xml (Config Guide XML) and the UME / Gateway
#      index.m4 files into the skill directory as the bundled fallback
#      that lbmopt.py / xmlopt.py use when no repo is available.
#
# All outputs are checked in so a fresh clone of this skill is
# immediately usable without running the build first.
#
# Skill *development* is inherently internal-mode — LBM_REPO must be
# set. The skill's *use* does not require it (that's what the bundled
# copies are for).
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$here"

# LBM_REPO must point at the UM source tree; fail early with a clear
# message instead of failing later inside one of the generators.
if [[ -z "${LBM_REPO:-}" ]]; then
    echo "error: LBM_REPO environment variable is not set" >&2
    exit 1
fi

python3 gen_java_api.py
python3 gen_dotnet_api.py

# Refresh bundled config sources. Each src must exist; missing files
# indicate a workspace problem, not something to silently skip.
declare -a copies=(
    "$LBM_REPO/doc/Config/reference/config-data.xml:config-data.xml"
    "$LBM_REPO/doc/UME/index.m4:index-ume.m4"
    "$LBM_REPO/doc/Gateway/index.m4:index-dro.m4"
)
for pair in "${copies[@]}"; do
    src="${pair%%:*}"
    dst="${pair##*:}"
    if [[ ! -f "$src" ]]; then
        echo "error: expected source file not found: $src" >&2
        exit 1
    fi
    cp -f "$src" "$dst"
    echo "refreshed: $dst"
done
