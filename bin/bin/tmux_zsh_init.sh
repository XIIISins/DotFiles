#!/usr/local/bin/bash
set -x
# TMUX YO #
MUXHOME=$(test -z $(tmux ls | awk '/home/' | wc -l))$?
NESTMUX=$(test -z $TMUX > /dev/null)$?

if [[ $NESTMUX == "0" ]]; then
  if [[ $MUXHOME == "1" ]]; then
    printf "%s" "tmux running, attach? (Y/n): "
    read muxans
    case $muxans in
      Y|y|yes)
        tmux a -t home
        ;;
      N|n|no)
        tmux_new_win=$(expr $(tmux list-window -t home | awk -F: '{print $1}' | tail -n1 ) + 1)
        tmux neww -t home:$tmux_new_win
        ;;
    esac
  else
    echo "tmux new -s home"
  fi
else
  printf "%s::%s" "$(date '+ %T')" "nested session\n" > $HOME/var/log/tmux.log
fi

# TMUX NO #


