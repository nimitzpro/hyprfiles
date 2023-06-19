#!/bin/sh

# autoload -Uz compinit promptinit
# compinit
# promptinit

# bindkey  "^[[H"   beginning-of-line
# bindkey  "^[[F"   end-of-line
# bindkey  "^[[3~"  delete-char

typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete


key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

bindkey "^H" backward-delete-word
bindkey "^[[3;5~" delete-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget compinit
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

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
# Aliases
alias cp='cp -iv --reflink=auto'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias mkdir="mkdir -v"
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias ls='ls --color=auto --human-readable --group-directories-first --classify'
alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'


alias sup="rclone sync ~/Drive/ astroalex005:"
alias sdown="rclone sync astroalex005: ~/Drive/"

# Bluetooth device MACros
alias btr5="wl-copy '40:ED:98:1B:7A:9E'"
alias trusty="wl-copy '47:00:00:00:07:21'"


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
