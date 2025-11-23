{
  enable = true;
  setupOpts = {
    animate.enabled = true;
    bigfile.enabled = true;
    bufdelete.enabled = true;
    gh.enabled = true;
    git.enabled = true;
    gitbrowse.enabled = true;
    image.enabled = true;
    indent.enabled = true;
    input.enabled = true;
    lazygit.enabled = true;
    notify.enabled = true;
    picker.enabled = true;
    quickfile.enabled = true;
    scope.enabled = true;
    scratch.enabled = true;
    scroll.enabled = true;
    statuscolumn.enabled = true;
    zen.enabled = true;

    explorer = {
      enabled = true;
      replace_netrw = true;
      trash = true;
    };

    notifier = {
      enabled = true;
      timeout = 5000;
    };

    terminal = {
      enabled = true;
      win = {
        style = "terminal";
        relative = "editor";
        width = 0.8;
        height = 0.8;
        row = 0.1;
        col = 0.1;
        position = "float";
        border = "rounded";
      };
    };

    styles = {
      notification = {
        wo = {
          wrap = true; # Wrap notifications
        };
      };
    };

    dashboard = {
      enabled = true;
      preset = {
        header = ''
          ███████╗██╗   ██╗███████╗██████╗ ██╗   ██╗    ███████╗███████╗ ██████╗ ██████╗ ███╗   ██╗██████╗      ██████╗ ██████╗ ██╗   ██╗███╗   ██╗████████╗███████╗
          ██╔════╝██║   ██║██╔════╝██╔══██╗╚██╗ ██╔╝    ██╔════╝██╔════╝██╔════╝██╔═══██╗████╗  ██║██╔══██╗    ██╔════╝██╔═══██╗██║   ██║████╗  ██║╚══██╔══╝██╔════╝
          █████╗  ██║   ██║█████╗  ██████╔╝ ╚████╔╝     ███████╗█████╗  ██║     ██║   ██║██╔██╗ ██║██║  ██║    ██║     ██║   ██║██║   ██║██╔██╗ ██║   ██║   ███████╗
          ██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔══██╗  ╚██╔╝      ╚════██║██╔══╝  ██║     ██║   ██║██║╚██╗██║██║  ██║    ██║     ██║   ██║██║   ██║██║╚██╗██║   ██║   ╚════██║
          ███████╗ ╚████╔╝ ███████╗██║  ██║   ██║       ███████║███████╗╚██████╗╚██████╔╝██║ ╚████║██████╔╝    ╚██████╗╚██████╔╝╚██████╔╝██║ ╚████║   ██║   ███████║
          ╚══════╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝   ╚═╝       ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝
        '';
        keys = [
          {
            icon = " ";
            key = "f";
            desc = "Find File";
            action = ":lua Snacks.dashboard.pick('files')";
          }
          {
            icon = " ";
            key = "p";
            desc = "Find Project";
            action = ":lua Snacks.dashboard.pick('projects')";
          }
          {
            icon = " ";
            key = "n";
            desc = "New File";
            action = ":ene | startinsert";
          }
          {
            icon = " ";
            key = "/";
            desc = "Find Text";
            action = ":lua Snacks.dashboard.pick('live_grep')";
          }
          {
            icon = " ";
            key = "r";
            desc = "Recent Files";
            action = ":lua Snacks.dashboard.pick('oldfiles')";
          }
          {
            icon = " ";
            key = "s";
            desc = "Restore Session";
            section = "session";
          }
          {
            icon = " ";
            key = "q";
            desc = "Quit";
            action = ":qa";
          }
        ];
      };
      sections = [
        {
          section = "header";
        }
        {
          pane = 1;
          section = "keys";
          gap = 1;
          padding = 1;
        }
      ];
    };
  };
}
