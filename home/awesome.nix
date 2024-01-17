{
  pkgs,
  home,
  ...
}: {
  xdg.configFile."awesome" = {
    source = pkgs.fetchgit {
      url = "https://github.com/Trial97/awesomerc.git";
      fetchSubmodules = true;
      hash = "sha256-VMuivU2jk23nDLiXGh6o11s74nfJ5MoiN7oZDeldYzA=";
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
