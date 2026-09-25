#!/bin/sh
# Toggle the eww stats widgets on and off.
# Bound in sway to $mod+Ctrl+w.

WINDOWS="stats-widget procs-widget"

if eww active-windows 2>/dev/null | grep -q 'stats-widget'; then
  eww close $WINDOWS
else
  # Start the daemon if it isn't running yet
  eww ping >/dev/null 2>&1 || { eww daemon; sleep 1; }
  eww open-many $WINDOWS
fi
