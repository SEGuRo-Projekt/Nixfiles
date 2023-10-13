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
    settings.experimental-features = ["nix-command" "flakes"];

    # garbage collect the nix store once a week
    gc = {
      automatic = true;
      dates = "weekly";
    };
  };
}
