pragma Singleton

import Quickshell

// single source of truth for whether the session is locked
//
// the lock screen, the power menu and the ipc handler all go through this
// rather than poking WlSessionLock directly, so there's one place that can
// flip the state - including the escape hatch from a tty
Singleton {
  id: root

  property bool locked: false

  function lock() {
    root.locked = true;
  }

  function unlock() {
    root.locked = false;
  }
}
