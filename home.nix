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
    extraPackages = with pkgs; [
      xclip wl-clipboard
      luajitPackages.lua-lsp
      ];


      plugins = with pkgs.vimPlugins; [
        
	comment-nvim
	telescope-nvim
	nvim-treesitter
        nvim-lspconfig
	nvim-cmp

	];
      extraLuaConfig = ''
    ${builtins.readFile ./nvim/init.lua}
    '';

};
    
  gtk = { 
    enable = true;
    iconTheme = {
      name = "SolArc-Dark";
      package = pkgs.solarc-gtk-theme;
      };
      };

 home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ"; 

  programs.home-manager.enable = true;
}
