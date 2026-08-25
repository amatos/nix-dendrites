{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  flake.darwinConfigurations."codex" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ [
      inputs.home-manager.darwinModules.home-manager
      {
        networking.hostName = "codex";
        nixpkgs.hostPlatform = "aarch64-darwin";
        system.stateVersion = 7;
        system.primaryUser = (builtins.head assignedUsers).name;

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
            programs.git.settings.user.email = u.email;
            home.stateVersion = "26.05";
          };
        }) assignedUsers);
      }
    ];
  };
}
