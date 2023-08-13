#!/bin/bash

domain="win10"
waiting=true

while $waiting; do
    status=$(virsh --connect qemu:///system list --all | grep $domain | awk '{print $3}')
    
    case $status in
        running)
            waiting=false

            looking-glass-client -C ~/.config/looking-glass/client.ini
            sleep 1

            wmctrl -r "Looking Glass (client)" -b add,below
            wmctrl -r "Looking Glass (client)" -b add,skip_taskbar
            ;;
        paused)
            virsh --connect qemu:///system resume $domain
            ;;
        shut)
            virsh --connect qemu:///system start $domain
            ;;
        *)
            echo "Unhandled state: $status"
            ;;
    esac

    echo -n "."
    sleep 1
done
