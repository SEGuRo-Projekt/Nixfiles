{
  hostname,
  impermanence,
  ...
}: {
  imports = [
    impermanence.nixosModules.impermanence
  ];

  networking.hostName = hostname;

  environment = {
    # store persistent state on the SD card mounted at /persist
    #
    # only few kinds of state are persistent, namely:
    # - logs: /var/log /etc/machine_id
    # - coredumps: /var/lib/systemd/coredump
    # - private keys: /var/lib/keys
    persistence."/persistent" = {
      hideMounts = true;
      directories = [
        {
          directory = "/var/lib/keys";
          mode = "700";
        }
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
      ];
      files = [
        "/etc/machine-id"
      ];
    };
  };
}
