#!/bin/sh
# Usage: net.sh rx|tx  -> KB/s on the default-route interface since the previous call.
dir=${1:-rx}
iface=$(ip route show default 2>/dev/null | awk '{print $5; exit}')
[ -z "$iface" ] && { echo 0; exit 0; }
bytes=$(cat "/sys/class/net/$iface/statistics/${dir}_bytes" 2>/dev/null) || { echo 0; exit 0; }
now=$(date +%s%N)
STATE="/tmp/eww-net-$dir.state"
if [ -f "$STATE" ]; then read -r piface pbytes pnow < "$STATE"; fi
echo "$iface $bytes $now" > "$STATE"
if [ "$piface" != "$iface" ] || [ -z "$pbytes" ]; then echo 0; exit 0; fi
awk -v b="$bytes" -v pb="$pbytes" -v t="$now" -v pt="$pnow" \
    'BEGIN { dt = (t - pt) / 1e9; if (dt <= 0 || b < pb) print 0; else printf "%.0f\n", (b - pb) / 1024 / dt }'
