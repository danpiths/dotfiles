{
  pkgs,
  catppuccinTheme,
}: let
  ignored_filetypes = [
    "lazy"
    "snacks_dashboard"
    "dirvish"
    "help"
    "notify"
    "NvimTree"
  ];
  lua = pkgs.lib.generators.mkLuaInline;
  autogroups_and_commands = import ./autogroups_and_commands.nix {inherit lua;};
in {
  enable = true;
  defaultEditor = true;
  enableManpages = true;

  settings.vim = {
    startPlugins = with pkgs; [
      vimPlugins.lazy-nvim
      luajitPackages.jsregexp
    ];
    extraPackages = with pkgs; [
      pngpaste
      sqlfluff
      tree-sitter
      nodejs_24
    ];
    extraPlugins = with pkgs.vimPlugins; {
      ts-comments = {
        package = ts-comments-nvim;
      };
    };

    augroups = autogroups_and_commands.augroups;
    autocmds = autogroups_and_commands.autocmds;

    enableLuaLoader = true;
    autopairs.nvim-autopairs.enable = true;
    comments.comment-nvim.enable = true;
    formatter.conform-nvim.enable = true;
    lineNumberMode = "relative";
    mini.icons.enable = true;
    notify.nvim-notify.enable = true;
    notes.todo-comments.enable = true;
    searchCase = "smart";
    snippets.luasnip.enable = true;
    syntaxHighlighting = true;
    undoFile.enable = true;
    viAlias = true;
    vimAlias = true;

    keymaps = import ./keymaps.nix;
    languages = import ./languages.nix;
    statusline.lualine = import ./lualine.nix;
    ui = import ./ui.nix {inherit ignored_filetypes;};

    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;
      mappings = {
        scrollDocsDown = "<C-j>";
        scrollDocsUp = "<C-k>";
      };
      setupOpts = {
        snippets.preset = "luasnip";
        cmdline.keymap.preset = "inherit";
        completion = {
          menu = {
            border = "rounded";
          };
          documentation = {
            window = {
              border = "rounded";
              scrollbar = false;
            };
          };
        };
      };
      sourcePlugins = {
        emoji.enable = true;
        ripgrep.enable = true;
      };
    };

    binds = {
      hardtime-nvim.enable = true;
      whichKey.enable = true;
    };

    assistant.supermaven-nvim = {
      enable = true;
      setupOpts = {
        keymaps = {
          accept_suggestion = "<M-Tab>";
          clear_suggestion = "<M-Esc>";
        };
      };
    };

    debugger.nvim-dap = {
      enable = true;
      mappings.hover = "<leader>dk";
      ui = {
        enable = true;
      };
    };

    diagnostics = {
      enable = true;
      nvim-lint = {
        enable = true;
      };
    };

    git = {
      enable = true;
      gitsigns = {
        enable = true;
        codeActions.enable = true;
      };
    };

    lsp = {
      enable = true;
      mappings.format = null; # disable default format mapping so that conform.nvim can handle it
      formatOnSave = true;
      inlayHints.enable = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      lspsaga = {
        enable = true;
        setupOpts.symbol_in_winbar.enable = false; # disable winbar in lspsaga
      };
      null-ls.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };

    options = {
      shiftwidth = 2;
      tabstop = 2;
    };

    terminal.toggleterm = {
      enable = true;
      setupOpts = {
        winbar.enabled = false;
        direction = "float";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "${catppuccinTheme}";
      transparent = true;
    };

    treesitter = {
      enable = true;
      autotagHtml = true;
      fold = true;
      textobjects.enable = true;
    };

    utility = {
      direnv.enable = true;

      images = {
        img-clip.enable = true;
      };

      motion = {
        flash-nvim.enable = true;
      };

      nix-develop.enable = true;
      nvim-biscuits.enable = true;
      oil-nvim.enable = true;

      preview.markdownPreview = {
        enable = true;
      };

      sleuth.enable = true;

      snacks-nvim = import ./snacks.nix;

      undotree.enable = true;
    };

    visuals = {
      highlight-undo = {
        enable = true;
        setupOpts = {
          inherit ignored_filetypes;
        };
      };
      nvim-scrollbar.enable = true;
      nvim-web-devicons.enable = true;
    };
  };
}
