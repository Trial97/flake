{pkgs, ...}: {
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # hm.services.pipewire = {
  #   enable = true;
  #   instances = {
  #     compressor = {
  #       config = ./compressor.conf;
  #       extraPackages = [pkgs.calf];
  #     };
  #     desktop-source = {config = ./desktop-source.conf;};
  #   };
  # };

  environment.etc."wireplumber/main.lua.d/51-schiit.lua".text = ''
    rule = {
      matches = {
        {
          { "node.name", "equals", "alsa_output.usb-Schiit_Audio_Schiit_Modi_3_-00.analog-stereo" },
        },
      },
      apply_properties = {
        ["audio.format"] = "S32_LE",
        ["audio.rate"] = 96000,
        ["api.alsa.period-size"] = 128,
      },
    }
    table.insert(alsa_monitor.rules,rule)
  '';
}
