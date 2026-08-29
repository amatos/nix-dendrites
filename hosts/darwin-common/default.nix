{ inputs, config, users, ... }:
let
  flakeConfig = config;
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
    })
    ({ config, lib, ... }: lib.mkIf config.dendritic.isHomeManagerEnabled {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.extraSpecialArgs = { inherit (inputs) nix-secrets; };
      home-manager.users = builtins.listToAttrs (map (u: {
        name = u.name;
        value = {
          imports = flakeConfig.dendritic.userHomeConfig ++ (map (f: f u) flakeConfig.dendritic.userHomeConfigFor);
          home.stateVersion = "26.05";
        };
      }) assignedUsers);
    })
  ];
}
