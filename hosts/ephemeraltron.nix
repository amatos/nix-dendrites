{ inputs, config, users, ... }:
let
  assignedUsers = [ users.alberth ];
in {
  flake.nixosConfigurations."ephemeraltron" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = config.dendritic.sharedSystemConfig ++ [
      {
        networking.hostName = "ephemeraltron";
        system.stateVersion = "26.05";

        users.users = builtins.listToAttrs (map (u: {
          name = u.name;
          value = {
            isNormalUser = true;
            description = u.fullName;
            home = "/home/${u.name}";
          };
        }) assignedUsers);
      }
    ];
  };
}
