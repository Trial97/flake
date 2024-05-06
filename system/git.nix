{ pkgs
, config
, ...
}: {
  programs.gnupg.agent.enable = true;

  hm = {
    home.packages = with pkgs; [ git-extras ];

    programs = {
      fish.shellAbbrs = {
        g = "git";
        ga = "git add";
        gap = "git add -p";
        gca = "git commit -s --amend";
        gcm = "git commit -sm";
        gco = "git checkout";
        gd = "git diff";
        gdc = "git diff --cached";
        gl = "git log";
        gp = "git push";
        gpl = "git pull";
        gri = "git rebase --interactive";
        grc = "git rebase --continue";
        gs = "git status";
      };

      gh = {
        enable = true;
        settings.git_protocol = "ssh";
      };

      git = {
        enable = true;
        package = pkgs.gitAndTools.gitFull;

        userName = "Trial97";
        userEmail = "alexandru.tripon97@gmail.com";

        delta = {
          enable = true;
          options.navigate = true;
        };

        extraConfig = {
          core.autocrlf = "input";
          color.ui = "auto";
          diff.colorMoved = "default";
          push.followTags = true;
          pull.rebase = false;
          init.defaultBranch = "master";
          url = {
            "https://github.com/".insteadOf = "github:";
            "ssh://git@github.com/".pushInsteadOf = "github:";
            "https://gitlab.com/".insteadOf = "gitlab:";
            "ssh://git@gitlab.com/".pushInsteadOf = "gitlab:";
            "https://aur.archlinux.org/".insteadOf = "aur:";
            "ssh://aur@aur.archlinux.org/".pushInsteadOf = "aur:";
            "https://git.sr.ht/".insteadOf = "srht:";
            "ssh://git@git.sr.ht/".pushInsteadOf = "srht:";
            "https://codeberg.org/".insteadOf = "codeberg:";
            "ssh://git@codeberg.org/".pushInsteadOf = "codeberg:";
          };

          # Replace the default set by programs.git.signing.signByDefault
          tag.gpgSign = false;
        };

        signing = {
          signByDefault = true;
          key = "55EF5DA53DB36318";
        };
      };

      eza.git = true;

      gpg = {
        enable = true;
        homedir = "${config.hm.xdg.dataHome}/.gnupg";
      };
    };
  };
}
