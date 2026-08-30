# Wires certbot + the certbot-dns-luadns plugin (pkgs/python/certbot-dns-luadns.nix)
# into a launchd daemon that keeps existing certs renewed.
#
# nix-darwin has no `services.certbot` (that's NixOS-only), so renewal is a
# plain `certbot renew` on a timer instead of a fully declarative cert block.
# `renew` is idempotent and needs no domain argument — it just re-processes
# whatever's already under /etc/letsencrypt/renewal, so the schedule below
# works unconditionally, before any cert has ever been issued.
#
# Initial issuance is a one-time manual step (needs a domain, so it can't be
# safely inferred/declared here):
#   certbot certonly --dns-luadns \
#     --dns-luadns-credentials /run/agenix/certbot-luadns \
#     -d example.com
{ inputs, ... }: {
  dendritic.darwinSystemConfig = [
    inputs.ragenix.darwinModules.default
    ({ pkgs, ... }:
      let
        certbotWithPlugins = pkgs.certbot.withPlugins (
          cp: [ (cp.callPackage ../../pkgs/python/certbot-dns-luadns.nix { }) ]
        );
      in {
        age.secrets.certbot-luadns.file = "${inputs.nix-secrets}/services/certbot-luadns.age";

        environment.systemPackages = [ certbotWithPlugins ];

        launchd.daemons.certbot-renew = {
          command = "${certbotWithPlugins}/bin/certbot renew --non-interactive";
          serviceConfig = {
            StartInterval = 60 * 60 * 24 * 30; # every 30 days
            StandardOutPath = "/var/log/certbot-renew.log";
            StandardErrorPath = "/var/log/certbot-renew.log";
          };
        };
      })
  ];
}
