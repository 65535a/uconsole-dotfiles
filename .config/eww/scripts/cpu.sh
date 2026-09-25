#!/bin/sh
# CPU usage in % since the previous call, from /proc/stat.
STATE=/tmp/eww-cpu.state
read -r _ u n s i w irq sirq st _ < /proc/stat
total=$((u + n + s + i + w + irq + sirq + st))
idle=$((i + w))
if [ -f "$STATE" ]; then read -r pt pi < "$STATE"; else pt=0; pi=0; fi
echo "$total $idle" > "$STATE"
dt=$((total - pt)); di=$((idle - pi))
if [ "$dt" -gt 0 ]; then echo $(( 100 * (dt - di) / dt )); else echo 0; fi
