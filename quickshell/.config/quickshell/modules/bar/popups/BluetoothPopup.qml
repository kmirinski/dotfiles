import QtQuick
import QtQuick.Layouts
import Quickshell.Bluetooth

import qs.components
import qs.services
import qs.theme

PopupPanel {
  id: root

  implicitWidth: Style.sysPopupWidth
  implicitHeight: layout.implicitHeight + root.padding * 2

  // discovery drains power and spams the bus, so only run it while the list
  // is actually on screen
  onVisibleChanged: Bt.setDiscovering(root.visible && Bt.enabled)

  ColumnLayout {
    id: layout

    anchors.fill: parent
    spacing: Style.spacingSm

    RowLayout {
      Layout.fillWidth: true

      StyledText {
        text: "bluetooth"
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      Toggle {
        checked: Bt.enabled

        onToggled: value => Bt.setEnabled(value)
      }
    }

    StyledText {
      Layout.fillWidth: true
      visible: !Bt.enabled
      text: "turned off"
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }

    StyledText {
      Layout.fillWidth: true
      visible: Bt.enabled && Bt.devices.length === 0
      text: "no devices"
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }

    ListView {
      Layout.fillWidth: true
      // grow to fit, then scroll rather than running off the screen
      Layout.preferredHeight: Math.min(contentHeight, Style.popupListMaxHeight)
      visible: Bt.enabled && Bt.devices.length > 0
      clip: true
      model: Bt.devices
      spacing: 2
      boundsBehavior: Flickable.StopAtBounds

      delegate: Rectangle {
        id: row

        required property var modelData

        readonly property bool busy: row.modelData.pairing || row.modelData.state === BluetoothDeviceState.Connecting || row.modelData.state === BluetoothDeviceState.Disconnecting

        width: ListView.view.width
        implicitHeight: Style.popupRowHeight
        radius: Style.radiusSm
        color: mouse.containsMouse ? Theme.hover : Theme.transparent

        Behavior on color {
          ColorAnimation {
            duration: Style.durationFast
          }
        }

        RowLayout {
          anchors.fill: parent
          anchors.leftMargin: Style.spacingSm
          anchors.rightMargin: Style.spacingSm
          spacing: Style.spacingSm

          StyledText {
            text: Icons.bluetooth
            font.family: Style.iconFamily
            font.pixelSize: Style.fontSizeSm
            color: row.modelData.connected ? Theme.accent : Theme.textDim
          }

          StyledText {
            Layout.fillWidth: true
            text: row.modelData.deviceName || row.modelData.address
            elide: Text.ElideRight
            color: row.modelData.connected ? Theme.text : Theme.textMuted
          }

          StyledText {
            visible: row.modelData.batteryAvailable
            // same 0-1 fraction as the main battery
            text: `${Math.round(row.modelData.battery * 100)}%`
            font.family: Style.monoFamily
            font.pixelSize: Style.fontSizeSm
            color: Theme.textMuted
          }

          StyledText {
            visible: row.busy || row.modelData.connected
            text: row.busy ? "..." : Icons.check
            font.family: Style.iconFamily
            font.pixelSize: Style.fontSizeSm
            color: Theme.success
          }
        }

        MouseArea {
          id: mouse

          anchors.fill: parent
          hoverEnabled: true
          enabled: !row.busy

          onClicked: {
            if (row.modelData.connected)
              row.modelData.disconnect();
            else if (row.modelData.paired)
              row.modelData.connect();
            else
              row.modelData.pair();
          }
        }
      }
    }
  }
}
