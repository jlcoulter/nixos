{ config, pkgs, ... }:

let rootPath = ../.; in

{
  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "24.11"; 

  fonts.fontconfig.enable = true;
  home.packages = [
  pkgs.hello
    pkgs.jetbrains-mono

    
  ];

  home.file = {
    #"config.ron".source = ../modules/leftwm;
  };

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

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

	  shellAliases = {
	    ll = "ls -l";
 	   update = "sudo nixos-rebuild switch --flake ~/flake/#default";
 	   flake = "nvim ~/flake/flake.nix";
 	   home = "nvim ~/flake/hosts/home.nix";
 	   config = "nvim ~/flake/hosts/configuration.nix";
 	   osu = "xsetwacom --set \"Wacom One by Wacom M Pen stylus\" Area 0 6750 10800 13500 && osu\!";
	    resettablet = "xsetwacom --set \"Wacom One by Wacom M Pen stylus\" ResetArea";
   	 };

 	  oh-my-zsh = {
   	       enable = true;
		  plugins = [];
		  theme = "agnoster";
		};
	

      };
  


  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs.home-manager.enable = true;
}
