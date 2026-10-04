import QtQuick
import Quickshell.Hyprland

import qs
import qs.components
import qs.theme

Row {
  id: root

  spacing: Style.barItemSpacing

  Repeater {
    model: Config.workspaceCount

    BarItem {
      id: item

      required property int index

      readonly property int wsId: index + 1
      readonly property bool occupied: Hyprland.workspaces.values.some(ws => ws.id === item.wsId)
      readonly property bool focused: Hyprland.focusedWorkspace?.id === item.wsId

      active: item.focused
      // This Hyprland uses the Lua config format, so dispatch takes a Lua expression
      onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${item.wsId} })`)

      StyledText {
        text: item.wsId
        font.bold: true
        color: item.focused ? Theme.accentBright : item.occupied ? Theme.accent : Theme.textDim
      }
    }
  }
}
