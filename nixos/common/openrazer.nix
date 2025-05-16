{
  username,
  pkgs,
  ...
}:
{
  hardware.openrazer = {
    users = [ username ];
    enable = true;
  };
  services.hardware.openrgb.enable = false;

  environment.systemPackages = with pkgs; [
    polychromatic
  ];
}
