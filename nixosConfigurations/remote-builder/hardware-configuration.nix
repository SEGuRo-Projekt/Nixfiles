{
  lib,
  nixpkgs,
  self,
  ...
}: {
  imports = [(nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")];

  boot = {
    tmp.cleanOnBoot = true;
    initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "aarch64-linux";

  system.stateVersion = "23.05";
}
