{
  description = "The SEGuRo project flake";

  inputs = {
    nixpkgs.url = "github:nixpkgs/nixos-23.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";

    # raspberry pi hardware support
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # generate qcow2 images for a NixOS configuration
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # store encrypted secrets in git
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{flake-parts, devenv, ...}:
    flake-parts.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

      imports = [
        devenv.flakeModule
      ];

      perSystem = {pkgs, ...}: {
        formatter = pkgs
      };

      flake = {
        
      }
    };
}
