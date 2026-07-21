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
  packages = import ./packages.nix {inherit pkgs inputs;};
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
    file = {
      # symlink files directly
      # (do not use recursive to avoid cpoying instead of symlinking)
      ".zsh_history" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/zsh/zsh_history";
      };
      ".config/graphite" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/graphite";
      };
      ".config/karabiner" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/karabiner";
      };
      ".config/forgecode/.forge.toml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/forgecode/.forge.toml";
      };
      ".config/forgecode/permissions.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/forgecode/permissions.yaml";
      };
    };

    sessionVariables = {
      MAKEFLAGS = "SHELL=${zshPath}";
    };
  };

  programs = import ./programs.nix {inherit homeDirectory pkgs catppuccinTheme config;};
}
