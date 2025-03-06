{ pkgs, ... }:
{
  hardware.enableRedistributableFirmware = true;
  powerManagement.cpuFreqGovernor = "powersave";
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

    # loader = {
    #   systemd-boot.enable = true;
    #   efi.canTouchEfiVariables = true;
    #   timeout = 0;
    # };
    loader.grub.enable = true;
    loader.grub.device = "/dev/vda";
    loader.grub.useOSProber = true;


    # tmp = {
    #   useTmpfs = true;
    #   tmpfsSize = "75%";
    # };
    initrd.verbose = false;
    initrd.systemd.enable = true;
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
