{ ... }: {
  dendritic.sharedSystemConfig = [
    ({ pkgs, ... }: {
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = [
        pkgs.nh
        pkgs.nil
        pkgs.nixd
      ];
    })
  ];
}
