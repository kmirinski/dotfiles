import Quickshell
import Quickshell.Io

import qs.services

// external control surface, for hyprland keybinds and for rescuing yourself
// from a tty:
//
//   qs ipc call lock lock
//   qs ipc call lock unlock     <- works even if the lock ui is broken
//   qs ipc call lock status
Scope {
  IpcHandler {
    target: "lock"

    function lock(): void {
      SessionLock.lock();
    }

    function unlock(): void {
      SessionLock.unlock();
    }

    function status(): string {
      return SessionLock.locked ? "locked" : "unlocked";
    }
  }
}
