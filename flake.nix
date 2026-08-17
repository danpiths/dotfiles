{
  description = "Nix system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    forgecode-bin = {
      url = "file+https://github.com/tailcallhq/forgecode/releases/download/v2.13.21/forge-aarch64-apple-darwin";
      flake = false;
    };
  };

  outputs = inputs @ {
    darwin,
    nixpkgs,
    nur,
    nixpkgs-stable,
    home-manager,
    stylix,
    ...
  }: let
    system = "aarch64-darwin";
    username = import ./files/config/username.nix;
    hostName = import ./files/config/hostname.nix;
    stateVersion = "25.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent
    catppuccinTheme = import ./files/config/theme.nix;
    allowedUnfreeSoftware = [
      "notion-app"
      "graphite-cli-unwrapped"
      "claude-code"
      "raycast"
      "datagrip"
      "orbstack"
    ];

    pkgs = import nixpkgs {
      inherit system;

      config = {
        # ONLY allow the packages in `allowedUnfree`
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) allowedUnfreeSoftware;
      };
    };

    stablePkgs = import nixpkgs-stable {
      inherit system;

      config = {
        allowUnfreePredicate = pkg: builtins.elem (nixpkgs-stable.lib.getName pkg) allowedUnfreeSoftware;
      };
    };

    nurPkgs = import nur {
      inherit system;

      config = {
        allowUnfreePredicate = pkg: builtins.elem (nur.lib.getName pkg) allowedUnfreeSoftware;
      };
    };

    homeDirPrefix =
      if pkgs.stdenv.hostPlatform.isDarwin
      then "/Users"
      else "/home";
    homeDirectory = "${homeDirPrefix}/${username}";

    systemVariables = {
      inherit
        system
        hostName
        username
        stateVersion
        pkgs
        stablePkgs
        nurPkgs
        homeDirPrefix
        homeDirectory
        catppuccinTheme
        ;
    };
  in {
    # Build darwin flake using:
    # $ sudo darwin-rebuild build --flake .
    darwinConfigurations.${hostName} = darwin.lib.darwinSystem {
      modules = [
        # Adds the NUR overlay
        nur.modules.darwin.default

        stylix.darwinModules.stylix
        {
          options.stylix.icons = nixpkgs.lib.mkOption {
            type = nixpkgs.lib.types.nullOr nixpkgs.lib.types.attrs;
            default = {};
            description = "Dummy Stylix icons option to satisfy modules that expect it (needed for darwin stylix).";
          };
        }

        ./configuration.nix

        # home-manager config
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "pre-nix-backup";
          };

          home-manager.extraSpecialArgs =
            {
              inherit inputs;
            }
            // systemVariables;

          home-manager.users = {
            ${username} = ./home;
          };

          # shared stylix modules
          home-manager.sharedModules = [
            {
              stylix.targets = {
                tmux.enable = false;
                nvf.enable = false;
              };
            }
          ];
        }
      ];

      specialArgs =
        {
          inherit inputs;
        }
        // systemVariables;
    };
  };
}
