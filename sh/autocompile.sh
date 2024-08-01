#!/bin/sh

DELAY="$1"
if test -z "$DELAY" ; then
  DELAY=3
fi

while true; do
  make >_make.log 2>&1 && echo -n . || echo -n F
  sleep $DELAY
done

