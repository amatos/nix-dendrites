{ inputs, config, ... }: {
  flake.darwinConfigurations."codex" = inputs.nix-darwin.lib.darwinSystem {
    modules = config.dendritic.sharedSystemConfig ++ config.dendritic.darwinSystemConfig ++ [
      {
        networking.hostName = "codex";
        dendritic.isSteamMachine = true;
        dendritic.isObsMachine = true;
        dendritic.isDevDesktop = true;
      }
    ];
  };
}
