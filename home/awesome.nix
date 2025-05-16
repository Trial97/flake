{
  pkgs,
  home,
  ...
}:
{
  xdg.configFile."awesome" = {
    source = pkgs.fetchgit {
      url = "https://github.com/Trial97/awesomerc.git";
      fetchSubmodules = true;
      hash = "sha256-2AVdIilvLag5LHrFNpWh5Kt5il2xmqek/CLth2JCwF4";
    };
    recursive = true;
  };
  home.file.".local/bin/lock" = {
    source = ../dotfiles/bin/lock;
    executable = true;
  };

  home.file.".local/bin/snap" = {
    source = ../dotfiles/bin/snap;
    executable = true;
  };
  xdg.configFile."autostart".source = ../dotfiles/autostart;
}
