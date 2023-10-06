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
  # i18n.defaultLocale = "en_US.UTF-8";
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
		displayManager = {
			lightdm.enable = true;
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
	picom = {
		enable = true;
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
    			plugins = ["git" "python" "docker" "shellfirm"];
    			theme = "agnoster";
  		};
		shellAliases = {
			ll = "ls -l";
			rebuild = "sudo nixos-rebuild switch";	
		};
  	};
  };

  home-manager.users.${userName} = { pkgs, ... }: {
	fonts.fontconfig.enable = true;
	home.packages = with pkgs; [
		(nerdfonts.override { fonts =[ "FiraCode" "DroidSansMono" ]; })
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
	];
	home.stateVersion = "23.05";
  	
#	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "steam" "vscode" ];
	nixpkgs.config.allowUnfree = true;

	services.picom.enable = true;	
	programs = {
		vscode = {
			enable = true;
			enableExtensionUpdateCheck = true;
			extensions = with pkgs.vscode-extensions; [
				dracula-theme.theme-dracula
				vscodevim.vim
				yzhang.markdown-all-in-one
				bbenoist.nix
				jdinhlife.gruvbox
				ms-azuretools.vscode-docker
				dbaeumer.vscode-eslint
			];
		};
#		steam = {
#			enable = true;
#		};
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

