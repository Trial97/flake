_: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        24800 # input-leap
        22
        # 51413
      ];
      allowedUDPPorts = [
        # 51413
      ];
    };
  };
}
