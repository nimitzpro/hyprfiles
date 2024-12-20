#!/bin/sh

mkdir -p .config
rsync -av ~/.config/hypr .config
rsync -av ~/.config/waybar .config
rsync -av ~/.config/mako .config
rsync -av ~/.config/kitty .config

cp -rfv ~/.zshrc .
# cp -rfv ~/drive_secret.aes .
cp -rfv ~/.gitconfig .
cp -rfv ~/.vimrc .
cp -rfv ~/.latexmkrc .

# mkdir -p ~/.local/share
rsync -av ~/.local/share/fonts .local/share

# mkdir -p ~/.config/fontconfig
rsync -av ~/.config/fontconfig .config

# mkdir -p ~/.config/feh
rsync -av ~/.config/feh .config

# replaced by hypridle
# mkdir -p ~/.config/swayidle
# rsync -av ~/.config/swayidle .config

rsync -av ~/.config/darkman .config

rsync -av ~/.config/lf .config

rsync -av ~/.config/nvim .config

rsync -av ~/.local/bin .local

# rm -rf ./.config
# cp -R ~/.config ./

pacman -Q >packages.txt
