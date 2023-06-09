#!/bin/sh

gaps=$(hyprctl getoption general:gaps_out | grep -oP "(?<=int: ).*")
echo "$gaps"
if [ "$gaps" -eq 5 ]; then
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:gaps_in 0
    hyprctl keyword decoration:rounding 0
    hyprctl --batch "keyword general:col.active_border rgba(ff33ccee) rgba(9900ffee) 45deg;
    keyword general:col.inactive_border rgba(595959aa)"
else
    hyprctl keyword general:gaps_out 5
    hyprctl keyword general:gaps_in 5
    hyprctl keyword decoration:rounding 5
    hyprctl --batch "keyword general:col.active_border rgba(33ccffee) rgba(00ff99ee) 45deg;
    keyword general:col.inactive_border rgba(595959aa)"
fi

exit 0
