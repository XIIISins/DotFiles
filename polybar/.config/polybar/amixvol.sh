#!/usr/local/bin/bash
#
sink=Master
curvol=$(amixer get $sink | egrep -o "[0-9]+%" |tr -d % | uniq)

volUp() {
  if [ $curvol -lt 100 ]; then
    amixer -q sset $sink 5%+
  else
    amixer -q sset $sink 100%
  fi
}
volDown() {
  if [ $curvol -gt 0 ]; then
    amixer -q sset $sink 5%-
  else
    amixer -q sset $sink 0%
  fi
}

case $1 in
  --up)
    volUp
    ;;
  --down)
    volDown
    ;;
  --current|*)
    printf "%s" $curvol
    ;;

esac
