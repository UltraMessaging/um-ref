#!/bin/sh
# get_skill.sh

rm -rf um-ref
mkdir um-ref
cp $HOME/.claude/skills/um-ref/* um-ref/
tar czf um-ref.tgz um-ref

tar tzf um-ref.tgz
