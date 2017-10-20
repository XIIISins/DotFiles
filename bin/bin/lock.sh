#!/usr/local/bin/bash
# Locking your PC made easy with potatoes!
# set -x

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

# Screenshot and convert
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
[[ -f $1 ]] && convert /tmp/screen.png $1 -gravity center -composite -matte /tmp/screen.png

# Stop music
MusicStat stop
mute.sh

# Lock desktop
if [ -e $(which i3lock) ]; then
  i3lock -e -f -i /tmp/screen.png -n
else
  echo "Please install i3lock" >> /tmp/lock.log
fi

# if SUSPENDSYS is not 0 then suspend the system (hibernate/sleep)
if [ $SUSPENDSYS -gt '0' ]; then
  systemctl suspend
fi

# If we reach this, we have been unlocked and we can start music and cleanup!
MusicStat start
mute.sh
rm /tmp/screen.png

