{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jcpc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = { enable = true; drivers = [ pkgs.epson-escpr ]; };
  services.avahi = { enable = true; nssmdns4 = true; }; # Find scanner on network
  hardware.sane = { enable = true; extraBackends = [ pkgs.utsushi ]; }; services.udev.packages = [ pkgs.utsushi ];

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.jc = {
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" ];
    packages = with pkgs; [
        flatpak
        rofi
        feh
        zsh
        picom
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
	texliveFull
	scribus
	xsane
	sane-airscan
	sane-backends
	krita
	wacomtablet
	openscad
	darktable
	skanlite
	librewolf
    ];
  };

  fonts.packages = with pkgs; [
	jetbrains-mono
	];

  hardware.graphics.enable32Bit = true;


  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  home-manager = {
  extraSpecialArgs = { inherit inputs; };
  backupFileExtension = "backup";
  users = {
  "jc" = import ./home.nix;
  };
  };

  system.stateVersion = "24.11"; # Did you read the comment?

}
