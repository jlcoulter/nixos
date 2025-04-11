{ config, pkgs, ...}:

{
programs.neovim.extraConfig = ''
call plug#begin()
call plug#end()

'';
}
