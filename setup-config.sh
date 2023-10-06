#!/bin/sh

config_dir="/home/giga/.config"
backup_dir="$config_dir/.backup"
if [ -d "$backup_dir" ]; then
    rm -rf "$backup_dir"
fi

mkdir -p "$backup_dir"

configs=("qtile" "home-manager")

for dir in "${configs[@]}"; do
    if [ -d "$config_dir/$dir" ]; then
        cp -r "$config_dir/$dir" "$backup_dir"
    	cp -r "./.config/$dir" "$config_dir"
    fi
done