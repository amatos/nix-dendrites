{ lib, ... }: {
  options.dendritic = {
    sharedSystemConfig = lib.mkOption {
      type = lib.types.listOf lib.types.deferredModule;
      default = [];
    };
  };
}
