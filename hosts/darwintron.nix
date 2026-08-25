{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  flake.darwinConfigurations."darwintron" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ [
      {
        networking.hostName = "darwintron";
        nixpkgs.hostPlatform = "aarch64-darwin";
        system.stateVersion = 7;

        users.users = builtins.listToAttrs (map (u: {
          name = u.name;
          value = {
            name = u.name;
            home = "/Users/${u.name}";
          };
        }) assignedUsers);
      }
    ];
  };
}
