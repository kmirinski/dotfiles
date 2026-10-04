pragma Singleton

import Quickshell

// Nerd Font glyphs, referenced by codepoint so the source stays readable and
// greppable instead of holding invisible characters.
//
// Every codepoint here is verified present in JetBrainsMono Nerd Font. Check
// before adding: plenty of plausible ones (nf-fa-memory U+F538, for instance)
// are absent and render as a tofu box with no error.
Singleton {
  id: root

  readonly property string cpu: String.fromCodePoint(0xf4bc) // nf-oct-cpu
  // Font Awesome, not Nerd Font - render this one with Style.iconFamilyFa
  readonly property string memory: String.fromCodePoint(0xf538) // fa-memory

  // --- Network ---
  readonly property string wifi: String.fromCodePoint(0xf1eb)
  readonly property string wifiOff: String.fromCodePoint(0xf05aa) // nf-md-wifi-off
  readonly property string ethernet: String.fromCodePoint(0xf1e6)
  readonly property string lock: String.fromCodePoint(0xf023)

  readonly property string check: String.fromCodePoint(0xf00c)
  readonly property string close: String.fromCodePoint(0xf00d)

  // --- Bluetooth ---
  readonly property string bluetooth: String.fromCodePoint(0xf293)
  readonly property string bluetoothOff: String.fromCodePoint(0xf0928) // nf-md-bluetooth-off

  // --- Battery ---
  // Index by quarter: 0 = empty ... 4 = full
  readonly property var batteryLevels: [String.fromCodePoint(0xf244), String.fromCodePoint(0xf243), String.fromCodePoint(0xf242), String.fromCodePoint(0xf241), String.fromCodePoint(0xf240)]
  readonly property string charging: String.fromCodePoint(0xf0e7)

  // power profiles - deliberately avoiding the bolt, which already means
  // "charging" in the same popup
  readonly property string profileSaver: String.fromCodePoint(0xf06c) // leaf
  readonly property string profileBalanced: String.fromCodePoint(0xf24e) // balance-scale
  readonly property string profilePerformance: String.fromCodePoint(0xf135) // rocket

  // --- power menu ---
  readonly property string power: String.fromCodePoint(0xf011)
  readonly property string logout: String.fromCodePoint(0xf2f5)
  readonly property string restart: String.fromCodePoint(0xf01e)
  readonly property string suspend: String.fromCodePoint(0xf186)

  // --- Media (all in the Nerd Font's Font Awesome 4 range) ---
  readonly property string music: String.fromCodePoint(0xf001)
  readonly property string play: String.fromCodePoint(0xf04b)
  readonly property string pause: String.fromCodePoint(0xf04c)
  readonly property string next: String.fromCodePoint(0xf051)
  readonly property string previous: String.fromCodePoint(0xf048)
}
