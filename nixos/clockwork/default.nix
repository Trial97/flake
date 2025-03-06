{ inputs, ... }:
let inherit (inputs) nixos-hardware;
in {
  imports = [
    ./hardware-configuration.nix
    # nixos-hardware.nixosModules.msi-gl62
  ];
  # fileSystems."/mnt/Computer2" = {
  #   device = "/dev/sda1";
  #   fsType = "ntfs3";
  # };

  services = {
    fwupd.enable = true;
    logind = {
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        PowerKeyIgnoreInhibited=yes
        LidSwitchIgnoreInhibited=no
      '';
    };
    # Enable the X11 windowing system.
    # xserver.enable = true;
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
  '';
  services.fstrim.enable = true;
}
