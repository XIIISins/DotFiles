#!/bin/bash
#
# Start csgo server and spit logs
# Requires linux game servers, google it. ALSO get the csgo version （/＞□＜）/亠亠
#

user=csgo
csgoserver=`find / -name "csgoserver" -type f 2>/dev/null`
log1='/opt/csgo/log/script/csgo-server-script.log'
log2=`find /opt/csgo/serverfiles/csgo/logs -maxdepth 1 -type f -printf "%T@ %p\n" | sort -n | tail -n1 | cut -d' ' -f 2-`


if [ $USER != $user ]; then
	su - $user
fi

$csgoserver start

echo -e "Time to rage! （/＞□＜）/亠亠"

while true; do
	for i in log1 log2; do
		tail -n5 $i
		sleep 5
	done
done

