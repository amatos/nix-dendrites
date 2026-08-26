{ inputs, config, ... }: {
  flake.nixosConfigurations."ephemeraltron" = inputs.nixpkgs.lib.nixosSystem {
    modules = config.dendritic.sharedSystemConfig ++ config.dendritic.nixosSystemConfig ++ [
      ../hardware/ephemeraltron.nix
      {
        networking.hostName = "ephemeraltron";

        # EFI bootloader
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        # Timezone and locale
        time.timeZone = "America/New_York";
        i18n.defaultLocale = "en_US.UTF-8";

        dendritic.isHeadless = true;
        dendritic.isVirtual = true;
      }
    ];
  };
}
