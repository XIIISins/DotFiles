#!/bin/bash
SUSPENDSYS=0
PLAYER=mpc

pctl() {
if [ "$(playerctl status)" = "$PCTLSTAT"  ] ; then
  playerctl play-pause
fi
}

mpctl() {
if [ $(mpc | awk '/\[*\]/ { print $1 }' | sed 's/^\[\(.*\)\]$/\1/') = "$MPCSTAT" ]; then
  mpc toggle
fi
}

MusicStat() {
case $1 in
  stop)
    PCTLSTAT="Playing"
    MPCSTAT="playing"
    ;;
  start)
    PCTLSTAT="Stopped"
    MPCSTAT="paused"
    ;;
esac

if [ $PLAYER = "mpc" ]; then
  mpctl
else
  pctl
fi
}

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png
MusicStat stop
i3lock -e -f -i /tmp/screen.png -n
if [ $SUSPENDSYS -gt '0' ]; then
  systemctl suspend
fi
MusicStat start
rm /tmp/screen.png

