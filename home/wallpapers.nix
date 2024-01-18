{
  pkgs,
  home,
  ...
}: {
  xdg.configFile."wallpaper" = {
    source = pkgs.fetchgit {
      url = "https://github.com/Trial97/wallpapers.git";
      fetchSubmodules = true;
      hash = "sha256-Ejv4qer9aXfOsY/eypQfmdtdMK519BodsPSggRzmvk4=";
    };
    recursive = true;
  };
}
