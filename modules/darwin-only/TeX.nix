{ ... }: {
  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [
        "mactex"
        "texstudio"
      ];
    })
  ];
  dendritic.userHomeConfig = [
    ({ pkgs, ... }: {
      home.packages = [ pkgs.texlab ];
    })
  ];
}
