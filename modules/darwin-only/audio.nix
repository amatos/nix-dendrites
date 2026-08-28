{ ... }: {
  dendritic.darwinSystemConfig = [
    ({ ... }: {
      homebrew.casks = [
        "airfoil"
        "audio-hijack"
        "farrago"
        "piezo"
        "fission"
        "focusrite-control-2"
        "soundsource"
      ];
    })
  ];
}
