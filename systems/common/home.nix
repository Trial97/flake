{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}: let
  inherit (lib.lists) optional;
  inherit (lib.modules) mkAliasOptionModule;

  inherit (inputs) catppuccin home-manager;
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
      shell = pkgs.zsh;
    };
    nix.settings.trusted-users = [username];

    hm = {
      home.homeDirectory = config.users.users."${username}".home;
      home.username = username;

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";

      home.stateVersion = config.system.stateVersion;
      catppuccin.flavour = "mocha";
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      sharedModules = [
        catppuccin.homeManagerModules.catppuccin
      ];
    };
  };
}
