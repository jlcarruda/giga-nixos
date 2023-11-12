#!/bin/sh

while getopts "ho:" opt; do
  case "$opt" in
  h)
    print_help
    exit 0
    ;;
  o) only=$OPTARG ;;
  esac
done

if [ -z "$only" ]; then
  only='all'
fi

nixos_dir="/etc/nixos"

if [ -d "$nixos_dir/.backup" ]; then
  rm -rf "$nixos_dir/.backup"
fi

mkdir -p "$nixos_dir/.backup"

backup() {
  cp "$nixos_dir/cachix.nix" "$nixos_dir/.backup"
  cp -r "$nixos_dir/cachix" "$nixos_dir/.backup"
  cp "$nixos_dir/configuration.nix" "$nixos_dir/.backup"
  cp "$nixos_dir/hardware-configuration.nix" "$nixos_dir/.backup"
}

inject() {
  backup
  if [ "$only" = "all" ]; then
    _inject_cachix
    _inject_config_os
    # _inject_hardware
  elif [ "$only" = "cachix" ]; then
    _inject_cachix
  elif [ "$only" = "os" ]; then
    _inject_config_os
  elif [ "$only" = "hardware" ]; then
    # _inject_hardware
  fi
}

_inject_cachix() {
  cp -r ./nixos/cachix "$nixos_dir"
  cp -r ./nixos/cachix.nix "$nixos_dir"
}

_inject_config_os() {
  cp -r ./nixos/configuration.nix "$nixos_dir"
}

_inject_hardware() {
  cp -r ./nixos/hardware-configuration.nix "$nixos_dir"
}

inject

chown -R root:root "$nixos_dir"
