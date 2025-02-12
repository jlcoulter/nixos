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

  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.wacom.enable = true;

  virtualisation.virtualbox.host.enable = true;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  users.extraGroups.vboxusers.members = ["jc"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

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

   hardware.opentabletdriver.enable = true;
  services.udev.packages = [ pkgs.utsushi ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.zsh.enable = true;


    nix.settings.trusted-users = [ "root" "jc" ];

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" "docker" ];
    packages = with pkgs; [
	libreoffice
	nemo
        rofi
	signal-desktop
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
	zettlr
	osu-lazer-bin
	texliveFull
	#xsane
	sane-airscan
	sane-backends
	krita
	darktable
	skanlite
	firefox
	aseprite
	vimPlugins.nvim-lspconfig
	pyright
	nodejs_23
	nixd
	ruff
	lua-language-server
    ];
  };

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	google-fonts
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
