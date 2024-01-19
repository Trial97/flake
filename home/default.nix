{
  inputs,
  config,
  lib,
  ...
}: let
  inherit (inputs.nixpkgs.lib) attrValues;
  imp =
    if config.services.xserver.windowManager.awesome.enable
    then [
      ./awesome.nix
      ./rofi.nix
      ./autorandr.nix
      ./picom.nix
    ]
    else [];
in {
  hm.imports =
    [
      ./cava.nix
      ./cmus.nix
      ./desktop.nix
      ./gdb.nix
      ./kitty.nix
      ./ranger.nix
      ./wallpapers.nix
    ]
    ++ imp;
}
