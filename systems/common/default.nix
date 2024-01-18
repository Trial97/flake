{windowManager, ...}: {
  imports = [
    ./${windowManager}

    ./bluetooth.nix
    ./boot.nix
    ./firefox.nix
    ./fonts.nix
    ./gaming.nix
    ./git.nix
    ./gpg.nix
    ./home.nix
    ./htop.nix
    ./networking.nix
    ./nix.nix
    ./nvd.nix
    ./pkgs.nix
    ./qt
    ./regional.nix
    ./v4l2loopback.nix
  ];
}
