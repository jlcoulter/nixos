{ config, pkgs, ... }:

let rootPath = ../.; in

{ 
  imports = [
    ./theme.nix
    ./nvim.nix
  ];

  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "24.11"; 

  home.file = {
    #"config.ron".source = ../modules/leftwm;
  };

  gtk = {
    enable = false;
    cursorTheme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    theme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme=true;
      #gtk-font-name=JetBrains Mono, 10;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme=true;
      #gtk-font-name=JetBrains Mono, 10;
    };
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

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;

	  shellAliases = {
	    ll = "ls -l";
 	   update = "sudo nixos-rebuild switch --flake ~/flake/#default";
 	   flake = "nvim ~/flake/flake.nix";
 	   home = "nvim ~/flake/hosts/home/home.nix";
 	   config = "nvim ~/flake/hosts/home/configuration.nix";
	   pynix = "nix-shell ~/code/shell.nix";
	   nvimconfig = "nvim ~/.config/nvim/init.vim";
	   fabric = "java -Xmx2G -jar fabric-server-mc.1.21.4-loader.0.16.10-launcher.1.0.1.jar nogui";
   	 };

 	  oh-my-zsh = {
   	       enable = true;
		  plugins = [

		  ];
		  theme = "agnoster";
		};
	

      };
  


  home.sessionVariables = {
    EDITOR = "nvim";
  };


  programs.home-manager.enable = true;
}
