{
  config,
  pkgs,
  ...
}: let
  rootPath = ../.;
in {
  imports = [
    ./theme.nix
  ];

  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "24.11";

  home.file = {
    #"config.ron".source = ../modules/leftwm;
  };

  gtk = {
    enable = false;
    gtk2.extraConfig = "gtk-theme-name = 'phinger-cursors-dark';";
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-theme-name = "Nordic";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-theme-name = "Nordic";
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
      flake = "vim ~/flake/flake.nix";
      home = "vim ~/flake/hosts/home/home.nix";
      config = "vim ~/flake/hosts/home/configuration.nix";
      pynix = "nix-shell ~/code/shell.nix";
      nvimconfig = "vim ~/.config/nvim/init.vim";
      fabric = "java -Xmx2G -jar fabric-server-mc.1.21.4-loader.0.16.10-launcher.1.0.1.jar nogui";
      clobber = "git add . && git commit -m \"$(date)\" && git push";
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
