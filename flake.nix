{
  description = "The SEGuRo project flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";

    # raspberry pi hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware";

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

  outputs = inputs @ {
    devenv,
    flake-parts,
    nixpkgs,
    ...
  }: let
    inherit (builtins) attrNames readDir;
    inherit (nixpkgs.lib) genAttrs filterAttrs;
    dirEntries = path: attrNames (filterAttrs (n: v: v == "directory") (readDir path));
    forDirEntries = path: f: genAttrs (dirEntries path) f;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      imports = [devenv.flakeModule];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
        devenv.shells.default.imports = [./devenv.nix];
      };
      flake = {
        nixosModules = let
          dir = ./nixosModules;
          modules = forDirEntries dir (name: import (dir + "/${name}"));
        in
          modules;

        nixosConfigurations = let
          inherit (nixpkgs.lib) nixosSystem;
          dir = ./nixosConfigurations;
          configurations = forDirEntries dir (name: nixosSystem (import (dir + "/${name}") inputs));
        in
          configurations;
      };
    };
}
