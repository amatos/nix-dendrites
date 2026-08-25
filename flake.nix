{
  description = "Cross-Platform Dendritic Nix Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ flake-parts, ... }:
    let
      loadModules = dir:
        let entries = builtins.readDir dir;
        in builtins.concatMap (name:
          let path = dir + "/${name}"; in
          if entries.${name} == "directory" then loadModules path
          else if entries.${name} == "regular" && builtins.match ".*\\.nix" name != null then [ path ]
          else []
        ) (builtins.attrNames entries);

      loadData = dir:
        let entries = builtins.readDir dir;
        in builtins.listToAttrs (builtins.concatMap (name:
          if entries.${name} == "regular" && builtins.match ".*\\.nix" name != null
          then [{
            name = builtins.substring 0 (builtins.stringLength name - 4) name;
            value = import (dir + "/${name}");
          }]
          else []
        ) (builtins.attrNames entries));
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      _module.args.users = loadData ./users;
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      imports = loadModules ./modules ++ loadModules ./hosts;
    };
}
