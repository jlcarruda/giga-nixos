#!/bin/sh

print_help () {
  echo "Install and copy configuration NixOS Ricing"
  echo "Usage: $0 [-h] [-o <only>]"
  echo "  -h: Print this help"
  echo "  -o: Install only the specified package (hardware, os, cachix, all)"
}

while getopts "ho:" opt; do
  case "$opt" in
    h) print_help; exit 0 ;;
    o) only=$OPTARG ;;
  esac
done

# install TPM
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Home-manager
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
sudo nix-channel --update

if [ -z "$only" ]; then
  sudo ./inject-nixos-config.sh
else
  sudo ./inject-nixos-config.sh -o $only
fi

# inject dotfiles on home
cp "./dotfiles/.zshrc" "$HOME"

# setup config
./setup-config.sh
