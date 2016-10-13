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
		echo $NOWP | $CMD
		sleep 5
	else
		sleep 10
	fi
done