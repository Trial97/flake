{
  lib,
  pkgs,
  ...
}:
{

  security.pam.services.swaylock = { };

  environment.systemPackages = with pkgs; [
    swaylock
  ];

  hm = {
    catppuccin.swaylock = {
      enable = true;
      flavor = "mocha";
    };
    services.swayidle.events = [
      {
        event = "lock";
        command = ''${lib.getExe pkgs.swaylock} --daemonize'';
      }
    ];
  };
}
