{
  lib,
  pkgs,
  agenix,
  ...
}: let
  agenixWithAge = agenix.packages.${pkgs.system}.default.override {
    ageBin = lib.getExe pkgs.age;
  };
in {
  containers = lib.mkForce {};

  packages = with pkgs; [
    age
    agenixWithAge
    mkpasswd
  ];

  enterShell = ''
    # enter the users default shell if interactive
    [ -z "$PS1" ] || exec "$SHELL"
  '';

  pre-commit.hooks = {
    alejandra.enable = true;
    editorconfig-checker.enable = true;
    nix-flake-check = {
      enable = true;
      name = "nix flake check";
      entry = "nix flake check --impure --no-build";
      language = "system";
      pass_filenames = false;
    };
  };
}
