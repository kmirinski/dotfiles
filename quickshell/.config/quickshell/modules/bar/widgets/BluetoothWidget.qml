import QtQuick

import qs.components
import qs.modules.bar.popups
import qs.services
import qs.theme

// bluetooth state; click for the device list
BarItem {
  id: root

  readonly property BluetoothPopup popup: BluetoothPopup {
    anchorItem: root
  }

  // hidden entirely on a machine with no bluetooth hardware
  visible: Bt.available
  active: root.popup.visible

  onVisibleChanged: if (!root.visible)
    root.popup.visible = false

  onClicked: root.popup.visible = !root.popup.visible

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: Bt.enabled ? Icons.bluetooth : Icons.bluetoothOff
    font.family: Style.iconFamily
    font.pixelSize: Style.iconSize
    color: {
      if (!Bt.enabled)
        return Theme.textDim;
      return Bt.connectedDevices.length > 0 ? Theme.accent : Theme.textMuted;
    }
  }

  // only worth showing when something is actually attached
  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    visible: Bt.connectedDevices.length > 0
    text: Bt.connectedDevices.length
    font.family: Style.monoFamily
    font.pixelSize: Style.fontSizeSm
    color: Theme.accent
  }
}
