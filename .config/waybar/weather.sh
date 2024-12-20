#!/bin/sh

# wttr.in's location service is a bit shit
# location=$1
# if [[ -z "$1" ]]; then
# 	ifconfigco=$(curl -sS ifconfig.co/json)
# 	city=$(echo $ifconfigco | jq ".city")
#
# 	# 	if [[ $city -eq "" ]]; then
# 	# 		$city = "N/A"
# 	# 	fi
#
# 	country_code=$(echo $ifconfigco | jq ".country_iso")
#
# 	location=$(echo $city,$country_code | sed --expression "s/\"//g")
# fi

# Set up caching to avoid tons of reqs to wttr
# cachedir=~/.cache/rbn
# cachefile=${0##*/}-$location
#
# if [ ! -d $cachedir ]; then
# 	mkdir -p $cachedir
# fi
#
# if [ ! -f $cachedir/$cachefile ]; then
# 	touch $cachedir/$cachefile
# fi
#
# # Save current IFS
# SAVEIFS=$IFS
# # Change IFS to new line.
# IFS=$'\n'
#
# cacheage=$(($(date +%s) - $(stat -c '%Y' "$cachedir/$cachefile")))
# if [ $cacheage -gt 1740 ] || [ ! -s $cachedir/$cachefile ]; then
# 	data=($(curl -s https://en.wttr.in/$location\?0qnT 2>&1))
# 	echo ${data[0]} | cut -f1 -d, >$cachedir/$cachefile
# 	echo ${data[1]} | sed -E 's/^.{15}//' >>$cachedir/$cachefile
# 	echo ${data[2]} | sed -E 's/^.{15}//' >>$cachedir/$cachefile
# fi

# weather=($(cat $cachedir/$cachefile))
#
# # Restore IFSClear
# IFS=$SAVEIFS

location_string=$(head -n 1 "/home/nimitz/.config/waybar/loc.txt" | sed 's/ /%20/g')
# echo ${location_string} > test.txt
# if [[ -z $location_string ]]; then
#   winfo=$(curl -s https://wttr.in\?0qnTm)
# else
#   winfo=$(curl "https://wttr.in/${location_string}?0qnTm")
# fi

winfo=$(curl -s https://wttr.in\?0qnTm)

location=$(head -1 <<<"$winfo") # | sed 's/\\//')
city=$(cut -d',' -f1 <<<"$location")
country=$(sed 's/^.*, //' <<<"$location")
temperature=$(sed '4q;d' <<<"$winfo" | grep -oE "[+\-\(\)]*([0-9]+.*)" | sed 's/ //' | xargs)
condition=$(sed '3q;d' <<<"$winfo" | grep -oE "[a-zA-Z]+[a-zA-Z ]*" | xargs)
wind=$(sed '5q;d' <<<"$winfo" | grep -oE '.{2}[0-9]+.*$' | xargs)
visibility=$(sed '6q;d' <<<"$winfo" | grep -oE "[0-9]+.*$" | xargs)
precipitation=$(sed '7q;d' <<<"$winfo" | grep -oE "[0-9.]+.*$" | xargs)

time=$(date '+%X%t%t%x')

# weather=$(${winfo[0]} | cut -f1 -d)
# temperature=$(echo ${weather[2]} | sed -E 's/ //g')

# https://fontawesome.com/icons?s=solid&c=weather
# echo $(echo ${weather[1]##*,} | tr '[:upper:]' '[:lower:]')
case $(echo ${condition} | tr '[:upper:]' '[:lower:]') in
"clear" | "sunny")
	icon=""
	;;
"partly cloudy")
	icon=""
	;;
"cloudy")
	icon=""
	;;
"overcast")
	icon=""
	;;
"mist" | "fog" | "freezing fog")
	icon=""
	;;
"patchy rain possible" | "patchy light drizzle" | "light drizzle" | "patchy light rain" | "light rain" | "light rain shower" | "rain")
	icon=""
	;;
"moderate rain at times" | "moderate rain" | "heavy rain at times" | "heavy rain" | "moderate or heavy rain shower" | "torrential rain shower" | "rain shower")
	icon=""
	;;
"patchy snow possible" | "patchy sleet possible" | "patchy freezing drizzle possible" | "freezing drizzle" | "heavy freezing drizzle" | "light freezing rain" | "moderate or heavy freezing rain" | "light sleet" | "ice pellets" | "light sleet showers" | "moderate or heavy sleet showers")
	icon=""
	;;
"blowing snow" | "moderate or heavy sleet" | "patchy light snow" | "light snow" | "light snow showers")
	icon=""
	;;
"blizzard" | "patchy moderate snow" | "moderate snow" | "patchy heavy snow" | "heavy snow" | "moderate or heavy snow with thunder" | "moderate or heavy snow showers")
	icon=""
	;;
"thundery outbreaks possible" | "patchy light rain with thunder" | "moderate or heavy rain with thunder" | "patchy light snow with thunder")
	icon=""
	;;
*)
	icon=""
	# echo -e "{\"text\":\""\<span font=\'RobotoMono Nerd Font\'\>$icon\<\/span\>"\", \"alt\":\""${weather[0]}"\", \"tooltip\":\""${weather[0]}: $temperature ${weather[1]}"\"}"
	;;
esac

echo -e "{\"text\":\""\<span font=\'Font Awesome 5 Free 10\'\>$icon\<\/span\>" $temperature\", \"class\": \"weather\", \"alt\":\"${city}\", \"tooltip\":\"${city}, ${country}Temp:	  $temperatureWind:	   $windVisibility:	$visibilityRainfall:		$precipitation$time\"}"
