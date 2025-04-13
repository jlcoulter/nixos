{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "tokyonight";
          style = "moon";
        };
        assistant = {
          chatgpt.mappings.grammarCorrection.enable = true;
          copilot = {
            enable = true;
            cmp = {
              enable = true;
            };
          };
        };

        autopairs.nvim-autopairs.enable = true;
        options.shiftwidth = 2;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        globals.mapleader = ",";

        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix = {
            enable = true;
            format.enable = true;
            lsp.server = "nixd";
            lsp.package = ["nixd"];
          };
          markdown = {
            enable = true;
            format.enable = true;
            extensions.render-markdown-nvim.enable = true;
          };
          python = {
            enable = true;
            format.enable = true;
          };
          go = {
            enable = true;
            format.enable = true;
            lsp.server = "gopls";
            lsp.package = ["gopls"];
          };
        };
        diagnostics.nvim-lint.enable = true;
      };
    };
  };
}
