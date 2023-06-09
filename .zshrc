#!/bin/sh

PS1=exec neofetch

PROMPT="%F{165}%n%f%F{165}@%f%F{165}%m%f:%F{51}%d%f $ "

alias \#="./.local/bin/wrappedhl"

    HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

alias code-python="code --enable-proposed-api ms-python.python"

alias discord="discord -enable-features=UseOzonePlatform --ozone-platform=wayland"

alias volup="wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"

alias voldown="wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"

alias lightup="sudo light -A 5"
alias lightdown="sudo light -U 5"

alias lf="lfrun"

alias sup="rclone sync ~/Drive/ astroalex005:"
alias sdown="rclone sync astroalex005: ~/Drive/"

gpge() {
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        gpg -o "$1.gpg" --symmetric --cipher-algo AES256 "$1"
    #    openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -in "$1" -out "$2"
    else
        echo "add file names"
    fi
}

gpgd() {
    if [ "$1" != "" ] # or better, if [ -n "$1" ]
    then
        gpg -o "${1%.*}" -d "$1" && rm "$1"
    #    openssl enc -aes-256-cbc -md sha512 -pbkdf2 -iter 1000000 -salt -in "$1" -out "$2" -d
    else
        echo "add file names"
    fi
}
