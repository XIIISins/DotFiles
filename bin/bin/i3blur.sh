# How to use:
#
# Just place a lock.png in your home folder to overlay whatever you want

#!/usr/local/bin/bash
scrot 'tmp.png' -e 'convert -blur 0x3 $f ./lockbg.png'
convert -gravity west -composite lockbg.png ~/.lock.png lockfinal.png
i3lock -e -d -f -i lockfinal.png
rm lockfinal.png lockbg.png tmp.png
