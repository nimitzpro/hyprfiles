#!/bin/sh

# autoload -Uz compinit promptinit
# compinit
# promptinit

# bindkey  "^[[H"   beginning-of-line
# bindkey  "^[[F"   end-of-line
# bindkey  "^[[3~"  delete-char

export EDITOR="vim"
export READER="zathura"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export VIDEO="mpv"
export IMAGE="feh"
export COLORTERM="truecolor"
export WM="hyprland"
export PAGER="less"

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

# alias lf="lfrun"
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
alias ls='exa'
alias ll='exa --classify -l'
alias lla='exa --classify -la'
# alias ls='ls --color=auto --human-readable --group-directories-first --classify'
# alias ll='ls --color=auto --human-readable --group-directories-first --classify -l'
# alias lla='ls --color=auto --human-readable --group-directories-first --classify -la'

alias pacsize="pacman -Qi | grep -E '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"

alias sup="rclone --verbose --interactive sync ~/Drive/ astroalex005:"
alias sdown="rclone --verbose --interactive sync astroalex005: ~/Drive/"

# Bluetooth device MACros
alias btr5="wl-copy '40:ED:98:1B:7A:9E'"
alias trusty="wl-copy '47:00:00:00:07:21'"
BTR5='40:ED:98:1B:7A:9E'
TRUSTY='47:00:00:00:07:21'

# z alias
# alias z="cd"
alias btc="bluetoothctl connect"
alias btd="bluetoothctl disconnect"

alias commands="echo 'gc = comment/uncomment\n%s//ge = Find and Replace\n'"

alias hypr="nvim ~/.config/hyprland"
alias bar="nvim ~/.config/waybar"
alias rebar="killall waybar && nohup waybar &"


export PATH=$PATH:$GOPATH/bin

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

# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# zoxide
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
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

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}

# Completions.
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

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin alias z=__zoxide_z
\builtin alias zi=__zoxide_zi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
eval "$(zoxide init zsh)"

source "$HOME/git-projects/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$HOME/git-projects/zsh-history-substring-search/zsh-history-substring-search.zsh"
source "$HOME/git-projects/zsh-autosuggestions/zsh-autosuggestions.zsh"
