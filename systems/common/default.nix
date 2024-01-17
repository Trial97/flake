{windowManager, ...}: {
  imports = [
    ./${windowManager}
    ./git.nix
  ];
}
