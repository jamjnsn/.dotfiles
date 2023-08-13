#!/bin/bash

if test $(wmctrl -l | grep "Looking Glass (client)" 2>&1 | wc -l) -eq 1; then 
    wmctrl -c "Looking Glass (client)"
else 
    . looking-glass-launcher.sh
fi