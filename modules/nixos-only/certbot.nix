# Wires certbot + the certbot-dns-luadns plugin (pkgs/python/certbot-dns-luadns.nix)
# into a systemd timer that keeps existing certs renewed.
#
# `certbot renew` is idempotent and needs no domain argument — it just
# re-processes whatever's already under /etc/letsencrypt/renewal, so the
# timer below works unconditionally, before any cert has ever been issued.
# (ragenix.nixosModules.default is already imported by hosts/nixos-common,
# so it's not re-imported here.)
#
# Initial issuance is a one-time manual step (needs a domain, so it can't be
# safely inferred/declared here):
#   certbot certonly --dns-luadns \
#     --dns-luadns-credentials /run/agenix/certbot-luadns \
#     -d example.com
{ inputs, ... }: {
  dendritic.nixosSystemConfig = [
    ({ pkgs, ... }:
      let
        certbotWithPlugins = pkgs.certbot.withPlugins (
          cp: [ (cp.callPackage ../../pkgs/python/certbot-dns-luadns.nix { }) ]
        );
      in {
        age.secrets.certbot-luadns.file = "${inputs.nix-secrets}/services/certbot-luadns.age";

        environment.systemPackages = [ certbotWithPlugins ];

        systemd.services.certbot-renew = {
          description = "Renew certbot certificates";
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${certbotWithPlugins}/bin/certbot renew --non-interactive";
          };
        };

        systemd.timers.certbot-renew = {
          description = "Renew certbot certificates every 30 days";
          wantedBy = [ "timers.target" ];
          timerConfig = {
            OnBootSec = "10m";
            OnUnitActiveSec = "30d";
            Persistent = true;
          };
        };
      })
  ];
}
