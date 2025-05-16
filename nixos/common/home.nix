{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib.lists) optional;
  inherit (lib.modules) mkAliasOptionModule;

  inherit (inputs) catppuccin home-manager;
in
{
  imports = [
    (mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
    (mkAliasOptionModule [ "primaryUser" ] [ "users" "users" username ])

    home-manager.nixosModules.home-manager
    catppuccin.nixosModules.catppuccin
  ];

  config = {
    programs.fish.enable = true;
    primaryUser = {
      initialHashedPassword = "$y$j9T$r4a/KZR9CrFFZ2mLAiZoM1$DZ/bbC43dYoaUHlHeORcd3LBqcL7dgLmpz92hAjQ50.";
      isNormalUser = true;
      # TODO: roles!
      extraGroups =
        [
          "wheel"
          "audio"
          "video"
          "input"
          "dialout"
        ]
        ++ optional config.networking.networkmanager.enable "networkmanager"
        ++ optional config.programs.adb.enable "adbusers"
        ++ optional config.programs.wireshark.enable "wireshark"
        ++ optional config.virtualisation.libvirtd.enable "libvirtd"
        ++ optional config.virtualisation.podman.enable "podman";
      shell = pkgs.fish;
    };
    nix.settings.trusted-users = [ username ];

    hm = {
      home = {
        homeDirectory = config.users.users."${username}".home;
        inherit username;
        inherit (config.system) stateVersion;
      };

      programs.home-manager.enable = true;
      systemd.user.startServices = "sd-switch";

      catppuccin.flavor = mkDefault "mocha";
      catppuccin.enable = true;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs; };
      sharedModules = [
        catppuccin.homeModules.catppuccin
      ];
      backupFileExtension = "backup";
    };
  };
}
