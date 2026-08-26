{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, lib, ... }: {
      environment.systemPackages = lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.ghostty;
    })
  ];

  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [ "ghostty" ];
    })
  ];
}
