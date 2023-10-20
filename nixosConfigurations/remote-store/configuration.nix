{
  config,
  nixosModules,
  pkgs,
  self,
  ...
}: {
  imports = with self.nixosModules; [
    auto-update
    nix
    secrets
    users
  ];

  seguro.auto-update.enable = true;

  networking = {
    hostName = "remote-store";
    useDHCP = true;
  };

  nix.extraOptions = ''
    secret-key-files = /var/lib/keys/cache.key
  '';

  time.timeZone = "Europe/Berlin";

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
