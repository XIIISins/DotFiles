#! /bin/sh

if [ -e "$BSPWM_STATE" ]; then
  bspc wm -l "$BSPWM_STATE"
  rm "$BSPWM_STATE"
fi

#bspc config top_padding		15
bspc config window_gap          10
bspc config border_width        3
bspc config focus_follow_pointer true

bspc config split_ratio         0.50
bspc config borderless_monocle  false
bspc config gapless_monocle     false
#bspc config focus_by_distance   true


bspc config normal_border_color "#151515"
bspc config focused_border_color "#800000"
bspc config focused_border_color "$(bspc config focused_border_color)"
bspc config active_border_color "$(bspc config normal_border_color)"

bspc rule -a URxvtQuake sticky=on floating=on

if [ $(bspc query -M | wc -l) -eq 3 ]; then
  bspc monitor DP-1 -d 一 二 三
  bspc monitor VGA-1 -d 四 五 六
  bspc monitor DP-3 -d 	七 八 九
else
  bspc monitor -d 一 二 三 四 五 六
fi

compton -b
panel.x > $HOME/var/log/panel.log 2>&1 &
setwall &