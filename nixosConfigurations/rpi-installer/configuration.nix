{
  self,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe escapeShellArg;

  # the remote flake from which to select the hostname
  flake = "github:SEGuRo/Nixfiles";

  # executables for the script
  nixos-rebuild = getExe pkgs.nixos-rebuild;
  tpm2 = "${pkgs.tpm2-tools}/bin/tpm2";

  # generate json file to determine hostname from tpm
  json = pkgs.formats.json {};
  tpm-to-host = json.generate "tpm-to-host.json" {
    "tpm" = "host";
  };
in {
  imports = with self.nixosModules; [
    nix
    users
    secrets
  ];

  systemd = {
    services.switch-to-final-configuration = {
      wants = ["network-online.target"];
      after = ["network-online.target"];
      script = ''
        tpm="$()"
        hostname="$(jq --raw-output --arg tpm "$tpm" '.[$tpm]' ${tpm-to-host})"
        ${nixos-rebuild} boot --refresh --flake ${escapeShellArg flake}#"$hostname" && systemctl reboot
      '';
    };
  };
}
