{pkgs ? import <nixpkgs> {}}:
pkgs.writeShellScriptBin "pathnix" ''
IMPORTER=${./importer.nix} source ${./build-path} "$@"
''
