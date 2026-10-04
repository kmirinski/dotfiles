pragma Singleton

import Quickshell
import Quickshell.Networking

// Wi-Fi state and the network list.
//
// Networking.devices only ever holds real network hardware - docker, bridge
// and veth interfaces are already excluded by Quickshell, so no filtering by
// name is needed here.
Singleton {
  id: root

  readonly property var wifiDevice: Networking.devices.values.find(d => d.type === DeviceType.Wifi) ?? null
  readonly property var wiredDevice: Networking.devices.values.find(d => d.type === DeviceType.Wired) ?? null

  readonly property bool wifiEnabled: Networking.wifiEnabled
  // False when the hardware kill switch is off - nothing will work until it's on
  readonly property bool wifiHardwareEnabled: Networking.wifiHardwareEnabled

  readonly property var activeNetwork: root.wifiDevice?.networks.values.find(n => n.connected) ?? null
  readonly property bool wiredConnected: root.wiredDevice?.connected ?? false
  readonly property bool connected: root.activeNetwork !== null || root.wiredConnected

  // 0-1, as Quickshell reports it
  readonly property real signalStrength: root.activeNetwork?.signalStrength ?? 0

  readonly property string ssid: root.activeNetwork?.name ?? ""

  // connected first, then strongest signal
  readonly property var networks: {
    const device = root.wifiDevice;
    if (!device)
      return [];

    return [...device.networks.values].sort((a, b) => {
      if (a.connected !== b.connected)
        return a.connected ? -1 : 1;
      return b.signalStrength - a.signalStrength;
    });
  }

  // scanning costs power, so it's only on while a popup is showing the list
  function setScanning(on) {
    if (root.wifiDevice)
      root.wifiDevice.scannerEnabled = on;
  }

  function setWifiEnabled(on) {
    Networking.wifiEnabled = on;
  }

  function isSecured(network) {
    return network.security !== WifiSecurityType.Open;
  }
}
