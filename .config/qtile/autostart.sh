#!/bin/sh
picom --experimental-backends -b &                                      # compositor
nitrogen --restore &                                                    # wallpaper
# eww open bar &                                                          # bar
~/.config/eww/scripts/workspaces &                                      # workspaces for bar

amixer -q sset Master 100% &                                            # set volume 100%
flameshot &                                                             # screenshot tool
dunst &                                                                 # notification daemon

# openvpn3 session-start --config /etc/openvpn/client/nl-04.udp.ovpn &    # start proton vpnx