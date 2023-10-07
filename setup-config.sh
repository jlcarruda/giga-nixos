#!/bin/sh

USER=$(whoami)
config_dir="/home/$USER/.config"
backup_dir="$config_dir/.backup"
if [ -d "$backup_dir" ]; then
    rm -rf "$backup_dir"
fi

mkdir -p "$backup_dir"

configs=("qtile" "home-manager" "alacritty" "eww" "rofi")

for dir in "${configs[@]}"; do
    if [ -d "$config_dir/$dir" ]; then
        cp -r "$config_dir/$dir" "$backup_dir"
        rm -rf "$config_dir/$dir"
    fi
    cp -r "./.config/$dir" "$config_dir"
done