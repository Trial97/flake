{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (lib.modules) mkDefault;
  extensions = inputs.nix-vscode-extensions.extensions.${system};
in
{

  environment.systemPackages = with pkgs; [
    nload

    pciutils
    usbutils

    neovim
    kitty
    input-leap
    git
    xdg-user-dirs
    lxqt.lxqt-powermanagement
    lxqt.lxqt-policykit
    gnome-keyring

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
    # hexchat
    gimp
    thunderbird-bin
    gthumb
    progress
    bat
    man-pages
    man-pages-posix
    ninja
    clang-tools
    qtcreator
    qt6.qttools
    qt6.qtbase
    qt6.qtsvg
    qt6.full

    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = [
        extensions.vscode-marketplace.codezombiech.gitignore
        extensions.vscode-marketplace.golang.go

        extensions.vscode-marketplace.foxundermoon.shell-format
        extensions.vscode-marketplace.pinage404.git-extension-pack
        extensions.vscode-marketplace.llvm-vs-code-extensions.vscode-clangd
        extensions.vscode-marketplace.tonka3000.qtvsctools
        extensions.vscode-marketplace.ryu1kn.partial-diff
        extensions.vscode-marketplace.reduckted.vscode-gitweblinks
        extensions.vscode-marketplace.pinage404.nix-extension-pack
        extensions.vscode-marketplace.cheshirekow.cmake-format
        extensions.vscode-marketplace.dsznajder.es7-react-js-snippets
        extensions.vscode-marketplace.steoates.autoimport
        extensions.vscode-marketplace.esbenp.prettier-vscode
        extensions.vscode-marketplace.ms-toolsai.jupyter-renderers
        extensions.vscode-marketplace.kamadorueda.alejandra
        extensions.vscode-marketplace.formulahendry.auto-complete-tag
        extensions.vscode-marketplace.vadimcn.vscode-lldb
        extensions.vscode-marketplace.stylelint.vscode-stylelint
        extensions.vscode-marketplace.formulahendry.auto-close-tag
        extensions.vscode-marketplace.mhutchie.git-graph
        extensions.vscode-marketplace.formulahendry.auto-rename-tag
        extensions.vscode-marketplace.wmaurer.change-case
        extensions.vscode-marketplace.jnoortheen.nix-ide
        extensions.vscode-marketplace.felipecaputo.git-project-manager
        extensions.vscode-marketplace.tyriar.sort-lines
        extensions.vscode-marketplace.mechatroner.rainbow-csv
        extensions.vscode-marketplace.arrterian.nix-env-selector
        extensions.vscode-marketplace.idleberg.icon-fonts
        extensions.vscode-marketplace.tamasfe.even-better-toml
        extensions.vscode-marketplace.twxs.cmake
        extensions.vscode-marketplace.paragdiwan.gitpatch
        extensions.vscode-marketplace.ms-vscode.cmake-tools
        extensions.vscode-marketplace.zignd.html-css-class-completion
        extensions.vscode-marketplace.sumneko.lua
        extensions.vscode-marketplace.ms-python.python
        extensions.vscode-marketplace.rust-lang.rust-analyzer
        extensions.vscode-marketplace.ms-vscode.cpptools
        extensions.vscode-marketplace.johnnymorganz.stylua
        extensions.vscode-marketplace.ms-toolsai.jupyter
        extensions.vscode-marketplace.eamodio.gitlens
        extensions.vscode-marketplace.mkhl.direnv
        extensions.vscode-marketplace.franneck94.c-cpp-runner
        extensions.vscode-marketplace.donjayamanne.githistory
        extensions.vscode-marketplace.davidanson.vscode-markdownlint
        extensions.vscode-marketplace.editorconfig.editorconfig
        extensions.vscode-marketplace.ms-vscode.makefile-tools
      ];
      # vscodeExtensions = with vscode-extensions;
      #   [
      #     bbenoist.nix
      #     ms-python.python
      #     ms-azuretools.vscode-docker
      #     ms-vscode-remote.remote-ssh
      #   ]
      #   ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      #     {
      #       name = "remote-ssh-edit";
      #       publisher = "ms-vscode-remote";
      #       version = "0.47.2";
      #       sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      #     }
      #   ];
    })
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
    enableNvidia = lib.mkDefault (builtins.elem "nvidia" (config.services.xserver.videoDrivers or [ ]));
    extraPackages = with pkgs; [ podman-compose ];
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
      icons = "auto";

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
    # vscode = {
    #   enable = true;
    #   package = pkgs.vscode.fhsWithPackages (ps: with ps; [rustup zlib openssl.dev pkg-config qt6.full clang gcc]);
    # };
  };

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  xdg.icons.enable = true;
}
