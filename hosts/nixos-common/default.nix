{ inputs, config, users, ... }:
let
  flakeConfig = config;
  assignedUsers = [ users.alberth users.nixos ];
  usersWithPasswordSecret = builtins.filter (u: u ? passwordSecret) assignedUsers;
in {
  dendritic.nixosSystemConfig = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.default
    ({ config, ... }: {
      nixpkgs.hostPlatform = "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "26.05";

      services.openssh.enable = true;

      age.secrets = builtins.listToAttrs (map (u: {
        name = u.passwordSecret;
        value.file = "${inputs.nix-secrets}/users/${u.passwordSecret}.age";
      }) usersWithPasswordSecret);

      users.users = builtins.listToAttrs (map (u: {
        name = u.name;
        value = {
          isNormalUser = true;
          description = u.fullName;
          home = "/home/${u.name}";
        } // (if u ? passwordSecret
          then { hashedPasswordFile = config.age.secrets.${u.passwordSecret}.path; }
          else {});
      }) assignedUsers);

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
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
