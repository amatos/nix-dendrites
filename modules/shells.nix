{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      programs.zsh.enable = true;
      programs.bash.enable = true;
      programs.fish.enable = true;
      environment.shells = [ pkgs.bashInteractive pkgs.zsh pkgs.fish ];
      users.users.alberth.shell = pkgs.fish;
    })
  ];
}
