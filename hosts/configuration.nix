{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./pcloud.nix
    ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options ="--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jcpc";

  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Sydney";

  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.wacom.enable = true;

  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  services.printing = { enable = true; drivers = [ pkgs.epson-escpr ]; 
  };
  services.avahi = { enable = true; nssmdns4 = true; 
  }; 
  hardware.sane = { 
    enable = true; 
    extraBackends = [ pkgs.utsushi ]; 
  }; 
  services.udev.packages = [ pkgs.utsushi ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" ];
    packages = with pkgs; [
        flatpak
	libreoffice
	nemo
        rofi
        feh
        zsh
        neofetch
        prusa-slicer
        unzip
        discord
        spotify
        gimp
        vscode
	exercism
        lsof #list of open files
        davinci-resolve
        inkscape
        blender
        steam
        neovim
        git
        alacritty
        protonup
	rawtherapee
	zettlr
	osu-lazer-bin
	godot_4
	texliveFull
	scribus
	xsane
	sane-airscan
	sane-backends
	krita
	wacomtablet
	kdePackages.wacomtablet
	xf86_input_wacom
	libwacom
	libwacom-surface
	openscad
	darktable
	skanlite
	firefox
	aseprite
    ];
  };

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	];


  hardware.graphics.enable32Bit = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
  ];

  home-manager = {
   extraSpecialArgs = { inherit inputs; };
   backupFileExtension = "backup1";
   users = {
   "jc" = import ./home.nix;
   };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
