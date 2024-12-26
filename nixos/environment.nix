{
  pkgs,
  ...
}:
{
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    EDITOR = "nvim";
    TERMINAL = "kitty";
    BROWSER = "firefox";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };
  environment.localBinInPath = true;
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
