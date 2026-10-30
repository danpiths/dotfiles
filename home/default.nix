{
  homeDirectory,
  pkgs,
  nurPkgs,
  username,
  stateVersion,
  inputs,
  catppuccinTheme,
  config,
  lib,
  ...
}: let
  packages = import ./packages.nix {inherit pkgs inputs nurPkgs;};
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
      # Link live configuration directly; Forge and Claude skills use recursive merges.
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
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/forgecode/forge.toml";
      };
      ".config/forgecode/.mcp.json" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/agent-harness/mcp.json";
      };
      ".config/forgecode/AGENTS.md" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/agent-harness/AGENTS.md";
      };
      ".config/forgecode/permissions.yaml" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/forgecode/permissions.yaml";
      };
      ".config/forgecode/skills" = {
        source = ../files/agent-harness/skills;
        recursive = true;
      };
      ".codex/AGENTS.md" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/agent-harness/AGENTS.md";
      };
      ".claude/CLAUDE.md" = {
        source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/files/agent-harness/AGENTS.md";
      };
      ".claude/skills" = {
        source = ../files/agent-harness/skills;
        recursive = true;
      };
    } // lib.mapAttrs' (name: _: {
      name = ".codex/skills/${name}";
      value = {
        source = ../files/agent-harness/skills + "/${name}";
      };
    }) (builtins.readDir ../files/agent-harness/skills);

    sessionVariables = {
      MAKEFLAGS = "SHELL=${zshPath}";
      NH_SHOW_ACTIVATION_LOGS = "1";
    };
  };

  programs = import ./programs.nix {inherit homeDirectory pkgs catppuccinTheme config nurPkgs;};
}
