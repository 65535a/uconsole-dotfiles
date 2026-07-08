#!/bin/bash

# Get current states
STATUS=$(aiov2_ctl --status)
get_state() { echo "$STATUS" | grep "^$1" | grep -o 'ON\|OFF'; }

GPS_STATE=$(get_state GPS)
LORA_STATE=$(get_state LORA)
SDR_STATE=$(get_state SDR)
USB_STATE=$(get_state USB)

# Build menu with state indicators
CHOICE=$(printf \
    "$([ "$GPS_STATE"  = "ON" ] && echo "✅" || echo "⬜") GPS\n\
$([ "$LORA_STATE" = "ON" ] && echo "✅" || echo "⬜") LoRa\n\
$([ "$SDR_STATE"  = "ON" ] && echo "✅" || echo "⬜") SDR\n\
$([ "$USB_STATE"  = "ON" ] && echo "✅" || echo "⬜") USB" \
    | rofi -dmenu -p "AIO v2 Radios")

# Toggle based on selection
case "$CHOICE" in
    *GPS*)  [ "$GPS_STATE"  = "ON" ] && aiov2_ctl GPS off  || aiov2_ctl GPS on  ;;
    *LoRa*) [ "$LORA_STATE" = "ON" ] && aiov2_ctl LORA off || aiov2_ctl LORA on ;;
    *SDR*)  [ "$SDR_STATE"  = "ON" ] && aiov2_ctl SDR off  || aiov2_ctl SDR on  ;;
    *USB*)  [ "$USB_STATE"  = "ON" ] && aiov2_ctl USB off  || aiov2_ctl USB on  ;;
esac
