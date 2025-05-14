{ hostName, ... }:
{
  imports = [
    ./${hostName}
    ./boot.nix
    ./home.nix

    ./qt

    ./displayManager.nix

    ./bluetooth.nix
    ./environment.nix
    ./firefox.nix
    ./fonts.nix
    ./fuzzel.nix
    # ./gaming.nix
    ./git.nix
    ./gpg.nix
    ./htop.nix
    ./inhibridge.nix
    ./networking.nix
    ./nix.nix
    ./nvd.nix
    # ./openrazer.nix
    ./pipewire.nix
    ./pkgs.nix
    ./regional.nix
    ./session-lock.nix
    ./sway.nix
    ./swayidle.nix
    ./v4l2loopback.nix
    ./virtualisation.nix
    ./wlogout.nix

    ./image-viewer.nix
    ./mako.nix
    ./poweralertd.nix
    ./screenshot-bash.nix
    ./waybar.nix
    ./wlsunset.nix
    ./wob.nix

  ];
  nixpkgs.config.allowUnfree = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
}
