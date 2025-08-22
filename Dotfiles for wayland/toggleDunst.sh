#!/bin/bash

if [ "$1" != "refresh" ]; then
  dunstctl set-paused toggle
fi

status=`dunstctl is-paused`


if [ "$status" = "false" ]; then
  tooltip=`dunstctl count | tr '\n' ' '`
  echo '{"text":"   ","tooltip":"Notifications: '$tooltip'","class":"on"}' | jq --compact-output
else
  unread=`dunstctl count waiting`
  echo '{"text":"<small> '$unread'</small>","tooltip":"Notifications paused, '$unread' new","class":"paused"}' | jq --compact-output
fi


if [ "$1" != "refresh" ]; then
  pkill -SIGRTMIN+9 waybar
fi
