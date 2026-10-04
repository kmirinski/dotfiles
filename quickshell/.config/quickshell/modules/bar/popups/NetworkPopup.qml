import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services
import qs.theme

PopupPanel {
  id: root

  // the network waiting on a password, if any
  property var pendingNetwork: null
  property string password: ""

  implicitWidth: Style.sysPopupWidth
  implicitHeight: layout.implicitHeight + root.padding * 2

  // scanning costs power, so it only runs while this list is on screen
  onVisibleChanged: {
    Net.setScanning(root.visible && Net.wifiEnabled);
    if (!root.visible)
      root.clearPending();
  }

  function clearPending() {
    root.pendingNetwork = null;
    root.password = "";
  }

  function activate(network) {
    if (network.connected) {
      network.disconnect();
      return;
    }
    // already has saved credentials, or doesn't need any
    if (network.known || !Net.isSecured(network)) {
      network.connect();
      return;
    }
    root.pendingNetwork = network;
    root.password = "";
  }

  function submit() {
    if (root.pendingNetwork && root.password.length > 0) {
      root.pendingNetwork.connectWithPsk(root.password);
      root.clearPending();
    }
  }

  ColumnLayout {
    id: layout

    anchors.fill: parent
    spacing: Style.spacingSm

    RowLayout {
      Layout.fillWidth: true

      StyledText {
        text: "wi-fi"
        font.bold: true
      }

      Item {
        Layout.fillWidth: true
      }

      Toggle {
        checked: Net.wifiEnabled
        // the hardware kill switch overrides everything
        enabled: Net.wifiHardwareEnabled

        onToggled: value => Net.setWifiEnabled(value)
      }
    }

    StyledText {
      Layout.fillWidth: true
      visible: !Net.wifiHardwareEnabled
      text: "blocked by hardware switch"
      color: Theme.warning
      font.pixelSize: Style.fontSizeSm
    }

    StyledText {
      Layout.fillWidth: true
      visible: Net.wifiHardwareEnabled && !Net.wifiEnabled
      text: "turned off"
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }

    StyledText {
      Layout.fillWidth: true
      visible: Net.wifiEnabled && Net.networks.length === 0
      text: "scanning..."
      color: Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }

    ListView {
      Layout.fillWidth: true
      Layout.preferredHeight: Math.min(contentHeight, Style.popupListMaxHeight)
      visible: Net.wifiEnabled && Net.networks.length > 0
      clip: true
      model: Net.networks
      spacing: 2
      boundsBehavior: Flickable.StopAtBounds

      delegate: Rectangle {
        id: row

        required property var modelData

        readonly property bool busy: row.modelData.stateChanging

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
            text: Icons.wifi
            font.family: Style.iconFamily
            font.pixelSize: Style.fontSizeSm
            color: row.modelData.connected ? Theme.accent : Theme.textDim
          }

          StyledText {
            Layout.fillWidth: true
            text: row.modelData.name
            elide: Text.ElideRight
            color: row.modelData.connected ? Theme.text : Theme.textMuted
          }

          StyledText {
            visible: Net.isSecured(row.modelData)
            text: Icons.lock
            font.family: Style.iconFamily
            font.pixelSize: Style.fontSizeSm
            color: Theme.textDim
          }

          StyledText {
            // signalStrength is a 0-1 fraction
            text: `${String(Math.round(row.modelData.signalStrength * 100)).padStart(3, " ")}%`
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

          onClicked: root.activate(row.modelData)
        }
      }
    }

    // password prompt, shown only for a secured network we have no key for
    ColumnLayout {
      Layout.fillWidth: true
      visible: root.pendingNetwork !== null
      spacing: Style.spacingXs

      Rectangle {
        Layout.fillWidth: true
        implicitHeight: 1
        color: Theme.border
      }

      StyledText {
        text: `password for ${root.pendingNetwork?.name ?? ""}`
        color: Theme.textMuted
        font.pixelSize: Style.fontSizeSm
      }

      RowLayout {
        Layout.fillWidth: true
        spacing: Style.spacingXs

        Rectangle {
          Layout.fillWidth: true
          implicitHeight: Style.popupRowHeight - 6
          radius: Style.radiusSm
          color: Theme.surfaceAlt
          border.width: 1
          border.color: input.activeFocus ? Theme.accent : Theme.border

          TextInput {
            id: input

            anchors.fill: parent
            anchors.leftMargin: Style.spacingSm
            anchors.rightMargin: Style.spacingSm
            verticalAlignment: TextInput.AlignVCenter
            echoMode: TextInput.Password
            color: Theme.text
            font.family: Style.fontFamily
            font.pixelSize: Style.fontSize
            selectByMouse: true
            selectionColor: Theme.accent

            // take the caret as soon as the prompt appears
            focus: root.pendingNetwork !== null
            text: root.password

            onTextChanged: root.password = text
            onAccepted: root.submit()
            Keys.onEscapePressed: root.clearPending()
          }
        }

        IconButton {
          glyph: Icons.check
          enabled: root.password.length > 0

          onClicked: root.submit()
        }

        IconButton {
          glyph: Icons.close

          onClicked: root.clearPending()
        }
      }
    }
  }
}
