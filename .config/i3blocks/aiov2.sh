#!/bin/bash
STATUS=$(sudo aiov2_ctl --status)
GPS=$(echo "$STATUS"  | grep -oiP 'GPS.*\K(ON|OFF)')
LORA=$(echo "$STATUS" | grep -oiP 'LORA.*\K(ON|OFF)')
SDR=$(echo "$STATUS"  | grep -oiP 'SDR.*\K(ON|OFF)')

parts=()
[ "$GPS"  = "ON" ] && parts+=("GPS")
[ "$LORA" = "ON" ] && parts+=("LRA")
[ "$SDR"  = "ON" ] && parts+=("SDR")

if [ ${#parts[@]} -gt 0 ]; then
    echo "󰤉 $(IFS=' '; echo "${parts[*]}")"
else
    echo "󰤉 off"
fi
