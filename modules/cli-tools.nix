{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        bat
        btop
        cowsay
        dos2unix
        eza
        fastfetch
        fortune
        fzf
        gnupg
        htop
        lsd
        pstree
        ripgrep
        starship
        tealdeer
        tmux
        wget
        yazi
        zoxide
        lsof
        home-manager
      ];
    })
  ];
}
