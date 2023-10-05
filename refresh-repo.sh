#!/bin/sh

rm -rf ./home-manager
rm -rf ./nixos

cp -r /home/giga/.config/home-manager .
cp -r /etc/nixos .
