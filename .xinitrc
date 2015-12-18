#!/bin/sh

# Start pulseaudio and load module-loopback
(pulseaudio -D && pactl load-module module-loopback) &

# Set a nice background.
# xsetroot -solid grey20
nitrogen --restore

# Load resources.
xrdb -load ~/.Xresources

# Fix Mouse cursor
xsetroot -cursor_name left_ptr &

# Shiny stuff
#compton -b

# URxvt Daemon
urxvtd &
#######
# DWM #
#######
# status bar
while true; do
  xsetroot -name "NP: `mpc_np` | `uname -r` | `uptime | sed 's/.*average: //'` | `memusage` | Batt: `acpi | awk '{print $4}' | sed 's/,//g'` |`date "+%A %b %d %Y %R"`"
  sleep 1
done &

# Mouse accel off
xset m 0 0

# Start KVM Server (synergy)
synergys -d ERROR -c $HOME/.quicksynergy/synergy.conf &
# relaunch DWM if the binary changes, otherwise bail
csum=$(sha1sum $(which dwm))
new_csum=""
while true
do
    if [ "$csum" != "$new_csum" ]
    then
        csum=$new_csum
        dwm
    else
        exit 0
    fi
    new_csum=$(sha1sum $(which dwm))
    sleep 0.5
done


########
# 2BWM #
########
# Start window manager in the background. If it dies, X still lives.
#2bwm &

# Panel
#2bwm_panel | lemonbar -p -F "#FFB5B2AF" -B "#FF282522" -g "1920x20+0+0" -f "Tewi-9" &
#sh $HOME/.config/2bwm/2bwm_panel3 &

# Start KVM Server (synergy)
#synergys -c $HOME/.quicksynergy/synergy.conf &

# Start a terminal in the foreground. If this dies, X dies.
#exec xterm
#exec urxvt
