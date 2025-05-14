{
  config,
  lib,
  pkgs,
  ...
}:
{

  security.pam.services.swaylock = { };
  hm = {
    programs.swaylock.enable = true;
    catppuccin.swaylock = {
      enable = true;
      flavor = "mocha";
    };
    services.swayidle.events = [
      {
        event = "lock";
        command = ''${lib.getExe config.hm.programs.swaylock.package} --daemonize'';
      }
    ];
  };
}
