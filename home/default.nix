{
  config,
  ...
}:
let
  imp =
    if config.services.xserver.windowManager.awesome.enable then
      [
        ./awesome.nix
        ./rofi.nix
        ./autorandr.nix
      ]
    else
      [ ];
in
{
  hm.imports = [
    ./cava.nix
    ./cmus.nix
    ./desktop.nix
    ./gdb.nix
    ./kitty.nix
    ./ranger.nix
    ./shell
    ./wallpapers.nix
  ] ++ imp;
}
