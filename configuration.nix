{
  pkgs,
  stablePkgs,
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
      stablePkgs.kitty
      utm
      raycast
      caddy
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
    extra-substituters = https://nix-community.cachix.org
    extra-trusted-public-keys = nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
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

  # Declarative Homebrew management
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    greedyCasks = true;

    taps = [
      "gromgit/fuse"
      "hashicorp/tap"
      "infisical/get-cli"
      "libsql/sqld"
      "planetscale/tap"
    ];

    brews = [
      "infisical/get-cli/infisical"
      "act"
      "cloud-sql-proxy"
      "cmake"
      "curl"
      "fd"
      "flyctl"
      "gh"
      "git-delta"
      "git-filter-repo"
      "git-who"
      "gnupg"
      "graphviz"
      "htop"
      "librdkafka"
      "lua"
      "mysql-client@8.0"
      "ninja"
      "openjdk"
      "p7zip"
      "pinentry-mac"
      "pipx"
      "pkgconf"
      "python-setuptools"
      "ripgrep"
      "scrcpy"
      "yarn"
      # tapped formulae
      "gromgit/fuse/ntfs-3g-mac"
      "libsql/sqld/sqld"
      "planetscale/tap/pscale"
    ];

    casks = [
      "kindavim"
      "wooshy"
      "scrolla"
      "linear"
      "beekeeper-studio"
      "bentobox"
      "docker-desktop"
      "font-inter"
      "macfuse"
      "mullvad-vpn"
      "nextcloud"
      "ngrok"
      "obs"
      "obsidian"
      "pearcleaner"
      "screen-studio"
      "sf-symbols"
      "ungoogled-chromium"
      "zed"
      "karabiner-elements"
    ];
  };

  # Define user for home-manager (required on Darwin)
  users.users.${username} = {
    home = homeDirectory;
  };

  # Declarative keyboard shortcuts (matches current system state)
  system.defaults.CustomUserPreferences."com.apple.symbolichotkeys" = {
    AppleSymbolicHotKeys = let
      off = {enabled = false;};
      hotkey = params: {
        enabled = true;
        value = {
          parameters = params;
          type = "standard";
        };
      };
      offWith = params: {
        enabled = false;
        value = {
          parameters = params;
          type = "standard";
        };
      };
    in {
      # Keyboard Navigation / Accessibility (all disabled)
      "7" = offWith [65535 120 8650752]; # Move focus to menu bar
      "8" = offWith [65535 99 8650752]; # Move focus to Dock
      "9" = offWith [65535 118 8650752]; # Move focus to active/next window
      "10" = offWith [65535 96 8650752]; # Move focus to window toolbar
      "11" = offWith [65535 97 8650752]; # Move focus to floating window
      "12" = offWith [65535 122 8650752]; # Turn keyboard access on/off
      "13" = offWith [65535 98 8650752]; # Change the way Tab moves focus
      "21" = offWith [56 28 1835008]; # Invert colors
      "25" = offWith [46 47 1835008]; # Increase contrast
      "26" = offWith [44 43 1835008]; # Decrease contrast

      # Screenshots / Input Sources
      "27" = hotkey [101 14 1835008]; # Move focus to window drawer
      "28" = hotkey [52 21 1966080]; # Screenshot area to clipboard
      "29" = hotkey [52 21 1835008]; # Screenshot selected area
      "30" = hotkey [51 20 1966080]; # Screenshot screen to clipboard
      "31" = hotkey [51 20 1835008]; # Screenshot entire screen

      # Mission Control
      "32" = hotkey [65535 126 10223616]; # Mission Control: Ctrl+Opt+Cmd+Up
      "33" = hotkey [65535 125 10223616]; # Application windows: Ctrl+Opt+Cmd+Down
      "34" = hotkey [65535 126 10354688]; # Mission Control (secondary)
      "35" = hotkey [65535 125 10354688]; # Application windows (secondary)

      # Mission Control - Spaces
      "79" = hotkey [65535 123 10223616]; # Move left a space: Ctrl+Opt+Cmd+Left
      "80" = hotkey [65535 123 10354688]; # Move left a space (secondary)
      "81" = hotkey [65535 124 10223616]; # Move right a space: Ctrl+Opt+Cmd+Right
      "82" = hotkey [65535 124 10354688]; # Move right a space (secondary)
      "118" = offWith [65535 18 262144]; # Switch to Desktop 1

      # Input / Spotlight (all disabled)
      "57" = offWith [65535 100 8650752]; # Move focus to status menus
      "59" = offWith [65535 96 9437184]; # Turn Dock hiding on/off
      "60" = offWith [32 49 262144]; # Select previous input source
      "61" = offWith [32 49 786432]; # Select next input source
      "64" = off; # Show Spotlight search
      "65" = off; # Show Finder search window

      # System
      "159" = offWith [65535 36 262144]; # Turn focus following on/off
      "162" = offWith [65535 96 9961472]; # Show Accessibility controls
      "175" = hotkey [65535 97 8388608]; # Do Not Disturb: F6
      "184" = hotkey [53 23 1835008]; # Quick Note
      "190" = offWith [113 12 8388608]; # Show Quick Note (Globe+Q)

      # Accessibility features (all disabled, no shortcut)
      "215" = offWith [65535 65535 0];
      "216" = offWith [65535 65535 0];
      "217" = offWith [65535 65535 0];
      "218" = offWith [65535 65535 0];
      "219" = offWith [65535 65535 0];
      "222" = offWith [65535 65535 0]; # Stage Manager
      "223" = offWith [65535 65535 0]; # Presenter Overlay (Large)
      "224" = offWith [65535 65535 0]; # Presenter Overlay (Small)
      "225" = offWith [65535 65535 0]; # Live Speech
      "226" = offWith [65535 65535 0];
      "227" = offWith [65535 65535 0];
      "228" = offWith [65535 65535 0];
      "229" = offWith [65535 65535 0];
      "230" = offWith [65535 65535 0]; # Speak Selection
      "231" = offWith [65535 65535 0]; # Speak Item Under Pointer
      "232" = offWith [65535 65535 0]; # Typing Feedback

      # Window Management - General
      "233" = offWith [109 46 1048576]; # Minimize
      "235" = offWith [65535 65535 0]; # Zoom
      "237" = hotkey [102 3 8650752]; # Fill: Ctrl+Globe+F
      "238" = offWith [99 8 8650752]; # Center
      "239" = offWith [114 15 8650752]; # Return to Previous Size

      # Window Management - Halves (all disabled)
      "240" = offWith [65535 123 8650752]; # Left Half
      "241" = offWith [65535 124 8650752]; # Right Half
      "242" = offWith [65535 126 8650752]; # Top Half
      "243" = offWith [65535 125 8650752]; # Bottom Half

      # Window Management - Quarters (all disabled, no shortcut)
      "244" = offWith [65535 65535 0]; # Top Left
      "245" = offWith [65535 65535 0]; # Top Right
      "246" = offWith [65535 65535 0]; # Bottom Left
      "247" = offWith [65535 65535 0]; # Bottom Right

      # Window Management - Arrange (all disabled)
      "248" = offWith [65535 123 8781824]; # Left & Right
      "249" = offWith [65535 124 8781824]; # Right & Left
      "250" = offWith [65535 126 8781824]; # Top & Bottom
      "251" = offWith [65535 125 8781824]; # Bottom & Top
      "256" = offWith [65535 65535 0]; # Quarters

      # Window Management - Full Screen Tile (all disabled)
      "257" = offWith [65535 65535 0]; # Tile Left
      "258" = offWith [65535 65535 0]; # Tile Right
      "260" = offWith [65535 53 1048576]; # Exit Full Screen
    };
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

  security.pam.services.sudo_local.touchIdAuth = true;
}
