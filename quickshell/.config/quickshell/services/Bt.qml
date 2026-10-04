pragma Singleton

import Quickshell
import Quickshell.Bluetooth

// Bluetooth adapter and its known devices.
//
// Named Bt rather than Bluetooth so it doesn't collide with the Quickshell
// singleton of that name, which this wraps.
Singleton {
  id: root

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property bool available: root.adapter !== null
  readonly property bool enabled: root.adapter?.enabled ?? false
  readonly property bool discovering: root.adapter?.discovering ?? false

  // Connected first, then paired, then alphabetical
  readonly property var devices: {
    const a = root.adapter;
    if (!a)
      return [];

    return [...a.devices.values].sort((x, y) => {
      if (x.connected !== y.connected)
        return x.connected ? -1 : 1;
      if (x.paired !== y.paired)
        return x.paired ? -1 : 1;
      return (x.deviceName ?? "").localeCompare(y.deviceName ?? "");
    });
  }

  readonly property var connectedDevices: root.devices.filter(d => d.connected)

  function setEnabled(on) {
    if (root.adapter)
      root.adapter.enabled = on;
  }

  // Like Wi-Fi scanning, only run discovery while the popup is open
  function setDiscovering(on) {
    if (root.adapter)
      root.adapter.discovering = on;
  }
}
