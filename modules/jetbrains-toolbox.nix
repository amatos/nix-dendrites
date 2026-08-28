{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ config, pkgs, lib, ... }: {
      environment.systemPackages = lib.optional config.dendritic.isDevDesktop (with pkgs; [
        jetbrains-toolbox
      ]);
    })
  ];
}
