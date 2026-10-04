import QtQuick

import qs.theme

// round icon button for popup controls
//
// uses Item's built-in `enabled` rather than declaring its own - setting
// enabled: false also disables the MouseArea for free
Rectangle {
  id: root

  property string glyph
  property int glyphSize: Style.iconSize

  signal clicked

  implicitWidth: Style.iconButtonSize
  implicitHeight: Style.iconButtonSize
  radius: width / 2

  color: {
    if (!root.enabled)
      return Theme.transparent;
    if (mouse.containsPress)
      return Theme.pressed;
    if (mouse.containsMouse)
      return Theme.hover;
    return Theme.transparent;
  }

  Behavior on color {
    ColorAnimation {
      duration: Style.durationFast
    }
  }

  Text {
    anchors.centerIn: parent

    text: root.glyph
    font.family: Style.iconFamily
    font.pixelSize: root.glyphSize
    color: root.enabled ? Theme.text : Theme.textDim
  }

  MouseArea {
    id: mouse

    anchors.fill: parent
    hoverEnabled: true

    onClicked: root.clicked()
  }
}
