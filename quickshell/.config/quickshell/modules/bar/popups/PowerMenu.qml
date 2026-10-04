import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import qs.components
import qs.services
import qs.theme

PopupPanel {
  id: root

  // the action awaiting confirmation; null while the menu itself is showing
  property var pending: null

  implicitWidth: Style.powerMenuWidth
  implicitHeight: (root.pending ? confirm.implicitHeight : menu.implicitHeight) + root.padding * 2

  onVisibleChanged: if (!root.visible)
    root.pending = null

  // execDetached must be given an array - the string overload exists but
  // silently does nothing
  readonly property var actions: [
    {
      glyph: Icons.lock,
      label: "lock",
      needsConfirm: false,
      run: () => SessionLock.lock()
    },
    {
      glyph: Icons.suspend,
      label: "suspend",
      needsConfirm: false,
      run: () => Quickshell.execDetached(["systemctl", "suspend"])
    },
    {
      glyph: Icons.logout,
      label: "log out",
      needsConfirm: true,
      run: () => Hyprland.dispatch("hl.dsp.exit()")
    },
    {
      glyph: Icons.restart,
      label: "restart",
      needsConfirm: true,
      run: () => Quickshell.execDetached(["systemctl", "reboot"])
    },
    {
      glyph: Icons.power,
      label: "power off",
      needsConfirm: true,
      run: () => Quickshell.execDetached(["systemctl", "poweroff"])
    }
  ]

  function activate(action) {
    if (action.needsConfirm) {
      root.pending = action;
      return;
    }
    root.visible = false;
    action.run();
  }

  function runPending() {
    const action = root.pending;
    root.pending = null;
    root.visible = false;
    action.run();
  }

  ColumnLayout {
    id: menu

    anchors.fill: parent
    visible: root.pending === null
    spacing: 2

    Repeater {
      model: root.actions

      Rectangle {
        id: row

        required property var modelData

        Layout.fillWidth: true
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
          anchors.leftMargin: Style.spacingMd
          anchors.rightMargin: Style.spacingMd
          spacing: Style.spacingMd

          StyledText {
            text: row.modelData.glyph
            font.family: Style.iconFamily
            font.pixelSize: Style.iconSize
            color: row.modelData.needsConfirm ? Theme.textMuted : Theme.accent
          }

          StyledText {
            Layout.fillWidth: true
            text: row.modelData.label
          }
        }

        MouseArea {
          id: mouse

          anchors.fill: parent
          hoverEnabled: true

          onClicked: root.activate(row.modelData)
        }
      }
    }
  }

  ConfirmDialog {
    id: confirm

    anchors.fill: parent
    visible: root.pending !== null
    message: `${root.pending?.label ?? ""}?`
    confirmLabel: root.pending?.label ?? ""

    onConfirmed: root.runPending()
    onCancelled: root.pending = null
  }
}
