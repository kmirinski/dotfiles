import QtQuick

import qs.components
import qs.services
import qs.theme

// CPU and memory as icon + percentage
BarItem {
  interactive: false
  spacing: Style.spacingMd

  component Readout: Row {
    id: readout

    required property string glyph
    required property real value
    // Which font the glyph comes from - a few icons aren't in the Nerd Font
    property string glyphFamily: Style.iconFamily
    property string glyphStyle: ""

    spacing: Style.spacingXs

    StyledText {
      anchors.verticalCenter: parent.verticalCenter
      text: readout.glyph
      font.family: readout.glyphFamily
      font.styleName: readout.glyphStyle
      font.pixelSize: Style.iconSize
      color: Theme.textMuted
    }

    StyledText {
      anchors.verticalCenter: parent.verticalCenter
      // padded to 3 chars so the bar doesn't shift as the number gains a digit
      text: `${String(Math.round(readout.value)).padStart(3, " ")}%`
      font.family: Style.monoFamily
    }
  }

  Readout {
    glyph: Icons.cpu
    value: SysInfo.cpuPerc
  }

  Readout {
    glyph: Icons.memory
    glyphFamily: Style.iconFamilyFa
    glyphStyle: Style.iconStyleFa
    value: SysInfo.memPerc
  }
}
