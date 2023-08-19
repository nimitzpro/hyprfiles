#!/bin/sh

state=$(bluetooth | awk '{print $3}')
str="on"

if [[ $state = $str ]]; then
	bluetooth off
else
	bluetooth on
fi

exit 0
