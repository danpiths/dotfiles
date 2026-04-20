{
  homeDirectory,
  pkgs,
  username,
  stateVersion,
  inputs,
  catppuccinTheme,
  config,
  ...
}: let
  packages = import ./packages.nix {inherit pkgs;};
  zshPath = "${pkgs.zsh}/bin/zsh";
in {
  imports = [
    inputs.direnv-instant.homeModules.direnv-instant
    inputs.nvf.homeManagerModules.default
  ];

  home = {
    inherit
      packages
      username
      stateVersion
      homeDirectory
      ;

    # symlink files directly
    # (do not use recursive to avoid cpoying instead of symlinking)
    file.".config/graphite" = {
      source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/graphite";
    };
    file.".config/karabiner" = {
      source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/karabiner";
    };

    sessionVariables = {
      MAKEFLAGS = "SHELL=${zshPath}";
    };
  };

  gtk.gtk4.theme = null;

  programs = import ./programs.nix {inherit homeDirectory pkgs catppuccinTheme;};
}
