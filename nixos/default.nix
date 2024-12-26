{
  hostName,
  ...
}:
{
  imports = [
    ./${hostName}
    ./boot.nix
    ./home.nix

    ./qt

    ./bluetooth.nix
    ./environment.nix
    ./firefox.nix
    ./fonts.nix
    ./gaming.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./networking.nix
    ./nix.nix
    ./nvd.nix
    ./openrazer.nix
    ./pipewire.nix
    ./pkgs.nix
    ./regional.nix
    ./transmission.nix
    ./v4l2loopback.nix
    ./virtualisation.nix
  ];
  nixpkgs.config.allowUnfree = true;
}
