{
  config,
  pkgs,
  username,
  ...
}: {
  services.transmission = {
    enable = true;
    package = pkgs.transmission-qt;
    openPeerPorts = true;
    settings = {
      peer-port-random-on-start = true;
      watch-dir-enabled = true;
      watch-dir = "${config.users.users."${username}".home}/Downloads";
      download-dir = "/mnt/Computer2/Torrents/";
      trash-original-torrent-files = true;
      start-minimized = true;
      show-statusbar = true;
    };
  };
}
