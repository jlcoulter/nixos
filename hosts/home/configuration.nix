{ config, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../modules/pcloud/pcloud.nix
      ../../modules/bluetooth/bluetooth.nix
      ../../modules/leftwm/leftwm.nix 
      #../../modules/kde/kde.nix
      ../../modules/virt/virt.nix
      ../../modules/printer/printer.nix
      ../system/system.nix
    ];

  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

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
	aseprite
	librewolf
	vimPlugins.nvim-lspconfig
	nixd
	pyright
	ruff
	lua-language-server
	prismlauncher
	teams-for-linux
	minecraft-server
	zellij
    ];
  };

  # https://librewolf.net/docs/settings/

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
