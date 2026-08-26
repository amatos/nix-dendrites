{ ... }: {
  dendritic.userHomeConfig = [
    ({ pkgs, lib, osConfig, ... }: {
      home.packages = lib.optional
        (pkgs.stdenv.hostPlatform.isDarwin && !osConfig.dendritic.isVirtual)
        pkgs.utm;
    })
  ];
}
