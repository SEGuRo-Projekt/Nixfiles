{lib, ...}: {
  containers = lib.mkForce {};

  enterShell = ''
    # enter the users default shell if interactive
    [ -z "$PS1" ] || exec "$SHELL"
  '';

  env = {
  };

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
