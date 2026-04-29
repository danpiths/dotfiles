{
  enable = true;
  # TODO: nvf accepts the generic "catppuccin" value, but lualine cannot find that theme at runtime.
  # Flavor-specific values like "catppuccin-latte" still fail nvf's enum validation. Keep auto for now.
  theme = "auto";

  componentSeparator = {
    left = " ▎";
    right = " ▎";
  };
  sectionSeparator = {
    left = "█";
    right = "█";
  };

  activeSection = {
    a = [
      ''
        {"mode"}
      ''
    ];
    b = [
      ''
        {"branch"}
      ''
    ];
    c = [
      ''
        {"filename"}
      ''
    ];
    x = [
      ''
        {"encoding"}
      ''
      ''
        {"fileformat"}
      ''
      ''
        {"filetype"}
      ''
    ];
    y = [
      ''
        {"diagnostics"}
      ''
      ''
        {"diff"}
      ''
    ];
    z = [
      ''
        {"progress"}
      ''
      ''
        {"location"}
      ''
    ];
  };
}
