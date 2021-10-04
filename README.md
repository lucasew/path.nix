# path.nix

Build the NIX_PATH environment variable from a flake

It does not gather system configurations and the reason is how to extract the ast in a way that home-manager or nixos-rebuild can deal with it as a module.
