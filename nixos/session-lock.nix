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

  hm.services.swayidle.events = [
    {
      event = "lock";
      command = ''${lib.getExe pkgs.swaylock} --inside-ver-color ffffff22 --ring-ver-color bb00bbbb --inside-wrong-color ffffff22 --ring-wrong-color 880000bb --inside-color 00000000 --ring-color ff00ffcc --line-color 00000000 --separator-color ff00ffcc --text-color ee00eeee --text-clear-color ee00eeee --text-caps-lock-color ee00eeee --text-ver-color ee00eeee --text-wrong-color ee00eeee --effect-blur 5x5 --clock --timestr "%H:%M:%S" --datestr "%A, %m %Y" --font-size 20 --indicator-radius 100 --screenshots --daemonize'';
    }
  ];
}
