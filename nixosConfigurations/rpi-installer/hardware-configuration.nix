{
  lib,
  nixpkgs,
  nixos-hardware,
  pkgs,
  ...
}: {
  imports = [
    (nixpkgs + "/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix")
    nixos-hardware.nixosModules.raspberry-pi-4
  ];

  # only support the necessary file systems
  boot.supportedFilesystems = lib.mkForce ["ext4" "vfat"];

  nixpkgs = {
    hostPlatform = "aarch64-linux";
    overlays = [
      # Workaround: https://github.com/NixOS/nixpkgs/issues/154163
      # modprobe: FATAL: Module sun4i-drm not found in directory
      (final: super: {
        makeModulesClosure = x:
          super.makeModulesClosure (x // {allowMissing = true;});
      })
    ];
  };

  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  console.enable = false;

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
  ];

  sdImage.compressImage = false;

  networking = {
    firewall.enable = false;
    useDHCP = true;
  };

  system.stateVersion = "23.11";
}
