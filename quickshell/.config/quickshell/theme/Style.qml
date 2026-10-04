pragma Singleton

import Quickshell

Singleton {
  id: root

  // --- Bar ---
  readonly property int barHeight: 30
  readonly property int barPadding: 10
  readonly property int barItemSpacing: 4

  // --- Spacing scale ---
  readonly property int spacingXs: 4
  readonly property int spacingSm: 6
  readonly property int spacingMd: 10
  readonly property int spacingLg: 16
  readonly property int spacingXl: 24

  // --- Padding inside an interactive bar item ---
  readonly property int itemPaddingH: 8
  readonly property int itemPaddingV: 3

  // --- Radii ---
  readonly property int radiusSm: 4
  readonly property int radiusMd: 8
  readonly property int radiusLg: 12

  // --- Typography ---
  readonly property string fontFamily: "JetBrainsMono Nerd Font"
  // "Mono" variant forces Nerd glyphs into a single cell. Digits are equal
  // width, so the clock and metrics don't jitter the layout as they tick.
  readonly property string monoFamily: "JetBrainsMono Nerd Font Mono"
  readonly property string iconFamily: "JetBrainsMono Nerd Font"
  // Only for icons the Nerd Font lacks - it ships Font Awesome 4.7, which
  // predates the RAM stick.
  readonly property string iconFamilyFa: "Font Awesome 6 Free"
  readonly property string iconStyleFa: "Solid"

  readonly property int fontSizeSm: 12
  readonly property int fontSize: 14
  readonly property int fontSizeLg: 18
  readonly property int iconSize: 15
  // lock screen clock
  readonly property int fontSizeHuge: 64

  // --- Popups ---
  readonly property int popupPadding: 14
  // Gap between the bar and a popup hanging below it
  readonly property int popupGap: 6
  readonly property int iconButtonSize: 30

  // --- Media ---
  // Cap on the track text in the bar, so a long title can't shove the
  // clock off centre
  readonly property int mediaMaxWidth: 190
  readonly property int mediaArtSize: 72
  readonly property int mediaPopupWidth: 320

  // --- System popups ---
  readonly property int sysPopupWidth: 300
  readonly property int batteryPopupWidth: 250
  readonly property int popupRowHeight: 34
  // A popup list scrolls past this rather than growing without limit
  readonly property int popupListMaxHeight: 260
  readonly property int powerMenuWidth: 210
  readonly property int toggleWidth: 36
  readonly property int toggleHeight: 20

  // --- Animation ---
  readonly property int durationFast: 100
  readonly property int duration: 180
  readonly property int durationSlow: 400
}
