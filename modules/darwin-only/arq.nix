{ ... }: {
  dendritic.darwinSystemConfig = [
    ({ pkgs, ... }: {
      environment.systemPackages = [ pkgs.arq ];

      # Arq's .pkg installer normally registers these via postinstall
      # (launchctl load ...), which only runs when installing through
      # Apple's installer. Since Nix just copies the app bundle, we have
      # to declare the same two jobs ourselves or the Arq GUI can never
      # reach its background agent on 127.0.0.1.
      launchd.daemons.arqagent = {
        serviceConfig = {
          Label = "com.haystacksoftware.arqagent";
          ProgramArguments = [
            "${pkgs.arq}/Applications/Arq.app/Contents/Resources/ArqAgent.app/Contents/MacOS/ArqAgent"
          ];
          RunAtLoad = true;
          KeepAlive = true;
        };
      };

      launchd.agents.ArqMonitor = {
        serviceConfig = {
          Label = "com.haystacksoftware.ArqMonitor";
          ProgramArguments = [
            "${pkgs.arq}/Applications/Arq.app/Contents/Resources/ArqMonitor.app/Contents/MacOS/ArqMonitor"
          ];
          RunAtLoad = true;
          KeepAlive = true;
        };
      };
    })
  ];
}
