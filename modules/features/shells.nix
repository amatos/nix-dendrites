{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      programs.zsh.enable = true;
      programs.bash.enable = true;
      programs.fish.enable = true;
    })
  ];
}
