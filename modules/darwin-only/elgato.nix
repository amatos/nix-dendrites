{ ... }: {
  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [
        "elgato-capture-device-utility"
        "elgato-stream-deck"
        "elgato-studio"
        "elgato-control-center"
        "elgato-wave-link"
      ];
    })
  ];
}
