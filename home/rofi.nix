{ pkgs, ... }:
{
  xdg.configFile."rofi2".source = ../dotfiles/rofi2;
  xdg.configFile."rofi" = {
    source =
      pkgs.fetchgit {
        url = "https://github.com/niraj998/Rofi-Scripts.git";
        hash = "sha256-QtpmbwtJyunTHj7WPi+H7nUN8bdczwJflo3i5oihhLM=";
      }
      + "/rofi";
    recursive = true;
  };
}
