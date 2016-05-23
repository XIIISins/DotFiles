#! /bin/sh

if [ -e "$BSPWM_STATE" ]; then
  bspc wm -l "$BSPWM_STATE"
  rm "$BSPWM_STATE"
fi

#bspc config top_padding		15
bspc config window_gap          10
bspc config border_width        2

bspc config split_ratio         0.50
bspc config borderless_monocle  false
bspc config gapless_monocle     false
bspc config focus_by_distance   true

bspc config normal_border_color "#273941"
#bspc config focused_border_color "#71c2af"
bspc config focused_border_color "$(bspc config normal_border_color)"
bspc config active_border_color "$(bspc config normal_border_color)"

bspc rule -a URxvtQuake sticky=on floating=on

if [ $(bspc query -M | wc -l) -eq 3 ]; then
  bspc monitor DP-1 -d 1 2 3
  bspc monitor VGA-1 -d 4 5 6
  bspc monitor DP-3 -d 7 8 9
else
  bspc monitor -d 1 2 3 4 5 6
fi

compton -b
panel > $HOME/logs/panel.log 2>&1 &
setwall &
