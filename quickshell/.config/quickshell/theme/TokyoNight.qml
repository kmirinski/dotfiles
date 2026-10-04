pragma Singleton

import Quickshell
import QtQuick

// Raw Tokyo Night (night variant) colour values.
//
// Nothing outside theme/ should read this — widgets use Theme.qml, which maps
// these onto semantic roles. A second theme is a sibling file plus a remap.
//
// Not named Palette: that collides with a built-in QtQuick type and silently
// resolves to it instead, leaving every colour undefined.
Singleton {
  id: root

  readonly property color bg: "#1a1b26"
  readonly property color bgDark: "#16161e"
  readonly property color bgHighlight: "#292e42"
  readonly property color fg: "#c0caf5"
  readonly property color fgDark: "#a9b1d6"
  readonly property color fgGutter: "#3b4261"
  readonly property color comment: "#565f89"
  readonly property color terminalBlack: "#414868"
  readonly property color dark3: "#545c7e"
  readonly property color dark5: "#737aa2"

  // Accents
  readonly property color red: "#f7768e"
  readonly property color red1: "#db4b4b"
  readonly property color orange: "#ff9e64"
  readonly property color yellow: "#e0af68"
  readonly property color green: "#9ece6a"
  readonly property color green1: "#73daca"
  readonly property color green2: "#41a6b5"
  readonly property color teal: "#1abc9c"
  readonly property color cyan: "#7dcfff"
  readonly property color blue: "#7aa2f7"
  readonly property color blue0: "#3d59a1"
  readonly property color blue1: "#2ac3de"
  readonly property color blue2: "#0db9d7"
  readonly property color blue5: "#89ddff"
  readonly property color blue6: "#b4f9f8"
  readonly property color blue7: "#394b70"
  readonly property color magenta: "#bb9af7"
  readonly property color magenta2: "#ff007c"
  readonly property color purple: "#9d7cd8"
}
