#!/bin/sh

export EDITOR="nvim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="feh"
export COLORTERM="truecolor"
export WM="hyprland"
# export PAGER="nvim"
# export DISPLAY=":1.0"

alias neofetch=fastfetch
PS1=exec neofetch
PROMPT="%F{165}%n%f%F{165}@%f%F{165}%m%f:%F{51}%d%f $ "

# zshell config
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
alias reload="source ~/.zshrc"

# Programming, path vars, experimental
alias code-python="code --enable-proposed-api ms-python.python"
alias discord="discord -enable-features=UseOzonePlatform --ozone-platform=wayland"
export GOPATH=$HOME/.go
export PATH=$HOME/.cargo/bin:$PATH:$GOPATH/bin:$HOME/.local/bin
alias gs="git status"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
alias v="nvim"

# Volume and backlight
alias volup="wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
alias voldown="wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
alias lightup="sudo light -A 5"
alias lightdown="sudo light -U 5"

# alias lf="lfrun"
# Command Line Aliases
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
alias ls='exa'
alias ll='exa --classify -l'
alias lla='exa --classify -la'
# alias ls='ls --color=auto --human-readable --group-directories-first --classify'
# alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
# alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'
alias icon="wrestool -x -t 14"

alias sup="rclone --verbose --interactive sync ~/Drive/ astroalex005:"
alias sdown="rclone --verbose --interactive sync astroalex005: ~/Drive/"

# External device MACros
alias btr5="wl-copy '40:ED:98:1B:7A:9E'"
alias trusty="wl-copy '47:00:00:00:07:21'"
BTR5='40:ED:98:1B:7A:9E'
TRUSTY='47:00:00:00:07:21'

alias btc="bluetoothctl connect"
alias btd="bluetoothctl disconnect"

# Phone sync
PHONE="/storage/emulated/0"
alias pull="adbsync pull"
alias push="adbsync push"

# System aliases
alias \#="./.local/bin/wrappedhl" # Start Hyprland
alias pacsize="pacman -Qi | grep -E '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
alias hypr="nvim ~/.config/hypr"
alias bar="nvim ~/.config/waybar"
alias rebar="killall waybar && nohup waybar &"

# bindkey -s '^i' "lfcd\n"
# bindkey -s '^o' "sdir\n"
# bindkey -s '^v' "se\n"
bindkey -s '^o' "lfcd\n"

# alias music='mpc -q play; ~/.config/ncmpcpp/art.sh; sleep 1; ~/.config/ncmpcpp/kitty.sh &; ncmpcpp'

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

# File explorers
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

function __zoxide_pwd() {
    \builtin pwd -L
}
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi
__zoxide_z_prefix='z#'
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"?* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}
if [[ -o zle ]]; then
    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0

        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]] && [[ "${words[-2]}" != "${__zoxide_z_prefix}"?* ]]; then
            \builtin local result
            # shellcheck disable=SC2086,SC2312
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- ${words[2,-1]})"; then
                result="${__zoxide_z_prefix}${result}"
                # shellcheck disable=SC2296
                compadd -Q "${(q-)result}"
            fi
            \builtin printf '\e[5n'
        fi
        return 0
    }

    \builtin bindkey '\e[0n' 'reset-prompt'
    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete __zoxide_z
fi
\builtin alias z=__zoxide_z
\builtin alias zi=__zoxide_zi
eval "$(zoxide init zsh)"q

# _fzf_complete_foo() {
#   _fzf_complete --multi --reverse --header-lines=3 -- "$@" < <(
#     ls -al
#   )
# }
#
# _fzf_complete_foo_post() {
#   awk '{print $NF}'
# }

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Scripts (small)
se() {
	choice="$(find ~/ -mindepth 1 -printf '%P\n' 2>/dev/null | fzf)"
	if [ -f "$HOME/$choice" ]; then
      $EDITOR "$HOME/$choice"
  else
	  cd "$HOME/$choice"
  fi
}

sdir() {
	choice="$(find ~/ -type d -mindepth 1 -printf '%P\n' 2>/dev/null | fzf)"
	if [ -f "$HOME/$choice" ]; then
      $EDITOR "$HOME/$choice"
  else
	  cd "$HOME/$choice"
  fi
}

ser() {
	choice="$(find / -mindepth 1 -printf '%P\n' 2>/dev/null | fzf)"
	if [ -f "/$choice" ]; then
      sudo $EDITOR "/$choice"
  else
    cd "/$choice"
  fi
}
so() {
	choice="$(find ~/ -mindepth 1 -printf '%P\n' 2>/dev/null | fzf)"
	if [ -f "$HOME/$choice" ]; then
      nohup xdg-open "$HOME/$choice" >/dev/null 2>&1 &
  else
	  cd "$HOME/$choice"
  fi
}

source "$HOME/git-projects/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/git-projects/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$HOME/git-projects/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/git-projects/zsh-vi-mode/zsh-vi-mode.zsh"
# set editing-mode vi
# set show-mode-in-prompt on
# set vi-ins-mode-string \1\e[34;1m\2>\1\e[0m\2
# set vi-cmd-mode-string \1\e[33;1m\2>\1\e[0m\2
