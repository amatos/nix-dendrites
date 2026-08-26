{ ... }: {
  dendritic.userHomeConfig = [
    ({ pkgs, ... }: {
      home.packages = [ pkgs.zoom-us ];
    })
  ];
}
