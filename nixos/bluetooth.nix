_: {
  hardware.bluetooth.enable = true;

  services.blueman.enable = true;
  hm.services.blueman-applet.enable = true;
  hm.systemd.user.services."blueman-applet" = {
    Unit.After = [ "graphical-session.target" ];
    Service.Slice = [ "background-graphical.slice" ];
  };
}
