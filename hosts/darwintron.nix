{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  flake.darwinConfigurations."darwintron" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ [
      inputs.home-manager.darwinModules.home-manager
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

        home-manager.users = builtins.listToAttrs (map (u: {
          name = u.name;
          value = {
            imports = config.dendritic.userHomeConfig;
            home.stateVersion = "26.05";
          };
        }) assignedUsers);
      }
    ];
  };
}
