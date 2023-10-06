#!/bin/sh

cp -r ./.config ./.backup
cp -r ./nixos ./.backup

sudo ./refresh-nixos-on-repo.sh

cp -r /home/giga/.config/home-manager ./.config
cp -r /home/giga/.config/qtile ./.config
chown -R giga:users ./.config