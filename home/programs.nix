{
  homeDirectory,
  pkgs,
  catppuccinTheme,
}: {
  home-manager = {
    enable = true;
  };

  direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
  direnv-instant.enable = true;

  nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    darwinFlake = "${homeDirectory}/dotfiles"; # sets NH_OS_FLAKE variable for you
  };

  bat.enable = true;

  zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

  codex.enable = true;

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  gh-dash = let
    ghDashThemes = {
      latte = {
        colors = {
          text = {
            primary = "#4c4f69";
            secondary = "#8839ef";
            inverted = "#dce0e8";
            faint = "#5c5f77";
            warning = "#df8e1d";
            success = "#40a02b";
            error = "#d20f39";
          };
          background.selected = "#ccd0da";
          border = {
            primary = "#8839ef";
            secondary = "#bcc0cc";
            faint = "#ccd0da";
          };
        };
      };
      frappe = {
        colors = {
          text = {
            primary = "#c6d0f5";
            secondary = "#ca9ee6";
            inverted = "#232634";
            faint = "#b5bfe2";
            warning = "#e5c890";
            success = "#a6d189";
            error = "#e78284";
          };
          background.selected = "#414559";
          border = {
            primary = "#ca9ee6";
            secondary = "#51576d";
            faint = "#414559";
          };
        };
      };
      macchiato = {
        colors = {
          text = {
            primary = "#cad3f5";
            secondary = "#c6a0f6";
            inverted = "#181926";
            faint = "#b8c0e0";
            warning = "#eed49f";
            success = "#a6da95";
            error = "#ed8796";
          };
          background.selected = "#363a4f";
          border = {
            primary = "#c6a0f6";
            secondary = "#494d64";
            faint = "#363a4f";
          };
        };
      };
      mocha = {
        colors = {
          text = {
            primary = "#cdd6f4";
            secondary = "#cba6f7";
            inverted = "#11111b";
            faint = "#bac2de";
            warning = "#f9e2af";
            success = "#a6e3a1";
            error = "#f38ba8";
          };
          background.selected = "#313244";
          border = {
            primary = "#cba6f7";
            secondary = "#45475a";
            faint = "#313244";
          };
        };
      };
    };
  in {
    enable = true;
    settings = {
      repoPaths = {
        "maximhq/bifrost" = "${homeDirectory}/code/maximhq/bifrost-universe/bifrost";
      };

      theme = ghDashThemes.${catppuccinTheme};
    };
  };

  zsh = import ./programs/zsh.nix {inherit homeDirectory pkgs;};
  tmux = import ./programs/tmux.nix {inherit pkgs catppuccinTheme;};
  nvf = import ./programs/nvf {inherit pkgs catppuccinTheme;};
  starship = import ./programs/starship.nix;
  eza = import ./programs/eza.nix;
  kitty = import ./programs/kitty.nix;
}
