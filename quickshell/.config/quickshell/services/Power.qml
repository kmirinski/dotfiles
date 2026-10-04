pragma Singleton

import Quickshell
import Quickshell.Services.UPower

import qs

// battery state and power profiles
Singleton {
  id: root

  readonly property var battery: UPower.displayDevice

  // upower populates over DBus a second or so after startup, so everything
  // reads zero until `ready` flips
  readonly property bool available: (root.battery?.ready ?? false) && (root.battery?.isPresent ?? false)

  // upower reports a 0-1 fraction: everything here is 0-100 for display
  readonly property real percent: (root.battery?.percentage ?? 0) * 100

  readonly property int state: root.battery?.state ?? UPowerDeviceState.Unknown
  readonly property bool charging: root.state === UPowerDeviceState.Charging
  readonly property bool full: root.state === UPowerDeviceState.FullyCharged
  readonly property bool onBattery: UPower.onBattery
  
  // seconds
  readonly property real timeRemaining: root.charging ? (root.battery?.timeToFull ?? 0) : (root.battery?.timeToEmpty ?? 0)
  
  readonly property bool low: root.available && !root.charging && root.percent <= Config.batteryLowPercent
  readonly property bool critical: root.available && !root.charging && root.percent <= Config.batteryCriticalPercent
  
  // not every battery reports wear, so callers must check before showing it
  readonly property bool healthSupported: root.battery?.healthSupported ?? false
  readonly property real health: (root.battery?.healthPercentage ?? 0)

  // PowerProfiles is the singleton; PowerProfile (no s) is just the enum
  readonly property int profile: PowerProfiles.profile
  readonly property bool hasPerformanceProfile: PowerProfiles.hasPerformanceProfile

  function setProfile(p) {
    PowerProfiles.profile = p;
  }
  
  // seconds -> "3h 42m"
  function formatDuration(seconds) {
    if (!seconds || seconds <= 0)
      return "";
    const total = Math.round(seconds / 60);
    const hours = Math.floor(total / 60);
    const mins = total % 60;
    return hours > 0 ? `${hours}h ${mins}m` : `${mins}m`;
  } 
}
