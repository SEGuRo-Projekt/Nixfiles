{
  lib,
  self,
  ...
}: {
  imports = [(nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")];

  boot = {
    cleanTmpDir = true;
    initrd.availableKernelModules = ["xhci_pci" "virtio_pci" "virtio_scsi" "usbhid"];
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/84860870-0109-4de6-ac2e-3e3f1bd09c61";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2FA6-4F04";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "aarch64-linux";

  system.stateVersion = "23.05";
}
