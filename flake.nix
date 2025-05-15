{
  description = "A very basic flake nixos configuration";

  outputs =
    inputs@{
      self,
      nixpkgs,
      git-hooks-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = lib.genAttrs systems;
      nixpkgsFor = nixpkgs.legacyPackages;

      forAllPkgs =
        f:
        forAllSystems (
          system:
          f {
            inherit system;
            pkgs = nixpkgsFor.${system};
          }
        );

      mkHost =
        {
          hostName,
          system,
          username,
        }:
        {
          ${hostName} = lib.nixosSystem {
            inherit system;
            modules = [
              {
                networking = { inherit hostName; };
                system.stateVersion = "25.05";
                nixpkgs.config.allowUnfree = true;
              }
              ./nixos
              ./home
            ];
            specialArgs = {
              inherit inputs;
              inherit hostName;
              inherit system;
              inherit username;
            };
          };
        };
    in
    {
      formatter = forAllPkgs ({ pkgs, ... }: pkgs.nixfmt-rfc-style);

      devShells = forAllPkgs (
        { pkgs, system }:
        {
          default = pkgs.mkShell {
            inherit (self.checks.${system}.pre-commit-check) shellHook;
            buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
            packages = with pkgs; [
              # For CI
              actionlint

              # Nix tools
              nil
              statix
              self.formatter.${system}

              fzf
              just
              git
            ];
          };
        }
      );

      checks = forAllPkgs (
        { system, pkgs }:
        let
          mkCheck =
            {
              name,
              deps ? [ ],
              script,
            }:
            pkgs.runCommand name { nativeBuildInputs = deps; } ''
              ${script}
              touch $out
            '';
        in
        {
          pre-commit-check = git-hooks-nix.lib.${system}.run {
            src = ./.;
            hooks = {
              nixfmt-rfc-style.enable = true;
              nil.enable = true;
              prettier = {
                enable = true;
                excludes = [
                  "flake.lock"
                  ".+.frag"
                ];
              };
              actionlint.enable = true;
              statix.enable = true;
              deadnix.enable = true;
              typos.enable = true;
              markdownlint.enable = true;
            };
          };
          # actionlint = mkCheck {
          #   name = "check-actionlint";
          #   deps = [pkgs.actionlint];
          #   script = "actionlint ${self}/.github/workflows/**";
          # };

          deadnix = mkCheck {
            name = "check-deadnix";
            deps = [ pkgs.deadnix ];
            script = "deadnix --fail ${self}";
          };

          flake-inputs = mkCheck {
            name = "check-flake-inputs";
            script = ''
              if grep '_2' ${self}/flake.lock &>/dev/null; then
                echo "FOUND DUPLICATE FLAKE INPUTS!!!!"
                exit 1
              fi
            '';
          };

          just = mkCheck {
            name = "check-just";
            deps = [ pkgs.just ];
            script = ''
              cd ${self}
              just --check --fmt --unstable
              just --summary
            '';
          };

          nixfmt = mkCheck {
            name = "check-nixfmt";
            deps = [ pkgs.nixfmt-rfc-style ];
            script = "nixfmt --check ${self}/**/*.nix ${self}/*.nix";
          };

          statix = mkCheck {
            name = "check-statix";
            deps = [ pkgs.statix ];
            script = "statix check ${self}";
          };
        }
      );

      nixosConfigurations = mkHost {
        hostName = "clockwork";
        system = "x86_64-linux";
        username = "trial";
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-qt5ct = {
      url = "github:catppuccin/qt5ct";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        gitignore.follows = "gitignore";
      };
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpaper = {
      url = "github:Trial97/wallpapers?submodules=1";
      flake = false;
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
  };

}
