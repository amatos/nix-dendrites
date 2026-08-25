{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      environment.systemPackages = [
        pkgs.nh
        pkgs.nil
        pkgs.nixd
      ];
    })
  ];
}
