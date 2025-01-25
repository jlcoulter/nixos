{ config, pkgs, ... }:

{
  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "24.11"; 


  home.packages = [
  pkgs.hello

    
  ];

  home.file = {};

  programs.git = {
    enable = true;
    userName = "jlcoulter";
    userEmail = "coulter.l.jack@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
      };
    };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHihghlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
	update = "sudo nixos-rebuild switch --flake ~/flake/#default";
	};
	histSize = 10000;
      };


  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs.home-manager.enable = true;
}
