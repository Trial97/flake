{
  inputs,
  lib,
  pkgs,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      (_: _: {
        awesome = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-luajit-git;
        picom = inputs.nixpkgs-f2k.packages.${pkgs.system}.picom-git;
      })
    ];
  };

  environment = {
    systemPackages =
      lib.attrValues {
        inherit
          (pkgs)
          brightnessctl
          inotify-tools
          libnotify
          pavucontrol
          skippy-xd
          pa_applet
          upower
          redshift
          ;
      }
      ++ (with pkgs; [
        xorg.xwininfo
      ]);
  };

  programs = {
    nm-applet = {
      enable = true;
      indicator = false;
    };

    thunar = {
      enable = true;

      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };

    i3lock = {
      enable = true;
      package = pkgs.i3lock-color;
    };
  };

  security.pam.services.lightdm.enableGnomeKeyring = true;

  services = {
    tumbler.enable = true;
    upower.enable = true;

    xserver = {
      enable = true;

      displayManager = {
        defaultSession = "none+awesome";

        lightdm = {
          enable = true;
          greeters.gtk.enable = true;
        };
        # setupCommands = "numlockx on || true";
      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = lib.attrValues {
            inherit (pkgs.luajitPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };
    autorandr.enable = true;
    picom.enable = true;
  };
  systemd.services.numLockOnTty = {
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      # /run/current-system/sw/bin/setleds -D +num < "$tty";
      ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
        for tty in /dev/tty{1..6}; do
            ${pkgs.kbd}/bin/setleds -D +num < "$tty";
        done
      '');
    };
  };

  systemd.services."screen_lock@.service" = {
    description = "Autolock screen before sleep, hibernate and hybrid-sleep";
    before = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target"];
    wantedBy = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target"];
    serviceConfig = {
      User = "%i";
      Type = "forking";
      Environment = "DISPLAY=:0";
      ExecStart = "/home/%i/.local/bin/lock";
      ExecStartPost = "/bin/sleep 1";
    };
  };
}
