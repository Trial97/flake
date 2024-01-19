_: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        # 22000 # syncthing
        # 25565 # minecraft
        24800 # input-leap
      ];
      allowedUDPPorts = [
        # 21027 # syncthing
        # 22000 # syncthing
        # 25565 # minecraft
      ];
    };
  };
}
