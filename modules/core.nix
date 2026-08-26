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
      userHomeConfigFor = lib.mkOption {
        type = lib.types.listOf (lib.types.functionTo lib.types.deferredModule);
        default = [];
        description = ''
          Like `userHomeConfig`, but each entry is a function from a user
          record (an attrset from `./users`) to a deferred module, for config
          that varies per-user (e.g. keyed off a per-user field).
        '';
      };
      darwinSystemConfig = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [];
      };
      nixosSystemConfig = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [];
      };
    };

    flake.darwinConfigurations = lib.mkOption {
      type = lib.types.attrsOf lib.types.raw;
      default = {};
    };
  };

  config.dendritic.sharedSystemConfig = [
    ({ lib, ... }: {
      options.dendritic.isHeadless = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether this host has no display/GUI. Modules that install
          GUI-only packages should skip themselves on hosts where this is
          true, instead of special-casing hostnames.
        '';
      };
      options.dendritic.isVirtual = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Whether this host is a virtual machine. Modules that install
          hypervisor/virtualization tooling (e.g. UTM) should skip
          themselves on hosts where this is true, instead of
          special-casing hostnames.
        '';
      };
    })
  ];
}
