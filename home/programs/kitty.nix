{
  enable = true;

  shellIntegration = {
    enableZshIntegration = true;
    mode = "no-cursor";
  };
  enableGitIntegration = true;

  environment = {
    SNACKS_KITTY = "true";
  };

  settings = {
    window_padding_width = "8 16 16";
    hide_window_decorations = "titlebar-only";
    cursor_shape = "block";
    cursor_shape_unfocused = "hollow";
    cursor_trail = 50;
    cursor = "none";
    cursor_blink_interval = 0;
    cursor_trail_start_threshold = 4;
    scrollback_lines = 100000;
  };
}
