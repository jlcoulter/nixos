{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/pcloud/pcloud.nix
      ../../modules/bluetooth/bluetooth.nix
    ];

  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 80 443 25565 ];
  allowedUDPPortRanges = [
    { from = 4000; to = 4007; }
    { from = 8000; to = 8010; }
  ];
};
  
  nixpkgs.config.allowBroken = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options ="--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  #nixpkgs.config.allowUnsupportedSystem = true;

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

  services = {
    xserver = {
      # enable = true;
      # windowManager.leftwm.enable = true;
      # displayManager.lightdm.enable = true;
    xkb = {
      layout = "us";
      variant = "";
      };
    };
    picom.enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # services.xserver.wacom.enable = true;

  virtualisation.virtualbox.host.enable = true;
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];
  users.extraGroups.vboxusers.members = ["jc"];
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  services.printing = { 
    enable = true; drivers = [ pkgs.epson-escpr ]; 
  };
  
  services.avahi = { 
    enable = true; nssmdns4 = true; 
  }; 
  
  hardware.sane = { 
    enable = true; 
    extraBackends = [ pkgs.utsushi ]; 
  }; 

  services.tailscale.enable = true;

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
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  hardware = {
    graphics = {
        enable = true;
        enable32Bit = true;
    };

    amdgpu.amdvlk = {
        enable = true;
        support32Bit.enable = true;
    };
};
# services.flatpak.enable = true;

  nix.settings.trusted-users = [ "root" "jc" ];

  users.users.jc = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Jack Coulter";
    extraGroups = [ "networkmanager" "wheel" "scanner" "lp" "audio" ];
    packages = with pkgs; [
	libreoffice
	signal-desktop
        zsh
        neofetch
        prusa-slicer
        discord
        spotify
        gimp
        vscode
	exercism
        davinci-resolve
        inkscape
	inkscape-with-extensions
        blender
        neovim
        git
        alacritty
        protonup
	zettlr
	osu-lazer-bin
	texliveFull
	sane-airscan
	sane-backends
	krita
	darktable
	skanlite
	firefox
	aseprite
	vimPlugins.nvim-lspconfig
	nixd
	pyright
	ruff
	lua-language-server
	prismlauncher
	teams-for-linux
	minecraft-server
	docker-client
	zellij
    ];
  };

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
	google-fonts
	];


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    mangohud
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
