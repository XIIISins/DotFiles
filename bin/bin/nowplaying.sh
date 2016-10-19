#!/bin/bash
#
# Now playing with UNP (Firefox)
#
NOWP=""
CMD="toilet -f chunky"


# Loop
while :; do
	CURSONG=$(cat $HOME/.unp/unp_now_playing.txt)
	if [ "$CURSONG" != "$NOWP" ]; then
		NOWP=$CURSONG
    if [ $TOILET -eq '1' ]; then
  		echo $NOWP | $CMD
    else
      echo $NOWP
    fi
		sleep 5
	else
		sleep 10
	fi
done
