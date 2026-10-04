import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services
import qs.theme

// what you see while the session is locked
//
// kept deliberately sparse: every binding here is one more thing that can
// fail behind a lock you can't dismiss
Item {
  id: root

  signal unlocked

  ColumnLayout {
    anchors.centerIn: parent
    width: 340
    spacing: Style.spacingXl

    StyledText {
      Layout.alignment: Qt.AlignHCenter
      text: Time.time
      font.family: Style.monoFamily
      font.pixelSize: Style.fontSizeHuge
      font.bold: true
    }

    StyledText {
      Layout.alignment: Qt.AlignHCenter
      text: Time.date
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeLg
    }

    AuthPanel {
      Layout.fillWidth: true
      Layout.topMargin: Style.spacingLg

      onAuthenticated: root.unlocked()
    }

    RowLayout {
      Layout.alignment: Qt.AlignHCenter
      visible: Power.available
      spacing: Style.spacingXs

      StyledText {
        text: Power.charging || Power.full ? Icons.charging : Icons.batteryLevels[Math.min(4, Math.max(0, Math.round(Power.percent / 25)))]
        font.family: Style.iconFamily
        font.pixelSize: Style.fontSizeSm
        color: Power.critical ? Theme.error : Power.low ? Theme.warning : Theme.textMuted
      }

      StyledText {
        text: `${Math.round(Power.percent)}%`
        font.family: Style.monoFamily
        font.pixelSize: Style.fontSizeSm
        color: Theme.textMuted
      }
    }
  }
}
