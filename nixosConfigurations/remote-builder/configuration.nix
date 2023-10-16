{
  config,
  nixosModules,
  pkgs,
  self,
  ...
}: {
  imports = with self.nixosModules; [
    ./hardware-configuration.nix
    auto-update
    nix
    secrets
    users
  ];

  seguro.auto-update.enable = true;

  networking = {
    hostName = "remote-builder";
    useDHCP = true;

    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
      };
    };

    journald.extraConfig = ''
      SystemMaxUse=100M
      MaxFileSec=7day
    '';

    resolved = {
      enable = true;
      dnssec = "false";
    };
  };
}
