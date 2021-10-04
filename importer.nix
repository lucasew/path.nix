{flake_path}:
with builtins;
let
  flake = getFlake (toString flake_path);
  mustValue = key: v: if v == null then
    throw "the value ${key} is not defined"
  else
    v;
  flakeNixPaths = if (hasAttr "nixPaths" flake.outputs) 
    then flake.outputs.nixPaths
    else {};
  inputPaths = flake.inputs // flakeNixPaths;
  pathInputs = mapAttrs (k: v: "${v}") inputPaths;
  paths = pathInputs;
  strpaths = builtins.concatStringsSep ":" (builtins.attrValues (builtins.mapAttrs (k: v: "${k}=${v}") paths));
  script = builtins.toFile "nixpath" ''
    export NIX_PATH=${strpaths}
  '';
in strpaths
