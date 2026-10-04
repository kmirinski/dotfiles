import QtQuick

import qs.theme

// small on/off switch
//
// emits toggled() rather than flipping itself - the real state lives in a
// service, so the parent decides what to do and `checked` follows that
Rectangle {
  id: root

  property bool checked: false

  signal toggled(bool value)

  implicitWidth: Style.toggleWidth
  implicitHeight: Style.toggleHeight
  radius: height / 2
  color: root.checked ? Theme.accent : Theme.surfaceAlt
  border.width: 1
  border.color: root.checked ? Theme.accent : Theme.border
  opacity: root.enabled ? 1 : 0.4

  Behavior on color {
    ColorAnimation {
      duration: Style.durationFast
    }
  }

  Rectangle {
    id: knob

    width: root.height - 6
    height: width
    radius: width / 2
    y: 3
    x: root.checked ? root.width - width - 3 : 3
    color: root.checked ? Theme.background : Theme.textMuted

    Behavior on x {
      NumberAnimation {
        duration: Style.duration
        easing.type: Easing.OutCubic
      }
    }

    Behavior on color {
      ColorAnimation {
        duration: Style.durationFast
      }
    }
  }

  MouseArea {
    anchors.fill: parent

    onClicked: root.toggled(!root.checked)
  }
}
