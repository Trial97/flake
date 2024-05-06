{
  description = "A very basic flake nixos configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    # nixpkgs-f2k.url = "github:moni-dz/nixpkgs-f2k";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:Stonks3141/ctp-nix";
    catppuccin-qt5ct = {
      url = "github:catppuccin/qt5ct";
      flake = false;
    };

    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pre-commit-hooks.follows = "pre-commit-hooks";
    };

    # nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.pre-commit-hooks.flakeModule
        ./system
        ./dev.nix
      ];

      systems = [ "x86_64-linux" ];
    };
}
