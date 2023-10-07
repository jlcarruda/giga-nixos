#!/bin/sh

cp -r ./.config ./.backup
cp -r ./nixos ./.backup

# sudo ./refresh-nixos-on-repo.sh

cp -r /home/giga/.config/home-manager ./.config
cp -r /home/giga/.config/qtile ./.config
cp -r /home/giga/.config/eww ./.config
cp -r /home/giga/.config/rofi ./.config
cp -r /home/giga/.config/alacritty ./.config
chown -R giga:users ./.config