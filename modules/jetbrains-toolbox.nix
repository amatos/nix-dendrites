{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ config, pkgs, lib, ... }: {
      environment.systemPackages = lib.optional config.dendritic.isDevDesktop pkgs.jetbrains-toolbox;
    })
  ];
}
