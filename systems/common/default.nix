{windowManager, ...}: {
  imports = [
    ./${windowManager}

    ./bluetooth.nix
    ./boot.nix
    ./git.nix
    ./gpg.nix
    ./home.nix
    ./htop.nix
    ./networking.nix
    ./nix.nix
    ./nvd.nix
    ./pkgs.nix
    ./regional.nix
    ./v4l2loopback.nix
  ];
}
