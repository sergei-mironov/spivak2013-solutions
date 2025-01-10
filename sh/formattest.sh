#!/bin/sh

L=_formattest.log

{
date
echo "$@"
echo '====='
cat
echo '====='
}>$L

cat <<EOF
multi
line
output
EOF
