import QtQuick

import qs.components
import qs.modules.bar.popups
import qs.services
import qs.theme

// wi-fi state; click for the network list
BarItem {
  id: root

  readonly property NetworkPopup popup: NetworkPopup {
    anchorItem: root
  }

  visible: Net.wifiDevice !== null || Net.wiredDevice !== null
  active: root.popup.visible

  onVisibleChanged: if (!root.visible)
    root.popup.visible = false

  onClicked: root.popup.visible = !root.popup.visible

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: {
      if (Net.wiredConnected)
        return Icons.ethernet;
      return Net.wifiEnabled ? Icons.wifi : Icons.wifiOff;
    }
    font.family: Style.iconFamily
    font.pixelSize: Style.iconSize
    color: {
      if (!Net.wifiEnabled && !Net.wiredConnected)
        return Theme.textDim;
      return Net.connected ? Theme.accent : Theme.textMuted;
    }
  }
}
