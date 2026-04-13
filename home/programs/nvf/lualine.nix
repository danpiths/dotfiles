{
  enable = true;
  # TODO: catppuccin removed the generic lualine theme, only flavor-specific ones exist now
  # (e.g. catppuccin-latte). nvf's enum doesn't include those yet. Using "auto" as a workaround.
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
