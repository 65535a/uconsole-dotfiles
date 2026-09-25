#!/bin/sh
# Usage: top.sh cpu|mem  -> JSON [{"name": ..., "val": ...}] of the top 5 processes.
field=p${1:-cpu}
ps -eo "comm,$field" --sort="-$field" --no-headers \
  | grep -v -E '^(ps|top\.sh|jq|sh) ' \
  | head -n 10 \
  | jq -R -s -c 'split("\n") | map(select(length > 0) | capture("^(?<name>.+?)\\s+(?<val>[0-9.]+)\\s*$"))'
