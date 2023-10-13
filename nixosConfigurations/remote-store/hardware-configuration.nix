{
  lib,
  nixpkgs,
  self,
  ...
}: {
  imports = [(nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")];

  boot = {
    tmp.cleanOnBoot = true;
    initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk"];
    kernelModules = ["kvm-intel"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/f855068a-bc30-4a35-ab92-0476e5a7bb54";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D451-3135";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.05";
}
