#!/bin/bash
#
 
set -x

function uniq_linebuffered() {
    awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
}

# events
{
   # now playing
sha="$(sha1sum $HOME/.unp/unp_now_playing.txt | awk '{print $1}')"
new_sha=""
    while true; do
        if [ -z $(mpc playlist) ]; then
          if [ -e $HOME/.unp/unp_now_playing.txt ]; then
            if [ "$sha" != "$new_sha" ]; then
              sha=$new_sha
              echo youtube
            fi
            new_sha=$(sha1sum $HOME/.unp/unp_now_playing.txt | awk '{print $1}')
          fi
        else
          # echo mpc
          mpc idleloop player | cat &
          mpc_pid=$!
        fi
    sleep 1 || break
    done
} | tee -a $DEVEL_HOME/np_hlwm_tst.log