{ ... }: {
  dendritic.userHomeConfig = [
    ({ pkgs, ... }: {
      home.packages = [ pkgs.zed-editor ];
    })
  ];
}
