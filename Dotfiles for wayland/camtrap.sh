#!/bin/bash
while true; do
  inotifywait -e open /dev/video0
  notify-send "📷 Камера активирована!" "$(ps -o comm= -p $(lsof -t /dev/video0))"
done

