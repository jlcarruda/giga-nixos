#!/bin/sh

# Install Home-manager
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

# Inject nixos config
sudo ./inject-nixos-config.sh

# setup config
./setup-config.sh