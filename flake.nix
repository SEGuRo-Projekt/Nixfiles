{
  description = "The SEGuRo project flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";

    # raspberry pi hardware support
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # store encrypted secrets in git
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # selectively persist files while mounting "/" on tmpfs
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ {
    devenv,
    flake-parts,
    nixpkgs,
    ...
  }: let
    inherit (builtins) attrNames readDir;
    inherit (nixpkgs.lib) filterAttrs mapAttrs;

    dirEntries = path: let
      toPath = n: v: path + "/${n}";
    in
      mapAttrs toPath (readDir path);
    forDirEntries = path: f: mapAttrs f (dirEntries path);
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      imports = [devenv.flakeModule];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
        devenv.shells.default.imports = [./devenv.nix];
        legacyPackages = pkgs;
      };
      flake = {
        nixosModules = let
          dir = ./nixosModules;
          mkNixosModule = name: path: import path;
        in
          forDirEntries dir mkNixosModule;

        nixosConfigurations = let
          dir = ./nixosConfigurations;
          parse = hostname: {
            system,
            modules,
          }: {
            inherit system modules;
            specialArgs = inputs // {inherit hostname;};
          };
          mkNixosConfiguration = name: path:
            nixpkgs.lib.nixosSystem
            (parse name (import path));
        in
          forDirEntries dir mkNixosConfiguration;

        secrets = dirEntries ./secrets;
      };
    };
}
