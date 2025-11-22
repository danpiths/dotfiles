{ pkgs, catppuccinTheme }:

{
  enable = true;
  shell = "${pkgs.zsh}/bin/zsh";

  clock24 = true;
  customPaneNavigationAndResize = true;
  keyMode = "vi";
  mouse = true;
  prefix = "C-Space";

  baseIndex = 1;
  escapeTime = 1;

  extraConfig = ''
    ##### TrueColor / passthrough / env #####
    set-option -a terminal-features 'xterm-256color:RGB'
    set -g allow-passthrough on
    set-environment -g COLORFGBG '0;15'

    ##### Split keys (keep cwd) #####
    bind \\ split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
    unbind '"'
    unbind %

    ##### Reload config with prefix + r #####
    unbind r
    bind r source-file ~/.config/tmux/tmux.conf

    ##### Movement & zoom #####
    # hjkl navigation + resize is handled by customPaneNavigationAndResize
    bind -r m resize-pane -Z

    ##### Extras #####
    set -g detach-on-destroy off
    set -g renumber-windows on
    set -g set-clipboard on
    set -g status-interval 1

    ##### Vi copy mode tweaks #####
    set-window-option -g mode-keys vi
    bind-key -T copy-mode-vi 'v' send -X begin-selection
    bind-key -T copy-mode-vi 'y' send -X copy-selection
    unbind -T copy-mode-vi MouseDragEnd1Pane
  '';

  plugins = with pkgs.tmuxPlugins; [
    vim-tmux-navigator
    tmux-fzf
    better-mouse-mode
    {
      plugin = extrakto;
      extraConfig = ''
        set -g @extrakto_grab_area full
      '';
    }
    {
      plugin = sensible;
      extraConfig = ''
        # Force tmux to actually use zsh for new panes/windows
        set -g default-shell "${pkgs.zsh}/bin/zsh"
        set -g default-command "${pkgs.zsh}/bin/zsh -l"
      '';
    }
    {
      plugin = resurrect;
      extraConfig = "set -g @resurrect-strategy-vim 'session'";
    }
    {
      plugin = continuum;
      extraConfig = ''
        set -g @continuum-restore 'on'
      '';
    }
    {
      plugin = dotbar;
      extraConfig = ''
        set -g @tmux-dotbar-position "bottom"
        set -g @tmux-dotbar-justify "absolute-centre"

        set -g @tmux-dotbar-left "true"
        set -g @tmux-dotbar-status-left "#S" # see code

        set -g @tmux-dotbar-right "true"
        set -g @tmux-dotbar-status-right "%H:%M" # see code

        set -g @tmux-dotbar-window-status-separator " • "

        set -g @tmux-dotbar-maximized-icon "󰊓"
        set -g @tmux-dotbar-show-maximized-icon-for-all-tabs true

        set -g @tmux-dotbar-bold-status true
        set -g @tmux-dotbar-bold-current-window true
      '';
    }
    {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavor "${catppuccinTheme}"
        set -g @catppuccin_status_background "none"

        set -g @catppuccin_window_text ' #{?window_zoomed_flag,󰊓,} #{b:pane_current_path} '
        set -g @catppuccin_window_current_text ' #{?window_zoomed_flag,󰊓,} #{pane_current_command} '
      '';
    }
  ];
}
