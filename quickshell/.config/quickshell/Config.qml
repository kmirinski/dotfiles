pragma Singleton

import Quickshell

Singleton {
  id: root

  // -- Bar ---
  readonly property int workspaceCount: 9

  // --- Date and Time ---
  readonly property string dateFormat: "ddd MMM d"
  readonly property string timeFormat: "HH:mm"

  // --- Metrics ---
  readonly property int metricsInterval: 2000 // in ms

  // --- Lock screen ---
  // name of a file in /etc/pam.d. "login" needs no new file; hyprlock's own
  // config is just "auth include login", so both use the same auth stack
  readonly property string pamConfig: "login"
  readonly property int maxUnlockAttempts: 5

  // --- Battery ---
  readonly property int batteryLowPercent: 20
  readonly property int batteryCriticalPercent: 10

  // --- Wallpaper ---
  readonly property string wallpaperDir: `${Quickshell.env("HOME")}/.config/hypr/wallpapers`
}
