{
  pkgs,
  ...
}:
{
  virtualisation = {
    libvirtd = {
      enable = true;

      qemu = {
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
    diskSize = 10 * 1024;
  };
  virtualisation.vmVariant = {
    services.xserver.enable = false;

    virtualisation = {
      diskSize = 10 * 1024;
      sharedDirectories = {
        my-share = {
          target = "/mnt/flake";
          source = "/home/trial/Projects/nix2/";
        };
      };
    };
  };

}
