{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  dendritic.darwinSystemConfig = [
    inputs.home-manager.darwinModules.home-manager
    ({ ... }: {
      nixpkgs.hostPlatform = "aarch64-darwin";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = 7;
      system.primaryUser = (builtins.head assignedUsers).name;

      users.knownUsers = map (u: u.name) assignedUsers;
      users.users = builtins.listToAttrs (map (u: {
        name = u.name;
        value = {
          name = u.name;
          uid = u.uid;
          home = "/Users/${u.name}";
        };
      }) assignedUsers);

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.users = builtins.listToAttrs (map (u: {
        name = u.name;
        value = {
          imports = config.dendritic.userHomeConfig ++ (map (f: f u) config.dendritic.userHomeConfigFor);
          home.stateVersion = "26.05";
        };
      }) assignedUsers);
    })
  ];
}
