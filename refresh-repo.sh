#!/bin/sh

rm -rf ./home-manager
rm -rf ./nixos

mkdir -p .config

cp -r /home/giga/.config/home-manager ./.config
cp -r /home/giga/.config/qtile ./.config/
cp -r /etc/nixos .
