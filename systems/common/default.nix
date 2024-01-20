{windowManager, ...}: {
  imports = [
    ./${windowManager}

    ./bluetooth.nix
    ./boot.nix
    ./environment.nix
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
    ./openrazer.nix
    ./pkgs.nix
    ./pipewire
    ./qt
    ./regional.nix
    # ./transmission.nix
    ./v4l2loopback.nix
  ];
}
