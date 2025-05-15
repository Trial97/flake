{
  inputs,
  pkgs,
  ...
}:
let
  qt5ctThemePath = "${inputs.catppuccin-qt5ct}/themes/Catppuccin-Mocha.conf";
in
{
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  environment.systemPackages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
  ];

  hm = {
    services.gpg-agent.pinentry.package = pkgs.pinentry-qt;

    xdg.configFile = {
      "qt5ct/qt5ct.conf".source = pkgs.replaceVars ./qt5ct.conf {
        themePath = qt5ctThemePath;
      };
      "qt6ct/qt6ct.conf".source = pkgs.replaceVars ./qt6ct.conf {
        themePath = qt5ctThemePath;
      };
    };
  };
}
