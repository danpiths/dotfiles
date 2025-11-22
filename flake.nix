{
  description = "Nix system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      darwin,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      system = "aarch64-darwin";
      hostName = "Dhwanils-MacBook-Pro";
      username = "dhwanil";
      stateVersion = "25.05"; # See https://nixos.org/manual/nixpkgs/stable for most recent
      catppuccinTheme = "mocha";
      allowedUnfreeSoftware = [
        "graphite-cli"
      ];

      # TEMPORARY (done to skip failing fish build via direnv)
      overlays = [
        (final: prev: {
          fish = prev.fish.overrideAttrs (old: {
            doCheck = false; # skip the failing test suite
          });
        })
      ];

      pkgs = import nixpkgs {
        inherit system overlays;
        config = {
          # ONLY allow the packages in `allowedUnfree`
          allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) allowedUnfreeSoftware;
        };
      };

      homeDirPrefix = if pkgs.stdenv.hostPlatform.isDarwin then "/Users" else "/home";
      homeDirectory = "${homeDirPrefix}/${username}";

      systemVariables = {
        inherit
          system
          hostName
          username
          stateVersion
          pkgs
          homeDirPrefix
          homeDirectory
          catppuccinTheme
          ;
      };
    in
    {

      # Build darwin flake using:
      # $ sudo darwin-rebuild build --flake .
      darwinConfigurations.${hostName} = darwin.lib.darwinSystem {
        modules = [
          stylix.darwinModules.stylix
          {
            options.stylix.icons = nixpkgs.lib.mkOption {
              type = nixpkgs.lib.types.nullOr nixpkgs.lib.types.attrs;
              default = { };
              description = "Dummy Stylix icons option to satisfy modules that expect it (needed for darwin stylix).";
            };
          }

          ./configuration.nix

          # home-manager config
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "pre-nix-backup";

            home-manager.extraSpecialArgs = {
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

        specialArgs = {
          inherit inputs;
        }
        // systemVariables;
      };
    };
}
