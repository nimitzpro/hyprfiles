#!/bin/sh

process=$(ps aux | grep swayidle | grep -v grep)

if [[ $process = "" ]]; then
	exec swayidle
else
	killall swayidle
fi
