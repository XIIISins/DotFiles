#!/bin/bash

# Just a dirty script for lemonbar,
# you need to use 'siji' font for icons.

set -x

# If home, then 1 else 0
HOME_SET=`xrandr | grep 'DP' | grep -v 'disconnected' | wc -l`

# settings
if [ $HOME_SET -eq 0 ]; then
    monitor=${1:-0} # main monitor
    RES="x16";
else
    monitor=${1:-0} # main monitor
    RES="1920+1080x16";
fi
#RES="1920+1920x16"
#RES="1080+1920"
#RES="x16"
FONT="*-siji-medium-r-*-*-10-*-*-*-*-*-*-*"
FONT2="-*-cure-medium-r-*-*-11-*-*-*-*-*-*-*"
# FONT3="IPAGothic-8"
FONT3="-*-ipagothic-medium-r-*-*-8-*-*-*-*-*-*-*"
BG="#1A1C1F"
FG="#A8A8A8"
BLK="#262626"
RED="#834f48"
YLW="#917154"
BLU="#45536E"
GRA="#898989"
VLT="#7B3D93"

# icons
st="%{F$YLW}  %{F-}"
sm="%{F$RED}  %{F-}"
sv="%{F$BLU}  %{F-}"
sd="%{F$VLT}  %{F-}"

# Potato
# sha="$(sha1sum $HOME/.unp/unp_now_playing.txt | awk '{print $1}')"
sha="null"
new_sha="null"
boe=1

# padding
herbstclient pad $monitor 16

# functions
set -f

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

# events
{
    # now playing
    #

    while true ; do
       if [ -z $(mpc playlist) ]; then  # if no plYLIAAR
         if [ -e $HOME/.unp/unp_now_playing.txt ]; then
           if [ "$sha" != "$new_sha" ]; then
             sha=$new_sha
              echo "youtube $boe" 
    #          printf "POTATO boe %d\n" $boe >>   /tmp/potato_out
           fi
           new_sha=$(sha1sum $HOME/.unp/unp_now_playing.txt | awk '{print $1}')
          fi
        else
          mpc idleloop player | cat &
          mpc_pid=$!
        fi
    let boe+=1
    # printf "Kalote boe %d\n" $boe >>   /tmp/potato_out
    sleep 1 || break
    done > >(uniq_linebuffered) & 
    potato_pid=$!
    # echo $potato_pid >> /tmp/potato_out





    # 
    # broken
    # 
    # while true; do
    #     if [ -z $(mpc playlist) ]; then
    #       if [ -e $HOME/.unp/unp_now_playing.txt ]; then
    #       old_sha=""
    #       new_sha=$(sha1sum $HOME/.unp/unp_now_playing.txt | awk '{print $1}')
    #         if [ "$old_sha" != "$new_sha" ]; then
    #           echo youtube
    #         fi
    #       fi
    #     else
    #       # echo mpc
    #       mpc idleloop player | cat &
    #       mpc_pid=$!
    #     fi
    # sleep 1 || break
    # done > >(uniq_linebuffered) &
    #
    # broken
    #

    mpc idleloop player | cat &
    mpc_pid=$!

    # volume
    while true ; do
        # echo "vol $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')" # ALSA volume
				 echo "vol $(pacmd list-sinks | sed -ne '/.*analog-stereo/,$p' | awk '/volume/ {print $5; exit}')" # Alsa for Output Device Corsair Vengeance 2100 Analog Stereo
#        echo "vol $(pactl list sinks | sed -ne '/Name:\ combined/,$p' | awk -F'/' '/Volume/ {print $2}' | head -n1)" # Alsa for Output Device Combined Sink
	sleep 1 || break
    done > >(uniq_linebuffered) &
    vol_pid=$!
# echo $vol_pid >> /tmp/potato_out

    # date
    while true ; do
        date +'date_min %b %d %A '%{F$RED}%{F-}' %H:%M'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    date_pid=$!

    # herbstluftwm
    herbstclient --idle

    # exiting; kill stray event-emitting processes
    kill $potato_pid $mpc_pid $vol_pid $date_pid
} 2> $DEVEL_HOME/panel_stderr.log | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
    time=""
    song="nothing to see here"
    windowtitle="what have you done?"
    visible=true

        while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{U$RED}%{+u}"
                    ;;
				'%') # current tag, focused on different monitor
		            echo -n "%{U$RED}%{+u}"
		            ;;
                '-') # active on other monitor not focused
                    echo -n "%{U$YLW}%{+u}"
                    ;;
				'+') # active on other monitor not focused
		            echo -n "%{U$YLW}%{+u}"
		            ;;
                ':')
                    echo -n "%{-u}"
                    ;;
                '!') # urgent tag
                    echo -n "%{U$YLW}"
                    ;;
                *)
                    echo -n "%{-u}"
                    ;;
            esac
            echo -n " ${i:1} "
        done

	# center window title
	echo -n "%{-u}%{c}$st%{F$GRA}${windowtitle//^/^^} %{F-}"
        # align right
        echo -n "%{r}"
        echo -n "$sm"
        echo -n "$song" %{F$YLW}"$song2"%{F-}
        echo -n "$sv"
        echo -n "$volume"
        echo -n "$sd"
        echo -n "$date "
        echo ""

        # wait for next event
        read line || break
        cmd=( $line )
        # index=0
        # while [ $index -lt "${#cmd[@]}" ]; do
        #     printf "pipo $index- %s\n" ${cmd[$index]} >> /tmp/potato_out2
        #     let index+=1
        # done
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            mpd_player|player)
                #song="$(mpc -f %name% current)"
                song="$(mpc current | awk -F'/' '{print $1}')"
                song2="$(mpc current | awk -F'/' '{print $2}')"
#		song2="$(mpc -f %title% current)"
                ;;
            youtube)
                song="$(cat $HOME/.unp/unp_now_playing.txt | awk -F"-" '{print $1}')"
                song2="$(cat $HOME/.unp/unp_now_playing.txt | awk -F"-" '{print $2}')"
    # printf "youtube boe %d\n" $boe >>   /tmp/potato_out
                ;;
            vol)
                volume="${cmd[@]:1}"
                ;;
            date_min)
                date="${cmd[@]:1}"
                ;;
	    focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
            quit_panel)
                exit
                ;;
            reload)
                exit
                ;;
        esac
    done
} 2> /dev/null | lemonbar -g ${RES} -u 3 -B ${BG} -F ${FG} -f ${FONT} -f ${FONT2} -f ${FONT3} & $1
