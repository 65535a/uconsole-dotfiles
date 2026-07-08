#!/bin/bash

INTERFACE=$(iwgetid -r 2>/dev/null)
SSID="$INTERFACE"

# Check if connected at all
if [ -z "$SSID" ]; then
    echo "󰤭 disconnected"
    exit 0
fi

# Get signal strength in dBm
SIGNAL=$(cat /proc/net/wireless | awk 'NR==3 {print int($4)}')

# Convert dBm to percentage roughly
PERCENT=$(( ( SIGNAL + 110 ) * 100 / 70 ))
# Clamp between 0-100
PERCENT=$(( PERCENT < 0 ? 0 : PERCENT > 100 ? 100 : PERCENT ))

# Pick glyph based on strength
if [ "$PERCENT" -ge 75 ]; then
    ICON="󰤨"  # excellent
elif [ "$PERCENT" -ge 50 ]; then
    ICON="󰤥"  # good
elif [ "$PERCENT" -ge 25 ]; then
    ICON="󰤢"  # weak
else
    ICON="󰤟"  # very weak
fi

echo "$ICON $SSID"
