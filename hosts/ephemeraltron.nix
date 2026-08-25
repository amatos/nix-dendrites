{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  flake.nixosConfigurations."ephemeraltron" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = config.dendritic.sharedSystemConfig ++ [
      inputs.home-manager.nixosModules.home-manager
      {
        networking.hostName = "ephemeraltron";
        system.stateVersion = "26.05";

        users.users = builtins.listToAttrs (map (u: {
          name = u.name;
          value = {
            isNormalUser = true;
            home = "/home/${u.name}";
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
