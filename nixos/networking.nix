_: {
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        24800 # input-leap
        # 51413
      ];
      allowedUDPPorts = [
        # 51413
      ];
    };
  };
}
