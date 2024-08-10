#!/bin/sh

DELAY="$1"
if test -z "$DELAY" ; then
  DELAY=1
fi

while true; do
  inotifywait \
    --exclude '_.*' \
    -r -e modify,move,create,delete \
    . >_make.log 2>&1
  while ! make >>_make.log 2>&1 ; do
    echo -n F
    sleep $DELAY
  done
  echo -n .
done

