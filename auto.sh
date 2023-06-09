#!/bin/sh

rsync -av ~/.config/hypr .config
rsync -av ~/.config/waybar .config
rsync -av ~/.config/mako .config
rsync -av ~/.config/kitty .config

cp -rfv ~/.zshrc .
# cp -rfv ~/drive_secret.aes .
cp -rfv ~/.gitconfig .
cp -rfv ~/.vimrc .

mkdir -p .local/share
rsync -av ~/.local/share/fonts .local/share

pacman -Q > packages.txt
