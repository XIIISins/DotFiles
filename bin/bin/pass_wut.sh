#!/bin/zsh
#
#
set -x

#CMD_CLIP='printf "%s\xFE" $(read -se) | base64 | xsel -i'
#CMDNCLIP='printf "%s\xFE" $(read -se) | base64'




if [ -z $CLIP ]; then
  exit 1
fi

printf "Enter your password:\n"
if [[ $CLIP > 1 ]]; then
  printf "%s\xFE" $(read -se) | base64 | xclip -sel clip
else
  printf "%s\xFE" $(read -se) | base64 
fi

