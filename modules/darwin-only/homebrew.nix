{ inputs, users, ... }: {
  dendritic.darwinSystemConfig = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    ({ ... }: {
      nix-homebrew = {
        enable = true;
        user = users.alberth.name;
        autoMigrate = true;
      };

      homebrew = {
        enable = true;
        onActivation.cleanup = "zap";
        taps = [
          { name = "dracula/install"; trusted = true; }
        ];
        casks = [
          "tower"
          "gpg-suite@nightly"
          "vorssaint"
          "tailscale-app"
        ];
      };
    })
  ];
}
