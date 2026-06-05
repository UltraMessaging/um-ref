#!/bin/sh
# get_skill.sh

(cd $HOME/.claude/skills; tar czf - um-ref) | cat >um-ref.tgz
