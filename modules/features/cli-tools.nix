{ ... }: {
  dendritic.userHomeConfig = [
    ({ pkgs, ... }: {
      home.packages = with pkgs; [
        atuin
        bat
        btop
        cowsay
        dos2unix
        eza
        fastfetch
        fortune
        fzf
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
      ];
    })
  ];
}
