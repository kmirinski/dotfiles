import QtQuick

import qs.components
import qs.modules.bar.popups
import qs.services
import qs.theme

// battery level; click for time remaining and power profiles
BarItem {
  id: root

  // quarter-step icon, or a bolt while charging
  readonly property string glyph: {
    if (Power.charging || Power.full)
      return Icons.charging;
    const index = Math.min(4, Math.max(0, Math.round(Power.percent / 25)));
    return Icons.batteryLevels[index];
  }

  readonly property color tint: {
    if (Power.charging || Power.full)
      return Theme.success;
    if (Power.critical)
      return Theme.error;
    if (Power.low)
      return Theme.warning;
    return Theme.textMuted;
  }

  readonly property BatteryPopup popup: BatteryPopup {
    anchorItem: root
  }

  visible: Power.available
  active: root.popup.visible

  onVisibleChanged: if (!root.visible)
    root.popup.visible = false

  onClicked: root.popup.visible = !root.popup.visible

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: root.glyph
    font.family: Style.iconFamily
    font.pixelSize: Style.iconSize
    color: root.tint
  }

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    // padded so the bar doesn't shift between 9% and 100%
    text: `${String(Math.round(Power.percent)).padStart(3, " ")}%`
    font.family: Style.monoFamily
    color: root.tint
  }
}
