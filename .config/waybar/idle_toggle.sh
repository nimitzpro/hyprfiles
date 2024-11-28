#!/bin/sh

idling=$(find .config -iname hypridle.conf)

if [[ $idling = "" ]]; then
  mv $HOME/.config/hypr/hypridle_disabled.conf $HOME/.config/hypr/hypridle.conf
else
  mv $HOME/.config/hypr/hypridle.conf $HOME/.config/hypr/hypridle_disabled.conf
fi
