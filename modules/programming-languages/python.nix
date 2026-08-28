{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        black
        pylint
        pyrefly
        python3
      ];
    })
  ];
}
