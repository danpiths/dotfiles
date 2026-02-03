{
  pkgs,
  inputs,
  system,
  homeDirectory,
  catppuccinTheme,
  username,
  config,
  ...
}: let
  nerdFonts = pkgs.nerd-fonts;
in {
  environment = {
    systemPackages = with pkgs; [
      vim
      nixd
      nil
      kitty
      utm
    ];
    # get completion for system packages (e.g. systemd)
    pathsToLink = ["/share/zsh"];
    # set terminal vavariables
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
    };
  };

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
    # use determinate systems nix management
    enable = false;
  };

  environment.etc."nix/nix.custom.conf".text = ''
    trusted-users = root dhwanil
  '';

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
    primaryUser = username;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = system;

  # ensures the Nix daemon runs at the system level
  services = {
    nix-daemon.enableSocketListener = true;
  };

  # Define user for home-manager (required on Darwin)
  users.users.${username} = {
    home = homeDirectory;
  };

  # define default styles for all apps using stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-${catppuccinTheme}.yaml";
    fonts = {
      serif = config.stylix.fonts.sansSerif;

      sansSerif = {
        package = nerdFonts.geist-mono;
        name = "GeistMono Nerd Font Mono";
      };

      monospace = {
        package = nerdFonts.geist-mono;
        name = "GeistMono Nerd Font Mono";
      };

      emoji = {
        name = "Apple Color Emoji";
      };
    };
  };
}
