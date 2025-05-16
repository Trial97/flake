{ config, ... }:
{
  programs.gnupg.agent.enable = true;
  hm = {
    programs.git.signing = {
      signByDefault = true;
      key = "55EF5DA53DB36318";
    };

    programs.gpg = {
      enable = true;
      homedir = "${config.hm.xdg.dataHome}/.gnupg";
    };
  };
}
