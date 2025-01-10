#!/bin/sh

DELAY="$1"
if test -z "$DELAY" ; then
  DELAY=3
fi

# https://stackoverflow.com/a/77819553
mln() { echo -en ""$'\033['${1}D${2}"" ; }


while true; do
  echo -n '?'
  while ! make >>_make.log 2>&1 ; do
    mln
    echo -ne "F\a"
    sleep "$DELAY"
    echo -n '?'
  done
  mln
  echo -n .
  sleep "$DELAY"
  inotifywait \
    --exclude '_.*' \
    -r -e modify,move,create,delete \
    tex/ sh/ \
    >_make.log 2>&1
done
