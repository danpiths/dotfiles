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
      sha256 = "sha256-kMnSOFumRtMK1SN34oL+VsoLtsx1dxxY5USvwTP4TMU=";
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
      ripgrep
      sqlfluff
      tree-sitter
      nodejs
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
      persistent-breakpoints = {
        package = persistent-breakpoints-nvim;
        setup = ''
          require("persistent-breakpoints").setup({
            load_breakpoints_event = { "BufReadPost" },
          })
        '';
      };
    };

    inherit (autogroups_and_commands) augroups;
    inherit (autogroups_and_commands) autocmds;

    enableLuaLoader = true;
    autopairs.nvim-autopairs.enable = true;
    comments.comment-nvim.enable = true;
    formatter.conform-nvim = {
      enable = true;
      setupOpts = {
        formatters.erlfmt.command = pkgs.lib.getExe pkgs.erlfmt;
        formatters_by_ft.erlang = ["erlfmt"];
      };
    };
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
      mappings.hover = null;
      ui = {
        enable = true;
      };
    };

    luaConfigRC.breakpoints-picker = ''
      function _G.pick_breakpoints()
        local bps = require("dap.breakpoints").get()
        local items = {}
        for bufnr, buf_bps in pairs(bps) do
          local fname = vim.api.nvim_buf_get_name(bufnr)
          for _, bp in ipairs(buf_bps) do
            table.insert(items, { text = fname .. ":" .. bp.line, file = fname, pos = { bp.line, 0 }, bp_line = bp.line })
          end
        end
        if #items == 0 then vim.notify("No breakpoints set", vim.log.levels.INFO) return end
        Snacks.picker({
          title = "Breakpoints",
          items = items,
          format = "file",
          on_show = function() vim.cmd.stopinsert() end,
          confirm = function(picker, item) picker:close() if item then vim.cmd("edit " .. item.file) vim.api.nvim_win_set_cursor(0, { item.bp_line, 0 }) end end,
          actions = { remove_bp = function(picker)
            for _, item in ipairs(picker:selected({ fallback = true })) do
              vim.cmd("edit " .. item.file)
              vim.api.nvim_win_set_cursor(0, { item.bp_line, 0 })
              require("persistent-breakpoints.api").toggle_breakpoint()
            end
            picker:refresh()
          end },
          win = { input = { keys = { ["d"] = "remove_bp", ["x"] = "remove_bp" } } },
        })
      end

      function _G.goto_breakpoint(dir)
        local bufnr = vim.api.nvim_get_current_buf()
        local all_bps = require("dap.breakpoints").get(bufnr)
        local bps = all_bps[bufnr]
        if not bps or #bps == 0 then vim.notify("No breakpoints in buffer", vim.log.levels.INFO) return end
        local cur = vim.api.nvim_win_get_cursor(0)[1]
        local lines = {}
        for _, bp in ipairs(bps) do table.insert(lines, bp.line) end
        table.sort(lines)
        local target
        if dir == "next" then
          for _, l in ipairs(lines) do if l > cur then target = l break end end
          target = target or lines[1]
        else
          for i = #lines, 1, -1 do if lines[i] < cur then target = lines[i] break end end
          target = target or lines[#lines]
        end
        vim.api.nvim_win_set_cursor(0, { target, 0 })
      end
    '';

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
      presets.tailwindcss-language-server.enable = true;
      servers.elp = {
        cmd = [(pkgs.lib.getExe' pkgs.erlang-language-platform "elp") "server"];
        filetypes = ["erlang"];
        root_markers = ["rebar.config" "erlang.mk" ".git"];
      };
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
