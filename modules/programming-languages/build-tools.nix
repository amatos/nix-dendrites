{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        cmake
        cmake-format
        cmake-language-server
        cmake-lint
        meson
        mesonlsp
        meson-tools
        ninja
      ];
    })
  ];
}
