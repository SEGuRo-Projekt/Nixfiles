{
  lib,
  self,
  ...
}: let
  inherit (lib) mapAttrs mapAttrsToList;
  flakes = self.inputs // {inherit self;};
in {
  nix = {
    # pin all inputs of this flake in NIX_PATH and flake registry
    nixPath = mapAttrsToList (name: value: "${name}=${value}") flakes;
    registry = mapAttrs (name: value: {flake = value;}) flakes;

    # enable the new nix CLI and flakes
    settings = {
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "s3://nixcache?profile=default&scheme=https&endpoint=s4.0l.de"
      ];
    };

    buildMachines = [
      {
        hostName = "oci.0l.de";
        system = "aarch64-linux";
        protocol = "ssh-ng";
        maxJobs = 4;
        speedFactor = 2;
        mandatoryFeatures = [];
      }
    ];

    distributedBuilds = true;

    # Optional, useful when the builder has a faster internet connection than yours
    extraOptions = ''
      builders-use-substitutes = true
    '';

    # garbage collect the nix store once a week
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
}
