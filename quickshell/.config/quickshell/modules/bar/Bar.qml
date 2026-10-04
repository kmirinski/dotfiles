import Quickshell
import QtQuick

import qs.theme
import qs.modules.bar.widgets

// Top bar, one per monitor.
//
// Three zones. Left and right are anchored to their edges and the clock is
// anchored to the window centre — so the clock stays centred on screen no
// matter how wide the side zones grow.
Scope {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData

      screen: modelData
      color: Theme.background
      implicitHeight: Style.barHeight

      anchors {
        top: true
        left: true
        right: true
      }

      Item {
        anchors.fill: parent
        anchors.leftMargin: Style.barPadding
        anchors.rightMargin: Style.barPadding

        WorkspacesWidget {
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
        }

        ClockWidget {
          anchors.centerIn: parent
        }

        // Later widgets (media, network, bluetooth, battery, tray, power)
        // append to this row.
        Row {
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: Style.barItemSpacing

          MediaWidget {}

          MetricsWidget {}

          NetworkWidget {}

          BluetoothWidget {}

          BatteryWidget {}

          PowerWidget {}
        }
      }
    }
  }
}
