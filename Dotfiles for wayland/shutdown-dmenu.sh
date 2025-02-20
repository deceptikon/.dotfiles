#!/bin/bash
#
# a simple logout dialog
#
###

kill_apps() {
  while read -r app; do
    wmctrl -i -c "$app"
  done < <(wmctrl -l | awk '{print $1}')
}

# choice_by_zenity() {
#   choice=$(zenity --title="PC Power" \
#                   --text="PC Power" \
#                   --list --radiolist \
#                   --hide-column=3 --print-column=3 \
#                   --column='' --column='' --column='' \
#                   TRUE Hibernate 0 FALSE Reboot 1 FALSE Shutdown 2)
# }

choice_by_zenity() {
  choice=$(zenity --info --title="Poweroff options" \
                  --text="PC Power:" \
                  --ok-label 'Cancel' \
                  --extra-button 'Suspend' \
                  --extra-button 'Hibernate' \
                  --extra-button 'Reboot' \
                  --extra-button 'Poweroff'
                )
}

choice_by_dmenu() {
  if [[ -f "$HOME/.dmenurc" ]]; then
    . "$HOME/.dmenurc"
  else
    DMENU='dmenu -i'
  fi

  choice=$(echo -e "0: Logout\n1: Shutdown\n2: Reboot" | $DMENU | cut -d ':' -f 1)
}

[[ -z "$DISPLAY" ]] && exit 1

choice_by_zenity
#choice_by_dmenu

[[ -z "$choice" ]] && exit 1

# gracefully close all open apps
###### kill_apps # wmctrl does not work in sway

# execute the choice in background

case "$choice" in
  "Hibernate") systemctl hibernate;;
  "Suspend") notify-send "Suspending..." && systemctl suspend;;
  "Reboot") sudo shutdown -r now & ;;
  "Poweroff") sudo shutdown -h now & ;;
esac
