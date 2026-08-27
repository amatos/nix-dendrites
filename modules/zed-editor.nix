{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, lib, ... }: {
      environment.systemPackages = lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.zed-editor;
    })
  ];

  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [ "zed" ];
    })
  ];
}
