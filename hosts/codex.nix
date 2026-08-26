{ inputs, config, ... }: {
  flake.darwinConfigurations."codex" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ config.dendritic.darwinSystemConfig ++ [
      {
        networking.hostName = "codex";
      }
    ];
  };
}
