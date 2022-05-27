#!/usr/bin/env bash

question=$(echo "  Lock|  Logout|  Reboot|  Shutdown" | rofi -sep "|" \
    -dmenu -i -p 'System: ' "" -width 20 -hide-scrollbar \
    -eh 1 -line-padding 4 -padding 20 -lines 4 -color-enabled)

case $question in
    *Lock)
        i3lock -c 000000
        ;;
    *Logout)
        i3-msg exit
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
    *)
        exit 0  # do nothing on wrong response
        ;;
esac
