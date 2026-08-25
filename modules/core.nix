{ lib, ... }: {
  options = {
    dendritic = {
      sharedSystemConfig = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [];
      };
      userHomeConfig = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [];
      };
    };

    flake.darwinConfigurations = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
    };

    flake.nixosConfigurations = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
    };
  };
}
