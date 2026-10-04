import Quickshell
import QtQuick

import qs.theme

// styled popup hanging below a bar item. Clicking anywhere else dismisses it.
//
// consumers must set implicitWidth and implicitHeight
PopupWindow {
  id: root

  required property Item anchorItem
  default property alias content: container.data
  property int padding: Style.popupPadding

  anchor.item: root.anchorItem
  // attach to the bottom edge of the bar item and grow downwards
  anchor.edges: Edges.Bottom
  anchor.gravity: Edges.Bottom
  anchor.margins.top: Style.popupGap

  // the window itself is transparent; the rounded rectangle below is the
  // surface you actually see
  color: Theme.transparent
  visible: false

  // Clicking outside dismisses the popup and sets visible back to false.
  // Must be set statically - changing it while the window is open only takes
  // effect after it's hidden and shown again.
  grabFocus: true

  Rectangle {
    anchors.fill: parent

    color: Theme.surface
    radius: Style.radiusMd
    border.width: 1
    border.color: Theme.border
  }

  Item {
    id: container

    anchors.fill: parent
    anchors.margins: root.padding
  }
}
