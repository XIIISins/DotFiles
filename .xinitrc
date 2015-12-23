#!/bin/sh

# Start pulseaudio and load module-loopback
#(pulseaudio -D && pactl load-module module-loopback) &

#Display setup
ExtDisp=`xrandr | awk '/^DP1/ {print $2}'`

if [ $ExtDisp == "connected" ]; then
  xrandr --output eDP1 --off
  kbd_backlight 0
else 
  kbd_backlight 25
fi

# Load resources.
xrdb -load ~/.Xresources

# Fix Mouse cursor
xsetroot -cursor_name left_ptr &

# Shiny stuff
compton &

# URxvt Daemon
urxvtd &

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

#######
# DWM #
#######
# status bar
#while true; do
#  xsetroot -name "NP: `mpc_np` | `uname -r` | `uptime | sed 's/.*average: //'` | `memusage` | Batt: `acpi | awk '{print $4}' | sed 's/,//g'` |`date "+%A %b %d %Y %R"`"
#  sleep 1
#done &

# Mouse accel off
xset m 0 0

# Start KVM Server (synergy)
synergys -d ERROR -c $HOME/.quicksynergy/synergy.conf &

# Set a nice background.
#xsetroot -solid grey20
#nitrogen --restore

# relaunch DWM if the binary changes, otherwise bail
#csum=$(sha1sum $(which dwm))
#new_csum=""
#while true
#do
#    if [ "$csum" != "$new_csum" ]
#    then
#        csum=$new_csum
#        dwm
#    else
#        exit 0
#    fi
#    new_csum=$(sha1sum $(which dwm))
#    sleep 0.5
#done


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

# Set a nice background.
#xsetroot -solid grey20
#nitrogen --restore

# Start a terminal in the foreground. If this dies, X dies.
#exec xterm
#exec urxvt

################
# Herbstluftwm #
################


xset s off
xset -dpms
xset r rate 350 45
xset +fp /usr/share/fonts/TTF
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/artwiz-fonts
setxkbmap -option terminate:ctrl_alt_bksp

#Determine WP

setwp() {
TIME=`date +"%H%M"`
if [ $TIME -gt "1800" ]; then
  echo "HOME WP Loaded" > $HOME/log/wp.log
  nitrogen --restore
else
#  xsetroot -solid grey20
feh --bg-scale WP/111200.jpg
  echo "SFW WP Loaded" > $HOME/log/wp.log
fi
}

# autostart
autostart() {
   setwp
   unclutter -grab -root &
   xmodmap .xmodmap
   xcmenu -d
   sxhkd &
   redshift -l 64:25 -b 0.8:0.8 &> /dev/null &
}

# kill leftovers
autokill() {
   killall unclutter
   killall xcmenu
   killall unclutter
   killall sxhkd
}

autostart &
exec herbstluftwm
autokill; sleep 1
