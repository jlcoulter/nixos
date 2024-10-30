{ config, pkgs, inputs, ... }:

{
  home.username = "jc";
  home.homeDirectory = "/home/jc";
  home.stateVersion = "22.11"; # Please read the comment before changing.
  

  programs.neovim = {
    enable = true; 
    extraConfig = ''
      set number relativenumber
      '';
      plugins = with pkgs.vimPlugins; [
        {
  	  plugin = nvim-lspconfig;
	}
      ];
    };
  



extraLuaConfig = ''
    ${builtins.readFile ./nvim/init.lua}
    '';

  programs.home-manager.enable = true;
}
