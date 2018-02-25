#!/bin/bash

RANDOMNR=$(( ( RANDOM % 10 )  + 1 ))
MAXTRIES=3
TRIES=1
printf "Enter a number between 1 and 10\n"
while read -r line; do
    if [[ $line -eq $RANDOMNR ]]; then
        printf "Correct!" 
        exit 0
    elif [[ $TRIES -lt $MAXTRIES ]]; then
       ((TRIES++))
        printf "Wrong! Try again\n"
    else
        printf "No more tries left, bye!"
        exit 0
    fi
done