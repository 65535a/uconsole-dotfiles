#!/bin/bash

CAPACITY=$(cat /sys/class/power_supply/axp20x-battery/capacity)
STATUS=$(cat /sys/class/power_supply/axp20x-battery/status)

if [ "$STATUS" = "Charging" ]; then
    ICON="󰂄"  # charging icon
elif [ "$CAPACITY" -ge 80 ]; then
    ICON="󰁹"  # full
elif [ "$CAPACITY" -ge 60 ]; then
    ICON="󰂀"  # high
elif [ "$CAPACITY" -ge 40 ]; then
    ICON="󰁾"  # medium
elif [ "$CAPACITY" -ge 20 ]; then
    ICON="󰁼"  # low
else
    ICON="󰁺"  # critical
fi

echo "$ICON $CAPACITY%"
