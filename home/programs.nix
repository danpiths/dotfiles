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

  fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  zsh = import ./programs/zsh.nix {inherit homeDirectory pkgs;};
  tmux = import ./programs/tmux.nix {inherit pkgs catppuccinTheme;};
  nvf = import ./programs/nvf {inherit pkgs catppuccinTheme;};
  starship = import ./programs/starship.nix;
  eza = import ./programs/eza.nix;
  kitty = import ./programs/kitty.nix;
}
