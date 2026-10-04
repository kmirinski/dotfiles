pragma Singleton

import Quickshell
import QtQuick

Singleton {
  id: root

  // --- Surfaces ----------------------------------------------------------
  readonly property color background: TokyoNight.bg
  readonly property color surface: TokyoNight.bgHighlight
  readonly property color surfaceAlt: TokyoNight.bgDark
  readonly property color border: TokyoNight.fgGutter

  // --- Text --------------------------------------------------------------
  readonly property color text: TokyoNight.fg
  readonly property color textMuted: TokyoNight.comment
  // For things that are present but inactive
  readonly property color textDim: TokyoNight.terminalBlack

  // --- Accents -----------------------------------------------------------
  readonly property color accent: TokyoNight.blue
  readonly property color accentBright: TokyoNight.blue2

  // --- Status ------------------------------------------------------------
  readonly property color success: TokyoNight.green
  readonly property color warning: TokyoNight.yellow
  readonly property color error: TokyoNight.red
  readonly property color info: TokyoNight.cyan

  // --- Interaction states ------------------------------------------------
  // Kept as translucent overlays so they work over any surface colour.
  readonly property color hover: Qt.alpha(TokyoNight.fg, 0.10)
  readonly property color pressed: Qt.alpha(TokyoNight.fg, 0.18)
  readonly property color transparent: "transparent"
}
