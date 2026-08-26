{ inputs, config, ... }: {
  flake.darwinConfigurations."darwintron" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ config.dendritic.darwinSystemConfig ++ [
      {
        networking.hostName = "darwintron";
        dendritic.isVirtual = true;
      }
    ];
  };
}
