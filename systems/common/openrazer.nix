{
  username,
  pkgs,
  ...
}: {
  hardware.openrazer = {
    users = [username];
    enable = true;
  };
  services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [
    polychromatic
  ];
}
