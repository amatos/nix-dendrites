{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        bat
        btop
        cowsay
        deadnix
        dos2unix
        eza
        fastfetch
        fortune
        fzf
        git
        gitleaks
        gnupg
        home-manager
        htop
        jq
        just
        lsd
        lsof
        nixfmt
        pstree
        ripgrep
        shellcheck
        starship
        statix
        tealdeer
        tmux
        tokei
        wget
        yazi
        yq-go
        zoxide
      ];
    })
  ];
}
