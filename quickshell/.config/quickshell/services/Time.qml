pragma Singleton

import Quickshell
import QtQuick

import qs

// Date and time as separate strings so the bar can style them independently.
Singleton {
  id: root

  readonly property string date: Qt.formatDateTime(clock.date, Config.dateFormat)
  // readonly property string date: "kur"
  readonly property string time: Qt.formatDateTime(clock.date, Config.timeFormat)

  SystemClock {
    id: clock

    precision: SystemClock.Minutes
  }
}
