{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        ruby
        rubyfmt
      ];
    })
  ];
}
