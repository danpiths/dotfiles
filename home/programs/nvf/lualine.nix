{
  enable = true;
  # TODO: nvf accepts the generic "catppuccin" value, but lualine cannot find that theme at runtime.
  # Flavor-specific values like "catppuccin-latte" still fail nvf's enum validation. Keep auto for now.
  setupOpts = {
    options = {
      theme = "auto";
      component_separators = {
        left = " ▎";
        right = " ▎";
      };
      section_separators = {
        left = "█";
        right = "█";
      };
    };

    sections = {
      lualine_a = ["mode"];
      lualine_b = ["branch"];
      lualine_c = ["filename"];
      lualine_x = [
        "encoding"
        "fileformat"
        "filetype"
      ];
      lualine_y = [
        "diagnostics"
        "diff"
      ];
      lualine_z = [
        "progress"
        "location"
      ];
    };
  };

  integrations.breadcrumbs.nvim-navic.enable = false;
}
