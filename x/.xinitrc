#!/bin/sh
set -x

#  ╻ ╻╻┏┓╻╻╺┳╸┏━┓┏━╸
#  ┏╋┛┃┃┗┫┃ ┃ ┣┳┛┃
# ╹╹ ╹╹╹ ╹╹ ╹ ╹┗╸┗━╸
# by tudurom
# no login manager since forever

# Strange things from the default .xinitrc {{{
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# }}}

# Set screen
#xrandr --output LVDS-1 --primary
xrandr --output DP-1 --left-of VGA-1
xrandr --output VGA-1 --primary
xrandr --output DP-3 --right-of VGA-1
xrandr --output LVDS-1 --below VGA-1

# Load fonts
xset +fp ~/.fonts
xset +fp /usr/share/fonts/local/
xset fp rehash

# Map Caps to Ctrl
#setxkbmap -option ctrl:nocaps
# URxvt clipboard magic
autocutsel -selection clipboard -fork &

#source ~/.scripts/screenlayout
# It's unclutter-xfixes-git
#unclutter -b
mpd &
redshift &
#notifyd &
xsetroot -cursor_name left_ptr &
#exec wm
#sxhkd -c $HOME/.config/sxhkd/sxhkdrc-bspwm &
#exec wm
#exec bspwm
#source ~/.scripts/startwmutils
#exec backflip

#hlwm
sxhkd -c $HOME/.config/sxhkd/sxhkdrc_herbstluftwm
exec herbstluftwm

