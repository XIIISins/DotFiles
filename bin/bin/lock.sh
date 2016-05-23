#!/bin/bash
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
# Pause if playing
if [ -e $(which playerctl) ]; then
  if [ "$(playerctl status)" = "Playing"  ] ; then
    playerctl pause
  fi
elif [ -e $(which mpc) ]; then
  if [ $(mpc | awk '/\[*\]/ { print $1 }' | sed 's/^\[\(.*\)\]$/\1/') = "playing" ]; then
    mpc toggle
  fi
fi
i3lock -u -i /tmp/screen.png
if [ $SUSPENDSYS -gt '0' ]; then
  systemctl suspend
fi
rm /tmp/screen.png

