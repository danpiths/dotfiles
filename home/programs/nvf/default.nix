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
  dooing-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "dooing";
    src = pkgs.fetchFromGitHub {
      owner = "atiladefreitas";
      repo = "dooing";
      rev = "master";
      sha256 = "sha256-s4/BSJd56MnYNkd+nf+BPN6lZGd/BGNy+dWuzeGG4Uo=";
    };
  };
  luadev-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "luadev";
    src = pkgs.fetchFromGitHub {
      owner = "bfredl";
      repo = "nvim-luadev";
      rev = "master";
      sha256 = "sha256-/k/vl22LDq44xut/XW7K9uLxpMNt3vOG7pD02lYRa18";
    };
  };
  vim-tmux-navigator = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tmux-navigator";
    src = pkgs.fetchFromGitHub {
      owner = "christoomey";
      repo = "vim-tmux-navigator";
      rev = "master";
      sha256 = "sha256-IEPnr/GdsAnHzdTjFnXCuMyoNLm3/Jz4cBAM0AJBrj8";
    };
  };
  mdx-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "mdx";
    src = pkgs.fetchFromGitHub {
      owner = "davidmh";
      repo = "mdx.nvim";
      rev = "master";
      sha256 = "sha256-QaPYSTH59j8tUa5rTY8I9VdQWLkhy8SWhNigEXHFn1c=";
    };
  };
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
      mdx-language-server
    ];
    extraPlugins = with pkgs.vimPlugins; {
      ts-comments = {
        package = ts-comments-nvim;
      };
      dooing = {
        package = dooing-nvim;
        setup = ''
          require("dooing").setup({
            quick_keys = false,
            per_project = {
              enabled = true,
              auto_gitignore = "prompt",
            },
          })
        '';
      };
      luadev = {
        package = luadev-nvim;
      };
      vim-tmux-navigator = {
        package = vim-tmux-navigator;
      };
      mdx = {
        package = mdx-nvim;
        setup = ''
          require("mdx").setup({})

          -- Configure mdx_analyzer LSP server using modern vim.lsp.config API
          local util = require 'lspconfig.util'
          vim.lsp.config.mdx_analyzer = {
            cmd = { 'mdx-language-server', '--stdio' },
            filetypes = { 'mdx' },
            root_markers = { 'package.json' },
            settings = {},
            init_options = {
              typescript = {},
            },
            before_init = function(_, config)
              if config.init_options and config.init_options.typescript and not config.init_options.typescript.tsdk then
                config.init_options.typescript.tsdk = util.get_typescript_server_path(config.root_dir)
              end
            end,
          }
          vim.lsp.enable('mdx_analyzer')
        '';
      };
    };

    inherit (autogroups_and_commands) augroups;
    inherit (autogroups_and_commands) autocmds;

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
      config = {
        virtual_text = true;
        signs = {
          text = lua ''
            {
              [vim.diagnostic.severity.ERROR] = '󰅚 ',
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            }
          '';
        };
        float = {
          border = "rounded";
          source = "always";
        };
      };
    };

    git = {
      enable = true;
      gitsigns = {
        enable = true;
        mappings = {
          toggleBlame = "<leader>htb";
          toggleDeleted = "<leader>htd";
        };
        setupOpts = {
          current_line_blame = true;
          current_line_blame_opts = {
            delay = 500;
          };
        };
      };
    };

    lsp = {
      enable = true;
      mappings = {
        format = null; # disable default format mapping so that conform.nvim can handle it
        codeAction = null; # disable default code action mapping so that lspsaga can handle it
      };
      formatOnSave = true;
      inlayHints.enable = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      lspsaga = {
        enable = true;
        setupOpts = {
          symbol_in_winbar.enable = false; # disable winbar in lspsaga
          lightbulb.enable = false; # disable lightbulb in lspsaga
        };
      };
      null-ls.enable = true;
      otter-nvim.enable = true;
      trouble.enable = true;
    };

    options = {
      shiftwidth = 2;
      tabstop = 2;
      signcolumn = "yes";
      termguicolors = true;
      scrolloff = 3;
      wrap = true;
      linebreak = true;
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;
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
      nvim-biscuits = {
        enable = false;
        setupOpts = {
          cursor_line_only = true;
        };
      };
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
