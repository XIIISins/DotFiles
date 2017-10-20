#!/usr/local/bin/bash
#
# Now playing with UNP (Firefox)
#
#set -x

NOWP=""
TOILET=${TOILET:0}
CMD="toilet -f chunky"
BAR=${BAR:0}


# Loop
while :; do
	CURSONG=$(cat $HOME/.unp/unp_now_playing.txt)
	if [ "$CURSONG" != "$NOWP" ]; then
		NOWP=$CURSONG
    if [[ $TOILET == '1' ]]; then
  		echo $NOWP | $CMD
    elif [[ $BAR -gt '0' ]]; then
      echo "${NOWP:0:30}.."
    else
      echo $NOWP
    fi
		sleep 5
	else
		sleep 10
	fi
done
