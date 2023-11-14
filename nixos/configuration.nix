# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

let
  userName="giga"; 
  xOutput="Virtual1";
  nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./cachix.nix

    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.consoleMode = "auto";
  boot.loader.efi.canTouchEfiVariables = true;
  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.

  services = {
	tumbler.enable = true;
	xserver = {
		enable = true;
		layout = "us";
		gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
		displayManager = {
			lightdm = {
				enable = true;
				greeters = {
					slick = {
						enable = true;
						draw-user-backgrounds = true;
					};
				};
			};
			setupCommands = ''
			${pkgs.xorg.xrandr}/bin/xrandr --output ${xOutput} --mode 1920x1080
			'';
		};
		windowManager.qtile.enable = true;
		desktopManager = {
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
			};
		};
	};
  }; 

 # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
  # };
  users.users.${userName} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    home = "/home/${userName}";
    extraGroups = [ 
			"wheel"
    	"net"
			"audio"
			"video"
			"docker"
			"networkmanager"
   	];
  	packages = with pkgs; [
			zsh
   	];
 	};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
	systemPackages = with pkgs; [
    	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			wget
			nix-gaming.packages.${pkgs.hostPlatform.system}.northstar-proton
			bc
			wmctrl
			ripgrep
			rustc
			wirelesstools
		];
  };

  programs = {
	thunar = {
		plugins = with pkgs.xfce; [
			thunar-archive-plugin
			thunar-volman
		];	
	};
	zsh = {
		enable = true;
		ohMyZsh = {
   			enable = true;
    			plugins = ["git" "python" "docker"];
    			theme = "agnoster";
  		};
		shellAliases = {
			ll = "ls -l";
			rebuild = "sudo nixos-rebuild switch";	
		};
  	};
  };
	
	fonts.fontDir.enable = true;

  home-manager.users.${userName} = { pkgs, ... }: {
	fonts = {
		# packages = with pkgs; [
		# ];
		fontconfig.enable = true;
	};
	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "steam" "vscode" "linuxKernel" ];
	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.allowBroken = true;
	home.packages = with pkgs; [
		(nerdfonts.override { fonts =[ "FiraCode" "DroidSansMono" "Hack" "AnonymousPro" ]; })
		jetbrains-mono
		fira-code-symbols
		font-awesome
		fira-mono
		docker
		tmux
		nmap
		docker
		zsh
		firefox
		alacritty
		git
		flameshot
		gcc
		dunst
		nodejs
		pavucontrol
		neovim
		picom
		steam
		gobuster
		go
		aircrack-ng
		nitrogen
		rofi
		fzf
		tldr
		vimPlugins.vim-parinfer
	];
	home.stateVersion = "23.05";
  	
	services.picom = {
		backend = "xrender";
		# backend = "glx";
		enable = true;
		fade = true;
		vSync = true;
		fadeDelta = 4;
		extraArgs = [
			"--experimental-backends"
		];
		fadeExclude = [
			"class_g = 'slop'"
		];
		fadeSteps = [
			0.03
			0.03
		];
		opacityRules = [
			"99:class_g = 'Code' && focused"
			"85:class_g = 'Code' && !focused"
			"99:class_g = 'Alacritty' && focused"
			"85:class_g = 'Alacritty' && !focused"
			"99:class_g = 'alacritty' && focused"
			"85:class_g = 'alacritty' && !focused"
			"99:class_g = 'Rofi' && focused"
			"85:class_g = 'Rofi' && !focused"
			"99:class_g = 'URxvt' && focused"
			"85:class_g = 'URxvt' && !focused"
			"99:class_g = 'Thunar' && focused"
			"85:class_g = 'Thunar' && !focused"
			"99:class_g = 'thunar' && focused"
			"85:class_g = 'thunar' && !focused"
			"99:class_g = 'thunderbird' && focused"
			"85:class_g = 'thunderbird' && !focused"
			"99:class_g = 'Mail' && focused"
			"85:class_g = 'Mail' && !focused"
			"99:class_g = 'Msgcompose' && focused"
			"85:class_g = 'Msgcompose' && !focused"
			"99:class_g = 'Conky' && focused"
			"85:class_g = 'Conky' && !focused"
			"99:class_g = 'TelegramDesktop' && focused"
			"85:class_g = 'TelegramDesktop' && !focused"
			"99:class_g = 'whatsdesk' && focused"
			"85:class_g = 'whatsdesk' && !focused"
			"99:class_g = 'brave' && focused"
			"85:class_g = 'brave' && !focused"
			"99:class_g = 'firefox' && focused"
			"85:class_g = 'firefox' && !focused"
		];
		wintypes = { 
			tooltip 	  = { fade = true; shadow = false; opacity = 0.9; };
			menu          = { fade = true; shadow = false; opacity = 0.9; };
			popup_menu    = { fade = false; shadow = true; opacity = 0.9; };
			dropdown_menu = { fade = true; shadow = false; opacity = 0.9; };
			utility       = { fade = true; shadow = false; opacity = 0.9; };
			dialog        = { fade = true; shadow = false; opacity = 0.9; };
			notify        = { fade = true; shadow = false; opacity = 0.9; };
		};
		settings = {
			unredir-if-possible = true;
			# paint-on-overlay = true
			# glx-no-stencil = true
			# glx-no-rebind-pixmap = true
			# glx-swap-method = "copy"
			show-all-xerrors = false;
			log-level = "info";
			xrender-sync-fence = true;
			detect-transient = true;
			use-ewmh-active-win = true;
			detect-client-opacity = true;
			animation-stiffness = 230;
			animation-window-mass = 0.5;
			animation-dampening = 25;
			animation-clamping = false;
			animation-for-open-window = "zoom"; #open window
			animation-for-unmap-window = "auto"; #minimize window
			animation-for-workspace-switch-in = "fly-in"; #the windows in the workspace that is coming in
			animation-for-workspace-switch-out = "auto"; #the windows in the workspace that are coming out
			animation-for-transient-window = "fly-in"; #popup windows
			corner-radius = 10;
			round-borders = 10;
			rounded-corners-exclude = [
				"class_g = 'awesome'"
				"class_g = 'kitty'"
				"class_g = 'Polybar'"
			];
			round-borders-rule = [
				"3:class_g      = 'XTerm'"
				"3:class_g      = 'URxvt'"
				"10:class_g     = 'Alacritty'"
				"15:class_g     = 'Signal'"
				];
			blur = {
				method = "dual_kawase";
				strength = 10;
				deviation = 1;
				kern = "31,31,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
				background = true;
				background-frame = true;
				background-fixed = true;
				#kern = "3x3box";
			};
			blur-background-exclude = [
				"window_type = 'dock'"
				"window_type = 'desktop'"
				"class_g = 'slop'"
				"class_g = 'Gromit-mpx'"
				"class_i = 'Gromit-mpx'"
				"class_g = 'Slack'"
				"class_i = 'Slack'"
				"class_g = 'slack'"
				"class_i = 'slack'"
				"class_g = 'Peek'"
				"_GTK_FRAME_EXTENTS@:c"
				"QTILE_INTERNAL:32c = 1"
			];
		};
	};	
	programs = {
		tmux = {
			enable = true;
			clock24 = true;
			shortcut = "a";
			baseIndex = 1;
			escapeTime = 0;
			plugins = with pkgs; [
				tmuxPlugins.better-mouse-mode
			];
			extraConfig = ''
			set-option -sa terminal-overrides ",xterm*:Tc"
			########## Common configs ############
			# unbind C-b
			# set -g prefix C-a
			# bind C-a send-prefix

			setw -g mode-keys vi
			setw -g mouse on
			setw -g monitor-activity on

			set -g base-index 1
			set-window-option -g automatic-rename on
			set-option -g set-titles on

			set -g default-terminal screen-256color
			set -g status-keys vi
			set -g history-limit 10000
			set -sg escape-time 0

			########### Keybinds ################

			bind r source-file ~/.tmux.conf \; display ".tmux.conf reloaded!"

			# Open window
			bind N new-window
			bind -n C-S-n new-window
			bind y setw synchronize-panes

			# Use Alt-arrow keys without prefix key to switch panes
			bind -n M-Left select-pane -L
			bind -n M-Right select-pane -R
			bind -n M-Up select-pane -U
			bind -n M-Down select-pane -D

			# Ctrl-Shift-x without prefix to close pane
			#bind -n C-x kill-pane
			#bind -n C-S-x kill-pane
			bind -n M-x kill-pane

			bind -n M-d split-pane -h
			bind -n M-e split-pane -v

			# Shift Arrow to switch windows
			bind -n S-Left previous-window
			bind -n S-Right next-window

			bind h select-pane -L
			bind j select-pane -D
			bind k select-pane -U
			bind l select-pane -R

			bind -n M-\\ split-pane -h
			bind -n M-- split-pane -v

			bind -n C-M-n new-window
			bind C-n new-window

			## Vi copy override
			unbind [
			bind Escape copy-mode
			#bind -T vi-copy y copy-pipe 'xclip -in -selection clipboard'

			#unbind p
			#bind p paste-buffer
			# Copy buffer to clipboard
			#bind C-c run-shell -b "tmux save-buffer - | xclip -i -sel clipboard"
			#bind C-v run-shel -b "tmux set-buffer \"$(xclip -o -sel clipboard)\"; tmux paste-buffer"

			is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?lvim?x?)(diff)?$'"
			bind-key -n M-Left  if-shell  "$is_vim"  "send-keys M-Left"  "select-pane -L"
			bind-key -n M-Down   if-shell  "$is_vim"  "send-keys M-Down"   "select-pane -D"
			bind-key -n M-Up  if-shell  "$is_vim"  "send-keys M-Up"  "select-pane -U"
			bind-key -n M-Right   if-shell  "$is_vim"  "send-keys M-Right"   "select-pane -R"
			#bind-key -n C-\   if-shell  "$is_vim"  "send-keys C-\\"  "select-pane -l"

			#THEME
			set -g status-bg black
			set -g status-fg white
			set -g status-interval 60
			set -g status-left-length 30
			#set -g status-left '#[fg=green](#S) #(whoami) #(curl "wttr.in/?format=3")'
			set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=white]%H:%M#[default]'

			# Floaterm bindings
			# bind-key -n T if-shell "$is_vim" "send-keys T"

			# TPM plugin
			set -g @plugin 'tmux-plugins/tmp'

			# Plugins list
			#set -g @plugin 'tmux-plugins/tmux-ressurect'
			#set -g @plugin 'tmux-plugins/tmux-continuum'
			#set -g @plugin 'christoomey/vim-tmux-navigator'
			#set -g @plugin 'jimeh/tmux-themepack'
			#set -g @themepack 'powerline/default/cyan'
			#set -g @ressurect-capture-pane-contents 'on'
			#set -g @continuum-resote 'on'
			set -g @plugin 'tmux-plugins/tmux-sensible'
			set -g @plugin 'tmux-plugins/tmux-yank' 
			set -g @plugin 'catppuccin/tmux'

			run '~/.tmux/plugins/tpm/tpm'

			'';
		};
		vscode = {
			enable = true;
			enableExtensionUpdateCheck = true;
			extensions = with pkgs.vscode-extensions; [
				dracula-theme.theme-dracula
				#vscodevim.vim
				yzhang.markdown-all-in-one
				bbenoist.nix
				jdinhlife.gruvbox
				ms-azuretools.vscode-docker
				dbaeumer.vscode-eslint
				ms-python.python
			];
		};
	};
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

