#!/bin/sh

CURRENT=$(cat speaker.txt)

if [[ $CURRENT -eq 44 ]] then
    wpctl set-default 61
    echo "61" >speaker.txt
else
    wpctl set-default 44
    echo "44" >speaker.txt
fi
