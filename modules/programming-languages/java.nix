{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        openjdk21
        openjdk25
        maven3
        gradle
        groovy
        jenv
        plantuml
      ];
    })
  ];
}
