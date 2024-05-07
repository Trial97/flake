{inputs, ...}: let
  inherit (inputs) nixos-hardware nixpkgs prismlauncher;

  inherit (nixpkgs.lib) attrValues;

  hostName = "clockwork";
  username = "trial";
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      {
        nixpkgs = {overlays = [prismlauncher.overlays.default];};

        networking.hostName = hostName;
      }
      # nixos-hardware.nixosModules.msi-gl62

      ./original/configuration.nix

      ./bluetooth.nix
      ./boot.nix
      ./environment.nix
      ./fonts.nix
      ./git.nix
      ./home.nix
      ./networking.nix
      ./nix.nix
      ./regional.nix
    ];

    specialArgs = {
      inherit inputs;
      inherit system;
      inherit hostName;
      inherit username;
    };
  };
}
