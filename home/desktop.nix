{ lib, pkgs, ... }:
let
  inherit (lib) getExe;
in
{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome-themes-extra;
    size = 1;
    gtk.enable = true;
    # x11.enable = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    font = {
      name = "Fira Sans";
      size = 11;
    };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraCss = builtins.readFile ./adwaita.css;
    gtk4.extraCss = builtins.readFile ./adwaita.css;
  };

  # Stop apps from generating fontconfig caches and breaking reproducibility
  systemd.user.tmpfiles.rules = [ "R %C/fontconfig - - - - -" ];

  home.packages = with pkgs; [
    xdg-user-dirs
    xdg-utils
  ];

  systemd.user.services."lxqt-policykit-agent" = {
    description = "LXQt PolicyKit Agent";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = lib.getExe pkgs.lxqt.lxqt-policykit;
      Slice = [ "background-graphical.slice" ];
    };
  };

  hm.wayland.windowManager.sway.config.floating.criteria = [ { app_id = "lxqt-policykit-agent"; } ];
}
