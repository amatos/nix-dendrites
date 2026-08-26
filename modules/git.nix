{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = [ pkgs.git pkgs.git-lfs ];
    })
  ];
}
