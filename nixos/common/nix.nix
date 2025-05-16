{
  inputs,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;
  channelPath = "/etc/nix/channels/nixpkgs";
in
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "no-url-literals"
        "auto-allocate-uids"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
    };
    nixPath = [
      "nixpkgs=${channelPath}"
    ];
    registry.n.flake = inputs.nixpkgs;
  };
  security = {
    # apparmor.enable = mkDefault true;
    # audit.enable = mkDefault true;
    # auditd.enable = mkDefault true;
    polkit.enable = mkDefault true;
    rtkit.enable = mkDefault true;
    sudo.execWheelOnly = true;
  };
  primaryUser.extraGroups = [ "rtkit" ];

  systemd.tmpfiles.rules = [
    "L+ ${channelPath}     - - - - ${inputs.nixpkgs.outPath}"
  ];
}
