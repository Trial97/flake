{ hostName, ... }: {
  imports = [
    ./${hostName}
    ./boot.nix
    ./home.nix

    ./qt

    ./descktopManager.nix

    # ./bluetooth.nix
    ./environment.nix
    # ./firefox.nix
    ./fonts.nix
    # ./gaming.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./networking.nix
    ./nix.nix
    ./nvd.nix
    # ./openrazer.nix
    # ./pipewire.nix
    ./pkgs.nix
    ./regional.nix
    ./sway.nix
    # ./transmission.nix
    ./v4l2loopback.nix
    ./virtualisation.nix
  ];
  nixpkgs.config.allowUnfree = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers =
        null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      PermitRootLogin =
        "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
}
