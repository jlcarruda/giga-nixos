# Giga - NIXOS Personal Config
My personal configs for NixOS Stoat version ricing
## TODO
#### General
- [ ] Set list of keyboard layouts to be cycled (US Intl, BR abnt2)
- [ ] Compatible with multiple monitors
#### QTILE
- [ ] Better bar
  - [ ] add `qtile-extras` for special widgets
    - Probably going to do as an overlay, based on (this gist)[https://gist.github.com/arjan-s/bc942826ff1d2e5e60430740fef912fd]
    - Another possibility is to run `qtile` on a nix-shell with qtile-extras in it
- [ ] Screenshot hotkey to trigger Flameshot
- [ ] Settings switch depending on environment (notebook or desktop)
  - [ ] Notebook
    - [ ] Battery level
    - [ ] Aspect ratio of screen (all apps seems zoomed)
  - [ ] Desktop
    - [ ] 
- [ ] Keyboard layout switch keybind
#### Cybersec
- [x] `burpsuite`
- [x] `nmap`
- [x] `openvpn`
- [x] `gobuster`
- [x] `exploitdb`
- [ ] `pacu`, with nix-shell alias on `.zshrc`
  - [ ] using docker container as solution
## Honorable Mentions
- To [gibranlp](https://github.com/gibranlp), with his [SpectrumOS](https://github.com/gibranlp/SpectrumOS) and [QARSLP](https://github.com/gibranlp/QARSlp/tree/develop) repos which gave me inspiration on some **qtile** and **picom** configs