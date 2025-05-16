{
  inputs,
  ...
}:
{
  xdg.configFile."wallpaper" = {
    source = inputs.wallpaper;
    recursive = true;
  };
}
