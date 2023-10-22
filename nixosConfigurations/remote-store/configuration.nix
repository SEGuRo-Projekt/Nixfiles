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

  users = {
    groups.nixremote = {};
    users.nixremote = {
      isSystemUser = true;
      useDefaultShell = true;
      group = "nixremote";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOdVp2uN/50APLmPWBjdfzkTHzeFbyr7GZYWWaDz1Lrn root@yoga9"
      ];
    };
  };

  nix = {
    settings.trusted-users = ["nixremote"];
    extraOptions = ''
      secret-key-files = /var/lib/keys/cache.key
    '';
  };

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
