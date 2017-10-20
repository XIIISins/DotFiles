#! /usr/local/bin/bash
#set -x

. panel_config.x
. panel_icons

EPOCH=0

if [ $(pgrep -cx panel) -gt 1 ] ; then
	printf "%s\n" "The panel is already running." >&2
exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc config -m "$(xrandr | grep primary | cut -d' ' -f1)" top_padding $(expr $PANEL_HEIGHT + $top_pad)
bspc subscribe > "$PANEL_FIFO" &
xtitle -sf 'T%s' > "$PANEL_FIFO" &
if [ $EPOCH -eq 1 ]; then
  clock_format='%s'
else
  clock_format='%a %d %B %H:%M'
fi

# Clock
while true; do
  echo "S$(date +"$clock_format")"
  sleep 10
done > "$PANEL_FIFO" &

# Volume
while true; do
  # Not quering pulse because it uses a hell lot of CPU
  state=$(amixer get Master | grep 'Mono: Playback' | grep '\[on]')
  volume=$(amixer -D pulse get Master | grep 'Front Left: Playback' | grep -o '...%' | sed 's/\[//' | sed 's/%//' | sed 's/ //')
  if [ $state ]; then
    if [ $volume -ge 50 ]; then
      vicon=$ICON_VOLUME
    elif [ $volume -gt 0 ] && [ $volume -lt 50 ]; then
      vicon=$ICON_VOLUME_LOW
    else
      vicon=$ICON_VOLUME_LOW
    fi
  else
    vicon=$ICON_MUTE
  fi
  echo -e "V$(icon $vicon) $volume"
  sleep $REFRESH_VOLUME
done > "$PANEL_FIFO" &

# Player status
last_title="-"
while true; do
  if [[ $(mpc status | wc -l) -eq 3 ]]; then
    last_title=$(mpc status | head -n 1) # In case the music is stopped
  elif [[ $(mpc status | wc -l) -eq 0 ]]; then
    last_title="-"
  elif [[ $(mpc status | wc -l) -eq 1 ]]; then
    last_title=$(cat $HOME/.unp/unp_now_playing.txt)
  fi

  if [[ -n $(mpc status | grep paused) ]]; then
    icon="$ICON_PAUSE"
  elif [[ -n $(mpc status | grep playing) ]]; then
    icon="$ICON_PLAY"
  else
    icon="$ICON_STOP"
  fi
  echo -e "PS$(icon $icon) $last_title"
  sleep $REFRESH_MUSIC
done > "$PANEL_FIFO" &

# Battery percentage and time until full charge/discharge
while true; do
  #~/.scripts/i3blocks/battery | read batt_status
  batt_status="$(~/.scripts/battery $ICON_BATTERY_CHARGING $ICON_BATTERY_FULL $ICON_BATTERY_HALF $ICON_BATTERY_EMPTY 2 $COLOR_ICON)"
  echo "B$batt_status"
  sleep $REFRESH_BATTERY
done > "$PANEL_FIFO" &

. panel_colors.x

cat "$PANEL_FIFO" | panel_bar | lemonbar -d -n "$PANEL_WM_NAME" -g "$BAR_GEOMETRY" -f "$PANEL_FONT_FAMILY" -f "$PANEL_ICON_FONT_FAMILY" -f "$PANEL_FONT_FAMILY2" -F "$COLOR_FOREGROUND" -B "$COLOR_BACKGROUND" -U "$COLOR_UNDERLINE" -a 30 -u 2| bash &

wait
