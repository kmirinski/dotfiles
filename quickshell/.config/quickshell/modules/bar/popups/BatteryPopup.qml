import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

import qs.components
import qs.services
import qs.theme

PopupPanel {
  id: root

  implicitWidth: Style.batteryPopupWidth
  implicitHeight: layout.implicitHeight + root.padding * 2

  // label on the left, value on the right
  component InfoRow: RowLayout {
    required property string label
    required property string value

    Layout.fillWidth: true

    StyledText {
      text: parent.label
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }

    Item {
      Layout.fillWidth: true
    }

    StyledText {
      text: parent.value
      font.pixelSize: Style.fontSizeSm
    }
  }

  ColumnLayout {
    id: layout

    anchors.fill: parent
    spacing: Style.spacingMd

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.spacingMd

      StyledText {
        text: Power.charging || Power.full ? Icons.charging : Icons.batteryLevels[Math.min(4, Math.max(0, Math.round(Power.percent / 25)))]
        font.family: Style.iconFamily
        font.pixelSize: Style.fontSizeLg
        color: Power.critical ? Theme.error : Power.low ? Theme.warning : Power.charging ? Theme.success : Theme.text
      }

      ColumnLayout {
        Layout.fillWidth: true
        spacing: 0

        StyledText {
          text: `${Math.round(Power.percent)}%`
          font.pixelSize: Style.fontSizeLg
          font.bold: true
        }

        StyledText {
          text: {
            if (Power.full)
              return "fully charged";
            if (Power.charging)
              return "charging";
            return Power.onBattery ? "on battery" : "discharging";
          }
          color: Theme.textMuted
          font.pixelSize: Style.fontSizeSm
        }
      }
    }

    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 1
      color: Theme.border
    }

    InfoRow {
      visible: value !== ""
      label: Power.charging ? "until full" : "remaining"
      value: Power.formatDuration(Power.timeRemaining)
    }

    // most batteries don't report wear, so this row usually stays hidden
    InfoRow {
      visible: Power.healthSupported
      label: "health"
      value: `${Math.round(Power.health)}%`
    }

    ColumnLayout {
      Layout.fillWidth: true
      spacing: Style.spacingXs

      // the chips are icon-only, so the current profile is named here instead
      RowLayout {
        Layout.fillWidth: true

        StyledText {
          text: "power profile"
          color: Theme.textMuted
          font.pixelSize: Style.fontSizeSm
        }

        Item {
          Layout.fillWidth: true
        }

        StyledText {
          text: {
            if (Power.profile === PowerProfile.PowerSaver)
              return "saver";
            if (Power.profile === PowerProfile.Performance)
              return "performance";
            return "balanced";
          }
          font.pixelSize: Style.fontSizeSm
        }
      }

      RowLayout {
        Layout.fillWidth: true
        spacing: Style.spacingXs

        Repeater {
          model: [
            {
              glyph: Icons.profileSaver,
              value: PowerProfile.PowerSaver
            },
            {
              glyph: Icons.profileBalanced,
              value: PowerProfile.Balanced
            },
            {
              glyph: Icons.profilePerformance,
              value: PowerProfile.Performance
            }
          ]

          Rectangle {
            id: chip

            required property var modelData

            // the performance profile isn't offered on every machine
            readonly property bool supported: chip.modelData.value !== PowerProfile.Performance || Power.hasPerformanceProfile
            readonly property bool selected: Power.profile === chip.modelData.value

            visible: chip.supported
            Layout.fillWidth: true
            implicitHeight: Style.popupRowHeight
            radius: Style.radiusSm
            color: chip.selected ? Theme.accent : mouse.containsMouse ? Theme.hover : Theme.surfaceAlt

            Behavior on color {
              ColorAnimation {
                duration: Style.durationFast
              }
            }

            StyledText {
              anchors.centerIn: parent
              text: chip.modelData.glyph
              font.family: Style.iconFamily
              font.pixelSize: Style.iconSize
              color: chip.selected ? Theme.background : Theme.text
            }

            MouseArea {
              id: mouse

              anchors.fill: parent
              hoverEnabled: true

              onClicked: Power.setProfile(chip.modelData.value)
            }
          }
        }
      }
    }
  }
}
