{self, ...}: {
  imports = [self.nixosModules.rpi-base];
  system.stateVersion = "23.11";
}
