{ ... }: {
  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [
        "discord"
        "dracula-betterdiscord"
        "betterdiscord-installer"
      ];
    })
  ];
}
