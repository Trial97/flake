{
  lib,
  pkgs,
  ...
}:
{
  catppuccin.fish.enable = true;
  programs.fish = {
    enable = true;

    shellInit = ''
      set -g theme_color_scheme "catppuccin"
      set -g theme_nerd_fonts "yes"
      set -g theme_title_display_process "yes"
    '';

    shellAliases = lib.mkMerge [
      {
        ip = "ip --color=auto";
        ll = "ls --long --all --classify";
        ls = "eza"; # note: we rely on the alias created by eza
      }
    ];

    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair.fish";
        inherit (autopair-fish) src;
      }
      {
        name = "bobthefisher";
        inherit (bobthefisher) src;
      }
      {
        name = "fzf";
        inherit (fzf) src;
      }
      {
        name = "humantime.fish";
        inherit (humantime-fish) src;
      }
      {
        name = "puffer";
        inherit (puffer) src;
      }
      {
        name = "z";
        inherit (z) src;
      }
    ];

    functions = {
      systemctl = ''
        if contains -- --user $argv
            command systemctl $argv
        else
            sudo systemctl $argv
        end
      '';
      last_history_item.body = "echo $history[1]";
    };

    shellAbbrs = {
      nixgc = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
    };
  };
}
