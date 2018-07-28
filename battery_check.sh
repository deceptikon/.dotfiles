#!/bin/bash

BATTINFO="$(/usr/bin/acpi -b)"
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | cut -f 5 -d " "` < 00:20:00 ]] ; then
    DISPLAY=:0.0 /usr/bin/notify-send --icon=battery-low "BATTERY LOW" "$BATTINFO"
fi
