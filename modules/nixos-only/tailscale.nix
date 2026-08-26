{ ... }: {
  dendritic.nixosSystemConfig = [
    ({ ... }: {
      services.tailscale.enable = true;
      # Opens the tailscale UDP port so peers can connect directly
      # instead of always relaying through DERP.
      services.tailscale.openFirewall = true;

      networking.firewall.enable = true;
      # tailscale0 is the "local" network device: traffic arriving over
      # the tailnet is treated as coming from a trusted local network.
      networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 22 ];
    })
  ];
}
