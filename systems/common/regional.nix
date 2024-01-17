{...}: {
  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
    LANGUAGE = "en_US.UTF-8";
    LANG = "en_US.UTF-8";
  };

  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_IE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
    "ro_RO.UTF-8/UTF-8"
  ];
  console.keyMap = "us";
}
