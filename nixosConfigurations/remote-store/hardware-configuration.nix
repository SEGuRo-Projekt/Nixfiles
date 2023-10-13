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
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.05";
}
