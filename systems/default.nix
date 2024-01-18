{inputs, ...}: let
  inherit (inputs) nixos-hardware nixpkgs;

  inherit (nixpkgs.lib) attrValues;

  mkHost = {
    hostName,
    system,
    modules,
    overlays ? [],
  }: {
    ${hostName} = nixpkgs.lib.nixosSystem {
      inherit system;

      modules =
        [
          {
            nixpkgs = {inherit overlays;};

            networking.hostName = hostName;
          }

          ./common
          ./${hostName}
          ../home
        ]
        # ++ (attrValues scrumpkgs.nixosModules)
        ++ modules;

      specialArgs = {
        inherit inputs;
        # lib' = scrumpkgs.lib;
        windowManager = "awesome";
        username = "trial";
      };
    };
  };
in {
  flake.nixosConfigurations = mkHost {
    system = "x86_64-linux";
    hostName = "clockwork";
    modules = [nixos-hardware.nixosModules.msi-gl62];
  };
}
