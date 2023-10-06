#!/bin/sh

if [[ $EUID > 0 ]]; then
    echo "Please run as SUDO for injecting new nixos config. Aborting..."
    exit 1
fi

nixos_dir="./testing" # CHANGE IT TO /etc/nixos when running

if [ -d "$nixos_dir/.backup" ]; then
    rm -rf "$nixos_dir/.backup"
fi

mkdir -p "$nixos_dir/.backup"
cp "$nixos_dir/cachix.nix" "$nixos_dir/.backup"
cp -r "$nixos_dir/cachix" "$nixos_dir/.backup"
cp "$nixos_dir/configuration.nix" "$nixos_dir/.backup"
cp "$nixos_dir/hardware-configuration.nix" "$nixos_dir/.backup"
cp -r ./nixos/* "$nixos_dir"