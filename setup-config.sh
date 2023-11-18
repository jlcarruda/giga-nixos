#!/bin/sh

USER=$(whoami)
CONFIG_DIR="/home/$USER/.config"
PICTURES_DIR="/home/$USER/Pictures"
BACKUP_DIR="$CONFIG_DIR/.backup"
if [ -d "$BACKUP_DIR" ]; then
    rm -rf "$BACKUP_DIR"
fi

mkdir -p "$BACKUP_DIR"

configs=("qtile" "home-manager" "alacritty" "rofi")

for dir in "${configs[@]}"; do
    if [ -d "$CONFIG_DIR/$dir" ]; then
        cp -r "$CONFIG_DIR/$dir" "$BACKUP_DIR"
        rm -rf "$CONFIG_DIR/$dir"
    fi
    cp -r "./.config/$dir" "$CONFIG_DIR"
done

if [ ! "$(ls -A $PICTURES_DIR)" ]; then
    cp -r "./Pictures/*" "$PICTURES_DIR"
fi

# INSTALL NYOOM
git clone --depth 1 https://github.com/nyoom-engineering/nyoom.nvim.git ~/.config/nvim
~/.config/nvim/bin/nyoom install
~/.config/nvim/bin/nyoom sync 

