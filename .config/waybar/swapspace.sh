#!/bin/sh

SPACE=$(cat ~/.config/waybar/space.txt)

if [[ "$SPACE" -eq 0 ]]; then
	sed -i 's/\/\/ SCRIPT //' ~/.config/waybar/config.jsonc
	sed -i -E 's/"([0-9])"|"(10)"/\/\/ SCRIPT &/g' ~/.config/waybar/config.jsonc
	sed -i -E 's/#bf00ff;/#bfff00;/' ~/.config/waybar/style.css
	echo 1 >~/.config/waybar/space.txt
else
	sed -i 's/\/\/ SCRIPT //' ~/.config/waybar/config.jsonc
	sed -i -E 's/"([1-9][1-9])"|"(20)"/\/\/ SCRIPT &/g' ~/.config/waybar/config.jsonc
	sed -i -E 's/#bfff00;/#bf00ff;/' ~/.config/waybar/style.css
	echo 0 >~/.config/waybar/space.txt
fi

exit 0
