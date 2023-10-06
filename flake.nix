{
  description = "The SEGuRo project flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators }: {

    nixosModules.remote-store = {
      imports = [
        nixos-generators.nixosModules.all-formats
      ];

      nixpkgs.buildPlatform = "aarch64-linux";
      nixpkgs.hostPlatform = "x86_64-linux";
      
    };

    nixosConfigurations.remote-store = nixpkgs.lib.nixosSystem {
      modules = [self.nixosModules.remote-store {
        system.stateVersion = "23.11";
      }];
    };
  };
}
