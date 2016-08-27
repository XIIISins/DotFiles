#!/bin/bash

set -x
# disable path name expansion or * will be expanded in the line
cmd=( $line )

# easter eggs
sep_m="%{B#292929}%{F#833228}  %{F-}%{B-}"
sep_v="%{B#292929}%{F#596875}  %{F-}%{B-}"
sep_d="%{B#292929}%{F#8c5b3e}  %{F-}%{B-}"
sep_c="%{B#292929}%{F#917154}  %{F-}%{B-}"

set -f

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

monitor=${1:-0}

herbstclient pad $monitor 16

{
    # events:
    mpc idleloop player | cat &
    
    # date
    while true ; do
        date +'date_min %H:%M'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    date_pid=$!
    
    while true ; do
	echo "vol $(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')%"
	sleep 1 || break
    done > >(uniq_linebuffered) &
    volume_pid=$!

    # hlwm events
    herbstclient --idle

    # exiting; kill stray event-emitting processes
    kill $date_pid $mpd_pid
} 2> /dev/null | {
    TAGS=( $(herbstclient tag_status $monitor) )
    unset TAGS[${#TAGS[@]}]
    date_min="--"
    nowplaying="nothing to see here"
    windowtitle="...what have you done?"
    visible=true

    while true ; do
        echo -n "%{l}"
        for i in "${TAGS[@]}" ; do
            case ${i:0:1} in
                '#') # current tag
                    echo -n "%{B#833228}"
                    ;;
                '+') # active on other monitor
                    echo -n "%{B#917154}"
                    ;;
                ':')
                    echo -n "%{B-}"
                    ;;
                '!') # urgent tag
                    echo -n "%{B#917154}"
                    ;;
                *)
                    echo -n "%{B-}"
                    ;;
            esac
            echo -n " ${i:1} "
        done
	
	echo -n "%{c}$sep_c%{B#292929} ${windowtitle//^/^^} %{B-}"
	
        # align right
        echo -n "%{r}"
	echo -n "$sep_m"
	echo -n " $nowplaying "
        echo -n "$sep_v"
        echo -n " $volume "
        echo -n "$sep_d"
        echo -n " $date_min "
        echo " "
        # wait for next event
        read line || break
        cmd=( $line ) 
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                TAGS=( $(herbstclient tag_status $monitor) )
                unset TAGS[${#TAGS[@]}]
                ;;
            vol)
                volume="${cmd[@]:1}"
                ;;
            date_min)
                date_min="${cmd[@]:1}"
                ;;
	    mpd_player|player)
                nowplaying="$(mpc current -f '%artist% - %title%')"
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
} 2> /dev/null | lemonbar -g "x16" -B "#1f1f22" -F '#a8a8a8' -f '-*-stlarch-medium-r-*-*-10-*-*-*-*-*-*-*, -*-cure.se-medium-r-*-*-11-*-*-*-*-*-*-*' $1
