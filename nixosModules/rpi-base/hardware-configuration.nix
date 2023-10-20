{
  boot = {
    loader.systemd-boot.enable = true;
  };

  # default NixOS sd image partitioning
  fileSystems = {
    # mount tmpfs as root
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = ["size=2G" "mode=755"];
    };

    # mount the firmware partition into /boot
    "/boot/firmware" = {
      device = "/dev/disk/by-label/FIRMWARE";
      fsType = "vfat";
    };

    # mount the rest of the partition as persistent storage
    "/persistent" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      neededForBoot = true;
    };

    # mount /nix from persistent storage
    "/nix" = {
      depends = ["/persistent"];
      device = "/persistent/nix";
      fsType = "none";
      options = ["bind"];
    };

    # mount /boot from persistent storage
    "/boot" = {
      depends = ["/persistent"];
      device = "/persistent/boot";
      fsType = "none";
      options = ["bind"];
    };
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  networking.useDHCP = true;
  nixpkgs.hostPlatform = "aarch64-linux";
}
