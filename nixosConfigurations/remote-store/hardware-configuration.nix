{
  lib,
  self,
  ...
}: {
  imports = [(nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")];

  boot = {
    cleanTmpDir = true;
    initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk"];
    kernelModules = ["kvm-intel"];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/vda2";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/vda1";
      fsType = "vfat";
    };
  };

  swapDevices = [];

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.05";
}
