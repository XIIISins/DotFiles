#!/bin/bash
#
# Copy todo file
#

tDate=`date +%Y%m%d`

file="/tmp/todo.w"
dest=$HOME/Documents/todo
tName=todo.$tDate

if [ -e $file ]; then
  cp $file $dest/$tName
else
  echo "No file"
fi

