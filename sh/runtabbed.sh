#!/bin/sh

unset TMUX

tabbed -d >/tmp/tabbed.xid
zathura  -e $(</tmp/tabbed.xid)  tex/main.pdf &
sleep 0.3
st -w $(</tmp/tabbed.xid) &
sleep 0.3

