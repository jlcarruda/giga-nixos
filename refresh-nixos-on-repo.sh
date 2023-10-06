#!/bin/sh
rm -rf ./nixos
cp -r /etc/nixos .
chown -R giga:users ./nixos