# This reconnects all paired bluetooth devices all 30s
# Intended as a workaround for bluetooth devices that fail to reconnect
# Originally written for a 4Games BGP-2016 (3rd party ps4 controller)

{ pkgs, ... }:

let
  reconnect = pkgs.writeShellScript "bluetooth-force-connect" ''
    ${pkgs.bluez}/bin/bluetoothctl devices Paired |
      ${pkgs.gnugrep}/bin/grep -oE '([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}' |
      while read -r mac; do
        ${pkgs.bluez}/bin/bluetoothctl connect "$mac" >/dev/null 2>&1 || true
      done
  '';
in {
  systemd.services.bluetooth-force-connect = {
    description = "Reconnect paired Bluetooth devices";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = reconnect;
    };
  };

  systemd.timers.bluetooth-force-connect = {
    description = "Periodically reconnect paired Bluetooth devices";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30s";
      OnUnitActiveSec = "30s";
    };
  };
}
