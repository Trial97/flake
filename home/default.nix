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
      ./kitty.nix
    ]
    ++ imp;
}
