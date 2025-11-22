{ ignored_filetypes }:

{
  breadcrumbs.lualine.winbar.enable = false;
  colorful-menu-nvim.enable = true;
  fastaction.enable = true;
  nvim-ufo.enable = true;

  borders = {
    enable = true;
    plugins = {
      fastaction.enable = true;
      lsp-signature.enable = true;
      lspsaga.enable = true;
      nvim-cmp.enable = true;
      which-key.enable = true;
    };
  };

  illuminate = {
    enable = true;
    setupOpts.filetypes_denylist = [
      "dirvish"
      "help"
      "neo-tree"
      "notify"
      "NvimTree"
    ]
    ++ ignored_filetypes;
  };

  nvim-highlight-colors = {
    enable = true;
    setupOpts = {
      enable_tailwind = true;
    };
  };

  smartcolumn = {
    enable = true;
    setupOpts = {
      disabled_filetypes = ignored_filetypes ++ [
        "text"
        "markdown"
      ];
    };
  };
}
