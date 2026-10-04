import QtQuick

import qs.theme

// labelled button
//
// hover and press shade the base colour rather than overlaying Theme.hover,
// because a translucent overlay would composite against the popup surface
// instead of the button
Rectangle {
  id: root

  property string label
  // red fill, for actions that lose work
  property bool destructive: false

  readonly property color base: root.destructive ? Theme.error : Theme.surfaceAlt

  signal clicked

  implicitWidth: labelText.implicitWidth + Style.spacingLg * 2
  implicitHeight: Style.popupRowHeight
  radius: Style.radiusSm

  color: {
    if (mouse.containsPress)
      return Qt.darker(root.base, 1.15);
    if (mouse.containsMouse)
      return Qt.lighter(root.base, 1.25);
    return root.base;
  }

  Behavior on color {
    ColorAnimation {
      duration: Style.durationFast
    }
  }

  StyledText {
    id: labelText

    anchors.centerIn: parent
    text: root.label
    color: root.destructive ? Theme.background : Theme.text
  }

  MouseArea {
    id: mouse

    anchors.fill: parent
    hoverEnabled: true

    onClicked: root.clicked()
  }
}
