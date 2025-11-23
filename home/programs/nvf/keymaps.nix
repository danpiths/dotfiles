[
  # Leader groups
  {
    mode = ["n"];
    key = "<leader>c";
    action = "<nop>";
    desc = "+git-conflict";
  }
  {
    mode = ["n"];
    key = "<leader>d";
    action = "<nop>";
    desc = "+debug";
  }
  {
    mode = ["n"];
    key = "<leader>ht";
    action = "<nop>";
    desc = "+toggle [Gitsigns]";
  }

  # Zen
  {
    mode = ["n"];
    key = "<leader>z";
    action = "<cmd>lua Snacks.zen()<CR>";
    desc = "toggle zen mode";
  }
  {
    mode = ["n"];
    key = "<leader>Z";
    action = "<cmd>lua Snacks.zen.zoom()<CR>";
    desc = "toggle zoom";
  }

  # Scratch
  {
    mode = ["n"];
    key = "<leader>.";
    action = "<cmd>lua Snacks.scratch()<CR>";
    desc = "toggle scratch buffer";
  }
  {
    mode = ["n"];
    key = "<leader>S";
    action = "<cmd>lua Snacks.scratch.select()<CR>";
    desc = "select scratch buffer";
  }

  # Todo (or toggle)
  {
    mode = ["n"];
    key = "<leader>t";
    action = "<nop>";
    desc = "+todo (or toggle)";
  }
  {
    mode = ["n"];
    key = "<leader>ti";
    action = "<cmd>lua require('nvim-biscuits').toggle_biscuits()<CR>";
    desc = "toggle nvim-b[i]scuits";
  }

  # Terminal
  {
    mode = ["n"];
    key = "<C-/>";
    action = "<cmd>lua Snacks.terminal.toggle()<CR>";
    desc = "toggle terminal";
  }
  {
    mode = ["n"];
    key = "<c-_>";
    action = "<cmd>lua Snacks.terminal()<CR>";
    desc = "which_key_ignore";
  }

  # Notifications
  {
    mode = ["n"];
    key = "<leader>n";
    action = "<nop>";
    desc = "+notifications";
  }
  {
    mode = ["n"];
    key = "<leader>nn";
    action = "<cmd>lua Snacks.notifier.show_history()<CR>";
    desc = "notification history";
  }
  {
    mode = ["n"];
    key = "<leader>nd";
    action = "<cmd>lua Snacks.notifier.hide()<CR>";
    desc = "dismiss all notifications";
  }

  # Open
  {
    mode = ["n"];
    key = "<leader>o";
    action = "<nop>";
    desc = "+open";
  }
  {
    mode = ["n"];
    key = "<leader>oo";
    action = "<cmd>Oil<CR>";
    desc = "open oil.nvim";
  }
  {
    mode = ["n"];
    key = "<leader>od";
    action = "<cmd>lua Snacks.dashboard.open()<CR>";
    desc = "open dashboard";
  }

  # Plugins
  {
    mode = ["n"];
    key = "<leader>p";
    action = "<nop>";
    desc = "+plugin";
  }
  {
    mode = ["n"];
    key = "<leader>pl";
    action = "<nop>";
    desc = "+plugin luadev";
  }
  {
    mode = ["n"];
    key = "<leader>pll";
    action = "<Plug>(Luadev-RunLine)";
    desc = "plugin luadev run line";
  }
  {
    mode = ["n"];
    key = "<leader>plr";
    action = "<Plug>(Luadev-Run)";
    desc = "plugin luadev run";
  }
  {
    mode = ["n" "v"];
    key = "<leader>plw";
    action = "<Plug>(Luadev-RunWord)";
    desc = "plugin luadev run word";
  }

  # Quickfix
  {
    mode = ["n"];
    key = "<leader>q";
    action = "<nop>";
    desc = "+quickfix";
  }
  {
    mode = ["n"];
    key = "<leader>qo";
    action = "<cmd>:copen<CR>";
    desc = "quickfix open";
  }
  {
    mode = ["n"];
    key = "<leader>qc";
    action = "<cmd>:cclose<CR>";
    desc = "quickfix close";
  }

  # Buffers
  {
    mode = ["n"];
    key = "<leader>b";
    action = "<nop>";
    desc = "+buffer";
  }
  {
    mode = ["n"];
    key = "<leader>bd";
    action = "<cmd>lua Snacks.bufdelete()<CR>";
    desc = "delete buffer";
  }
  {
    mode = ["n"];
    key = "<leader>bD";
    action = "<cmd>lua Snacks.bufdelete.all()<CR>";
    desc = "delete all buffers";
  }

  # Files
  {
    mode = ["n"];
    key = "<leader><space>";
    action = "<cmd>lua Snacks.picker.smart()<CR>";
    desc = "smart find files";
  }
  {
    mode = ["n"];
    key = "<leader>e";
    action = "<cmd>lua Snacks.explorer()<CR>";
    desc = "file explorer";
  }

  # Find
  {
    mode = ["n"];
    key = "<leader>f";
    action = "<nop>";
    desc = "+find";
  }
  {
    mode = ["n"];
    key = "<leader>fb";
    action = "<cmd>lua Snacks.picker.buffers({ on_show = function() vim.cmd.stopinsert() end, win = { input = { keys = { ['d'] = 'bufdelete' } } } })<CR>";
    desc = "find buffer";
  }
  {
    mode = ["n"];
    key = "<leader>ff";
    action = "<cmd>lua Snacks.picker.files()<CR>";
    desc = "find file";
  }
  {
    mode = ["n"];
    key = "<leader>fg";
    action = "<cmd>lua Snacks.picker.git_files()<CR>";
    desc = "find git file";
  }
  {
    mode = ["n"];
    key = "<leader>fp";
    action = "<cmd>lua Snacks.picker.projects()<CR>";
    desc = "find project";
  }
  {
    mode = ["n"];
    key = "<leader>fr";
    action = "<cmd>lua Snacks.picker.recent()<CR>";
    desc = "find recent";
  }

  # Git
  {
    mode = ["n"];
    key = "<leader>g";
    action = "<nop>";
    desc = "+git/github";
  }
  {
    mode = ["n"];
    key = "<leader>gb";
    action = "<cmd>lua Snacks.picker.git_branches()<CR>";
    desc = "git branches";
  }
  {
    mode = ["n"];
    key = "<leader>gl";
    action = "<cmd>lua Snacks.picker.git_log()<CR>";
    desc = "git log";
  }
  {
    mode = ["n"];
    key = "<leader>gL";
    action = "<cmd>lua Snacks.picker.git_log_line()<CR>";
    desc = "git log line";
  }
  {
    mode = ["n"];
    key = "<leader>gs";
    action = "<cmd>lua Snacks.picker.git_status()<CR>";
    desc = "git status";
  }
  {
    mode = ["n"];
    key = "<leader>gS";
    action = "<cmd>lua Snacks.picker.git_stash()<CR>";
    desc = "git stash";
  }
  {
    mode = ["n"];
    key = "<leader>gd";
    action = "<cmd>lua Snacks.picker.git_diff()<CR>";
    desc = "git diff (hunks)";
  }
  {
    mode = ["n"];
    key = "<leader>gf";
    action = "<cmd>lua Snacks.picker.git_log_file()<CR>";
    desc = "git log file";
  }
  {
    mode = ["n"];
    key = "<leader>gg";
    action = "<cmd>lua Snacks.lazygit.open()<CR>";
    desc = "open lazygit";
  }

  # GitHub
  {
    mode = [
      "n"
      "v"
    ];
    key = "<leader>gB";
    action = "<cmd>lua Snacks.gitbrowse()<CR>";
    desc = "github browse";
  }
  {
    mode = ["n"];
    key = "<leader>gi";
    action = "<cmd>lua Snacks.picker.gh_issue()<CR>";
    desc = "github issues (open)";
  }
  {
    mode = ["n"];
    key = "<leader>gI";
    action = "<cmd>lua Snacks.picker.gh_issue({ state = 'all' })<CR>";
    desc = "github issues (all)";
  }
  {
    mode = ["n"];
    key = "<leader>gp";
    action = "<cmd>lua Snacks.picker.gh_pr()<CR>";
    desc = "github pull requests (open)";
  }
  {
    mode = ["n"];
    key = "<leader>gP";
    action = "<cmd>lua Snacks.picker.gh_pr({ state = 'all' })<CR>";
    desc = "gitHub pull requests (all)";
  }

  # grep
  {
    mode = ["n"];
    key = "<leader>/";
    action = "<cmd>lua Snacks.picker.grep()<CR>";
    desc = "grep";
  }

  # Search
  {
    mode = ["n"];
    key = "<leader>s";
    action = "<nop>";
    desc = "+search";
  }
  {
    mode = ["n"];
    key = "<leader>sb";
    action = "<cmd>lua Snacks.picker.lines()<CR>";
    desc = "search buffer lines";
  }
  {
    mode = ["n"];
    key = "<leader>sB";
    action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
    desc = "search open buffers";
  }
  {
    mode = [
      "n"
      "x"
    ];
    key = "<leader>sw";
    action = "<cmd>lua Snacks.picker.grep_word()<CR>";
    desc = "search visual selection or word";
  }
  {
    mode = ["n"];
    key = "<leader>s\"";
    action = "<cmd>lua Snacks.picker.registers()<CR>";
    desc = "search registers";
  }
  {
    mode = ["n"];
    key = "<leader>s/";
    action = "<cmd>lua Snacks.picker.search_history()<CR>";
    desc = "search search history";
  }
  {
    mode = ["n"];
    key = "<leader>sa";
    action = "<cmd>lua Snacks.picker.autocmds()<CR>";
    desc = "search autocmds";
  }
  {
    mode = ["n"];
    key = "<leader>s:";
    action = "<cmd>lua Snacks.picker.command_history()<CR>";
    desc = "search command history";
  }
  {
    mode = ["n"];
    key = "<leader>sc";
    action = "<cmd>lua Snacks.picker.commands()<CR>";
    desc = "search commands";
  }
  {
    mode = ["n"];
    key = "<leader>sd";
    action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
    desc = "search diagnostics";
  }
  {
    mode = ["n"];
    key = "<leader>sD";
    action = "<cmd>lua Snacks.picker.diagnostics_buffer()<CR>";
    desc = "search buffer diagnostics";
  }
  {
    mode = ["n"];
    key = "<leader>sh";
    action = "<cmd>lua Snacks.picker.help()<CR>";
    desc = "search help pages";
  }
  {
    mode = ["n"];
    key = "<leader>sj";
    action = "<cmd>lua Snacks.picker.jumps()<CR>";
    desc = "search jumps";
  }
  {
    mode = ["n"];
    key = "<leader>sk";
    action = "<cmd>lua Snacks.picker.keymaps()<CR>";
    desc = "search keymaps";
  }
  {
    mode = ["n"];
    key = "<leader>sl";
    action = "<cmd>lua Snacks.picker.loclist()<CR>";
    desc = "search location list";
  }
  {
    mode = ["n"];
    key = "<leader>sm";
    action = "<cmd>lua Snacks.picker.marks()<CR>";
    desc = "search marks";
  }
  {
    mode = ["n"];
    key = "<leader>sM";
    action = "<cmd>lua Snacks.picker.man()<CR>";
    desc = "search man pages";
  }
  {
    mode = ["n"];
    key = "<leader>sq";
    action = "<cmd>lua Snacks.picker.qflist()<CR>";
    desc = "search quickfix list";
  }
  {
    mode = ["n"];
    key = "<leader>sR";
    action = "<cmd>lua Snacks.picker.resume()<CR>";
    desc = "resume search";
  }
  {
    mode = ["n"];
    key = "<leader>su";
    action = "<cmd>lua Snacks.picker.undo()<CR>";
    desc = "search undo history";
  }
  {
    mode = ["n"];
    key = "<leader>ss";
    action = "<cmd>lua Snacks.picker.lsp_symbols()<CR>";
    desc = "search lsp symbols";
  }
  {
    mode = ["n"];
    key = "<leader>sS";
    action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<CR>";
    desc = "search lsp workspace symbols";
  }

  # References
  {
    mode = [
      "n"
      "t"
    ];
    key = "]]";
    action = "<cmd>lua Snacks.words.jump(vim.v.count1)<CR>";
    desc = "next reference";
  }
  {
    mode = [
      "n"
      "t"
    ];
    key = "[[";
    action = "<cmd>lua Snacks.words.jump(-vim.v.count1)<CR>";
    desc = "prev reference";
  }

  # LSP
  {
    mode = ["n"];
    key = "<leader>l";
    action = "<nop>";
    desc = "+lsp";
  }
  {
    mode = ["n"];
    key = "<leader>lR";
    action = "<cmd>lua Snacks.rename.rename_file()<CR>";
    desc = "rename file";
  }
  {
    mode = ["n"];
    key = "<leader>lf";
    action = "<cmd>lua require('conform').format()<CR>";
    desc = "format buffer";
  }
  {
    mode = ["n"];
    key = "<leader>la";
    action = "<cmd>Lspsaga code_action<CR>";
    desc = "get code actions";
  }
  {
    mode = ["n"];
    key = "]d";
    action = "<cmd>Lspsaga diagnostic_jump_next<CR>";
    desc = "next diagnostic";
  }
  {
    mode = ["n"];
    key = "[d";
    action = "<cmd>Lspsaga diagnostic_jump_prev<CR>";
    desc = "prev diagnostic";
  }
  {
    mode = ["n"];
    key = "<S-k>";
    action = "<cmd>Lspsaga hover_doc<CR>";
    desc = "prev diagnostic";
  }
  {
    mode = ["n"];
    key = "gd";
    action = "<cmd>lua Snacks.picker.lsp_definitions()<CR>";
    desc = "goto definition";
  }
  {
    mode = ["n"];
    key = "gE";
    action = "<cmd>lua Snacks.picker.lsp_declarations()<CR>";
    desc = "goto d[E]claration";
  }
  {
    mode = ["n"];
    key = "grr";
    action = "<cmd>lua Snacks.picker.lsp_references()<CR>";
    nowait = true;
    desc = "goto references";
  }
  {
    mode = ["n"];
    key = "gI";
    action = "<cmd>lua Snacks.picker.lsp_implementations()<CR>";
    desc = "goto implementation";
  }
  {
    mode = ["n"];
    key = "gD";
    action = "<cmd>lua Snacks.picker.lsp_type_definitions()<CR>";
    desc = "goto type [D]efinition";
  }

  # UI
  {
    mode = ["n"];
    key = "<leader>u";
    action = "<nop>";
    desc = "+ui";
  }
  {
    mode = ["n"];
    key = "<leader>uC";
    action = "<cmd>lua Snacks.picker.colorschemes()<CR>";
    desc = "colorschemes";
  }
  {
    mode = ["n"];
    key = "<leader>w";
    action = "<C-w>w";
    desc = "switch windows (easier)";
  }
  {
    mode = ["n"];
    key = "<leader>uh";
    action = "<cmd>nohlsearch<CR>";
    desc = "clear search highlights";
  }
  {
    mode = [
      "n"
      "v"
    ];
    key = "j";
    action = "gj";
    desc = "move down visual line";
  }
  {
    mode = [
      "n"
      "v"
    ];
    key = "k";
    action = "gk";
    desc = "move up visual line";
  }
]
