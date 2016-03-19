#!/bin/sh
#
#

# Functions
setwp() {
TIME=`date +"%H%M"`
if [[ $TIME -gt "1800" ]] || [[ $TIME -lt "0700" ]]; then
  echo "$TIME:HOME WP Loaded" >> $HOME/log/wp.log
  feh --bg-scale ~/WP/wallhaven-73894.png
else
  xsetroot -solid grey20
#  nitrogen --restore
  echo "$TIME:SFW WP Loaded" >>$HOME/log/wp.log
fi
}

autokill() {
   killall unclutter
   killall xcmenu
   killall unclutter
   killall sxhkd
   killall stalonetray
   killall dropbox
   killall nm-applet
#   killall pulse.sh
}

autostart() {
   setwp
   unclutter -grab -root &
   xcmenu -d
#   sxhkd &
#   stalonetray &
   $HOME/bin/tray &
   dropbox &
   nm-applet &
   numlockx on
   urxvt -e wdo -s
#   pulse.sh
}

homescreen() {
xrandr --output VGA-1 --mode 1920x1080 --primary
xrandr --output LVDS-1 --off
}

# General Setup

# Home screen
#homescreen

# Start pulseaudio and load module-loopback
(pulseaudio -D && pactl load-module module-loopback) &

# Load resources.
xrdb -load ~/.Xresources

# Fix Mouse cursor
xsetroot -cursor_name left_ptr &

# Shiny stuff
#compton &

# URxvt Daemon
#urxvtd -q &

# MPD daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd

# Mouse accel off
xset m 1 1

# Start KVM Server (synergy)
synergys -d ERROR -c $HOME/.quicksynergy/synergy.conf &

xset s off
xset -dpms
xset r rate 350 45
xset +fp /usr/share/fonts/TTF
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp $HOME/.local/share/fonts
xset +fp $HOME/.local/share/fonts/jmk
xset +fp $HOME/.local/share/fonts/misc
xset +fp $HOME/.local/share/fonts/ohsnap
xset +fp $HOME/.local/share/fonts/terminesspowerline
setxkbmap -option terminate:ctrl_alt_bksp

#######
# DWM #
#######
start_dwm() {
# status bar
while true; do
 xsetroot -name "NP: `mpc_np` | `uname -r` | `uptime | sed 's/.*average: //'` | `memusage` | Batt: `acpi | awk '{print $4}' | sed 's/,//g'` |`date "+%A %b %d %Y %R"`"
 sleep 1
done &


# Set a nice background.
setwp

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
}

########
# 2BWM #
########
start_2bwm(){
# Start window manager in the background. If it dies, X still lives.
2bwm &

# Panel
#2bwm_panel | lemonbar -p -F "#FFB5B2AF" -B "#FF282522" -g "1920x20+0+0" -f "Tewi-9" &
sh $HOME/.config/2bwm/2bwm_panel3 &

# Set a nice background.
setwp

# Start a terminal in the foreground. If this dies, X dies.
#exec xterm
exec urxvt
}

################
# Herbstluftwm #
################
start_hlwm(){
# autostart
autostart &
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
exec herbstluftwm
autokill; sleep 1
}

#########
# BspWM #
#########
start_bspwm() {
    xsetroot -name background
    autostart &
    statsbar.sh &
    sxhkd -c $HOME/.config/sxhkd/sxhkdrc.bspwm &
    exec bspwm
    autokill; sleep 1
}

################
# Awesome Dude #
################
start_awesome() {
    autostart &
    xsetroot -name background
    exec awesome
    autokill; sleep 1
}

# Start dwm if argument is given
case $1 in
    hlwm)
        start_hlwm
        ;;
    2bwm)
        start_2bwm
        ;;
    bspwm)
        start_bspwm
        ;;
    dwm)
        start_dwm
        ;;
    awesome)
        start_awesome
        ;;
esac
