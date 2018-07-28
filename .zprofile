#
# ~/.zprofile
#
alias vv=vim
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
