{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ config, pkgs, lib, ... }: {
      environment.systemPackages = lib.optional
        (pkgs.stdenv.hostPlatform.isLinux && config.dendritic.isObsMachine)
        pkgs.obs-studio;
    })
  ];

  dendritic.darwinSystemConfig = [
    ({ config, lib, ... }: {
      homebrew.casks = lib.optional config.dendritic.isObsMachine "obs";
    })
  ];
}
