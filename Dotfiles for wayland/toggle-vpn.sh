#!/bin/bash

if [ "$1" == "refresh" ]; then
  if test -f /sys/class/net/kvnet/operstate; then
    echo '{"class": "on"}'
  else
    echo '{"class": "off"}'
  fi
  pkill -SIGRTMIN+3 waybar
  exit
fi

if test -f /sys/class/net/kvnet/operstate; then
  sudo kvpnc stop 
  echo '{"class": "off"}'
else
  sudo kvpnc start
  echo '{"class": "on"}'
fi
pkill -SIGRTMIN+3 waybar
