import QtQuick
import QtQuick.Layouts

import qs.theme

// inline confirmation, meant to replace a popup's normal content rather than
// open a window of its own - a second popup would fight the first for the
// focus grab
ColumnLayout {
  id: root

  property string message
  property string confirmLabel: "confirm"

  signal confirmed
  signal cancelled

  spacing: Style.spacingMd

  StyledText {
    Layout.fillWidth: true
    text: root.message
    wrapMode: Text.WordWrap
    horizontalAlignment: Text.AlignHCenter
  }

  RowLayout {
    Layout.fillWidth: true
    spacing: Style.spacingSm

    // cancel sits first so the destructive button isn't under the cursor
    // when the dialog appears
    TextButton {
      Layout.fillWidth: true
      label: "cancel"

      onClicked: root.cancelled()
    }

    TextButton {
      Layout.fillWidth: true
      label: root.confirmLabel
      destructive: true

      onClicked: root.confirmed()
    }
  }
}
