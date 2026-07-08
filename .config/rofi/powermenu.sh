#!/bin/bash

chosen=$(echo -e "⏻ Shutdown\n Reboot\n Suspend\n Lock" | rofi -dmenu -p "Power")

case "$chosen" in
    "⏻ Shutdown") systemctl poweroff ;;
    " Reboot")    systemctl reboot ;;
    " Suspend")   systemctl suspend ;;
    " Lock")      i3lock ;;
esac
