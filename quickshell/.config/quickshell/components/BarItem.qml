import QtQuick

import qs.theme

Rectangle {
  id: root

  default property alias content: row.data
  property alias spacing: row.spacing

  property bool interactive: true
  // Draw the hover background permanently — used to show an open popup or a
  // focused workspace.
  property bool active: false

  signal clicked
  signal rightClicked
  signal scrolled(int delta)

  implicitWidth: row.implicitWidth + Style.itemPaddingH * 2
  implicitHeight: row.implicitHeight + Style.itemPaddingV * 2
  radius: Style.radiusSm

  color: {
    if (!interactive)
      return Theme.transparent;
    if (mouse.containsPress)
      return Theme.pressed;
    if (mouse.containsMouse || active)
      return Theme.hover;
    return Theme.transparent;
  }

  Behavior on color {
    ColorAnimation {
      duration: Style.durationFast
    }
  }

  Row {
    id: row

    anchors.centerIn: parent
    spacing: Style.spacingXs
  }

  MouseArea {
    id: mouse

    anchors.fill: parent
    enabled: root.interactive
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton | Qt.RightButton

    onClicked: event => event.button === Qt.RightButton ? root.rightClicked() : root.clicked()
    onWheel: event => root.scrolled(event.angleDelta.y)
  }
}
