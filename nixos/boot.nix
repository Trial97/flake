{ pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;
  powerManagement.cpuFreqGovernor = "powersave";
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

    # loader = {
    #   grub.enable = false;
    #   systemd-boot.enable = true;
    #   efi.canTouchEfiVariables = true;
    #   efi.efiSysMountPoint = "/boot";
    #   # timeout = 0;
    #   systemd-boot.configurationLimit = 5; # Keep last 5 generations
    # };

    loader.grub = {
      enable = true;
      device = "/dev/vda";
      useOSProber = true;
    };

    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];

    plymouth = {
      enable = true;
      theme = "bgrt";
      font = "${pkgs.fira}/share/fonts/opentype/FiraSans-Regular.otf";
    };
  };
}
