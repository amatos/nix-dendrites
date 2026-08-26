{ ... }: {
  dendritic.userHomeConfig = [
    ({ pkgs, ... }: {
      home.packages = [ pkgs.zapp ];
    })
  ];
}
