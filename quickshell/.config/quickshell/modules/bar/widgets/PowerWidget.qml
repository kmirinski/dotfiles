import QtQuick

import qs.components
import qs.modules.bar.popups
import qs.theme

// session actions
BarItem {
  id: root

  readonly property PowerMenu popup: PowerMenu {
    anchorItem: root
  }

  active: root.popup.visible

  onClicked: root.popup.visible = !root.popup.visible

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: Icons.power
    font.family: Style.iconFamily
    font.pixelSize: Style.iconSize
    color: root.popup.visible ? Theme.error : Theme.textMuted
  }
}
