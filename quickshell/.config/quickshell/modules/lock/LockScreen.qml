import Quickshell
import Quickshell.Wayland

import qs.services
import qs.theme

// binds the session lock to SessionLock.locked
//
// the compositor creates one surface per monitor from the `surface` component.
// note that ext-session-lock keeps the session locked if this client dies, by
// design - so killing quickshell does NOT get you out
//
// RESCUE, from a tty (ctrl+alt+f3):
//
//   WAYLAND_DISPLAY=wayland-1 qs ipc call lock unlock
//
// the WAYLAND_DISPLAY is required - qs matches instances by display, and a tty
// has none, so a bare `qs ipc call` fails with "no running instances".
// `qs ipc --pid <pid> call lock unlock` works too
Scope {
  WlSessionLock {
    id: lock

    locked: SessionLock.locked

    surface: WlSessionLockSurface {
      color: Theme.background

      LockSurface {
        anchors.fill: parent

        onUnlocked: SessionLock.unlock()
      }
    }
  }
}
