{windowManager, ...}: {
  imports = [
    ./${windowManager}

    ./bluetooth.nix
    ./boot.nix
    ./git.nix
    ./htop.nix
    ./regional.nix
  ];
}
