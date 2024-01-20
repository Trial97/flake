{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkDefault;
in {
  nixpkgs = {
    config.allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    nload

    pciutils
    usbutils

    neovim
    vscode
    kitty
    input-leap
    git
    xdg-user-dirs
    lxqt.lxqt-powermanagement
    lxqt.lxqt-policykit
    gnome.gnome-keyring

    clipman
    vlc
    sublime-merge
    firefox

    # this are specific for x server
    rofi
    maim # screenshot
    numlockx
    caffeine-ng
    arandr
    dex

    meld

    fd
    file
    libqalculate
    parallel
    ripgrep
    tree
    just

    dig
    ffmpeg
    psmisc
    unzip

    lsof
    ntfs3g
    playerctl
    papirus-icon-theme

    cmus
    gdb
    polychromatic

    mpv
    vlc
    unrar
    unzip

    yt-dlp
    mediainfo
    atool
    fzf
    highlight
    moreutils
    mpd
    mpc-cli
    fd
    most
    jq
    ripgrep
    ripgrep-all
    thunderbird-bin
    transmission-qt
    hexchat
    gimp
    gthumb
    progress
    bat
    man-pages
    man-pages-posix
    ninja
  ];

  services = {
    openssh.enable = true;
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
  };

  virtualisation.podman = {
    enable = mkDefault true;
    dockerSocket.enable = true;
    enableNvidia = lib.mkDefault (builtins.elem "nvidia" (config.services.xserver.videoDrivers or []));
    extraPackages = with pkgs; [podman-compose];
    autoPrune.enable = true;
  };

  programs = {
    adb.enable = true;
    mtr.enable = true;
    bandwhich.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    partition-manager.enable = true;

    dconf.enable = true;
    ccache.enable = true;
  };
  hm.programs = {
    eza = {
      enable = true;
      icons = true;

      extraOptions = [
        "--group"
        "--smart-group"
      ];
    };
    fzf = {
      enable = true;
      enableFishIntegration = false; # we use jethrokuan/fzf instead
      defaultOptions = [
        "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD"
      ];
    };
  };

  security.sudo.extraRules = [
    {
      groups = ["wheel"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
        {
          command = "/run/current-system/sw/bin/systemctl";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
  xdg.icons.enable = true;
}
