#!/bin/bash

if [ "$(pactl get-default-sink)" = "alsa_output.usb-audio-technica_AT2020USB_-00.analog-stereo" ]; then
    pactl set-default-sink "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink"
    # pactl move-sink-input "alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink"
    # pactl set-default-source "alsa_input...<second-device-microphone>"
else
    pactl set-default-sink "alsa_output.usb-audio-technica_AT2020USB_-00.analog-stereo"
    # pactl move-sink-input "alsa_output.usb-audio-technica_AT2020USB_-00.analog-stereo"
    # pactl set-default-source "alsa_input...<first-device-microphone>"
fi

# headphone_id=$(pw-cli info alsa_output.usb-audio-technica_AT2020USB_-00.analog-stereo | head -n 1 | awk '{print $2}')
# speaker_id=$(pw-cli info alsa_output.usb-Generic_USB_Audio-00.HiFi__Speaker__sink | head -n 1 | awk '{print $2}')
#
# if [ "$1" = 'speaker' ]; then
#     wpctl set-default "$speaker_id"
# elif [ "$1" = 'headset' ]; then
#     wpctl set-default "$headphone_id"
# else
#     echo 'Unrecognized device name' >&2
#     exit 2
# fi
