{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}: let
  inherit (pkgs) fetchgit;
  inherit (builtins) attrValues;
  inherit (lib.lists) optional;
  inherit (lib.modules) mkAliasOptionModule;

  inherit (inputs) home-manager;
in {
  imports = [
    (mkAliasOptionModule ["hm"] ["home-manager" "users" username])
    (mkAliasOptionModule ["primaryUser"] ["users" "users" username])

    home-manager.nixosModules.home-manager
  ];

  config = {
    primaryUser = {
      isNormalUser = true;
      # TODO: roles!
      extraGroups =
        ["wheel" "audio" "video" "input" "dialout"]
        ++ optional config.networking.networkmanager.enable "networkmanager"
        ++ optional config.programs.adb.enable "adbusers"
        ++ optional config.programs.wireshark.enable "wireshark"
        ++ optional config.virtualisation.libvirtd.enable "libvirtd"
        ++ optional config.virtualisation.podman.enable "podman";
    };
    nix.settings.trusted-users = [username];

    home-manager.users.${username} = {
      # home.homeDirectory = config.users.users."${username}".home;
      home.username = username;

      # programs.home-manager.enable = true;
      programs.bash.enable = true;

      home.stateVersion = config.system.stateVersion;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}