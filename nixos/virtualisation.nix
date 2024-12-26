{
  pkgs,
  ...
}:
{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      ovmf.packages = [ pkgs.OVMFFull.fd ];
      swtpm.enable = true;
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
