{
  lib,
  pkgs,
  agenix,
  ...
}: {
  containers = lib.mkForce {};

  packages = with pkgs; [
    agenix.packages.${pkgs.system}.default
    mkpasswd
    rage
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
