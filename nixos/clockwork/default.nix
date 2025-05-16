# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  ...
}:
# { inputs, ... }:
# let inherit (inputs) nixos-hardware;in
{
  # Include the results of the hardware scan.
  imports = [
    ./hardware-configuration.nix
    # nixos-hardware.nixosModules.msi-gl62
  ];

  hardware.enableRedistributableFirmware = true;
  powerManagement.cpuFreqGovernor = "powersave";
  networking.hostName = "clockwork"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # fileSystems."/mnt/Computer2" = {
  #   device = "/dev/sda1";
  #   fsType = "ntfs3";
  # };

  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  };

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
    xserver.enable = true;
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=10m
  '';

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      ovmf.packages = [ pkgs.OVMFFull.fd ];
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.displayManager.startx.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.xfce.enable = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.fstrim.enable = true;

  environment.localBinInPath = true;
}
