{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ config, pkgs, lib, ... }: {
      environment.systemPackages = lib.optional
        (pkgs.stdenv.hostPlatform.isLinux && config.dendritic.isSteamMachine)
        pkgs.steam;
    })
  ];

  dendritic.darwinSystemConfig = [
    ({ config, lib, ... }: {
      homebrew.casks = lib.optional config.dendritic.isSteamMachine "steam";
    })
  ];
}
