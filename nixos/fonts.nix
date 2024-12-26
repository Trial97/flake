{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      fira
      monocraft
      fira-code
      roboto
      corefonts
      fira-code
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-cjk-sans
    ];

    enableDefaultPackages = true;

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    fontconfig = {
      enable = true;
      cache32Bit = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Fira Sans" ];
        # sansSerif = ["Noto Sans"];
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Fira Code" ];
      };
    };
  };
}
