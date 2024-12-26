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
