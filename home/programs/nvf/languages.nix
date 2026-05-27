{
  enableDAP = true;
  enableExtraDiagnostics = true;
  enableFormat = true;
  enableTreesitter = true;

  html.enable = true;

  bash = {
    enable = true;
    lsp.enable = true;
  };

  css = {
    enable = true;
    lsp.enable = true;
  };

  gleam = {
    enable = true;
    lsp.enable = true;
  };

  go = {
    enable = true;
    lsp.enable = true;
  };

  lua = {
    enable = true;
    lsp = {
      enable = true;
      lazydev.enable = true;
    };
  };

  markdown = {
    enable = true;
    lsp = {
      enable = true;
      servers = ["markdown-oxide"];
    };
    extensions.markview-nvim.enable = true;
  };

  nix = {
    enable = true;
    lsp.enable = true;
  };

  python = {
    enable = true;
    lsp.enable = true;
  };

  sql = {
    enable = true;
    lsp.enable = false;
  };

  typescript = {
    enable = true;
    lsp.enable = true;
    extensions.ts-error-translator.enable = true;
    extraDiagnostics.enable = false;
  };
}
