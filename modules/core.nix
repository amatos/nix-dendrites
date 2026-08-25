{ lib, ... }: {
  options.dendritic = {
    # System settings shared between NixOS and nix-darwin
    sharedSystemConfig = lib.mkOption {
      type = lib.types.listOf lib.types.deferredModule;
      default = [];
    };
    # Target configurations sent exclusively to Home Manager
    userHomeConfig = lib.mkOption {
      type = lib.types.listOf lib.types.deferredModule;
      default = [];
    };
  };
}
