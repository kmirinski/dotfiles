import Quickshell

import qs.ipc
import qs.modules.bar
import qs.modules.lock

// entry point. composes top-level surfaces only - no ui logic lives here
ShellRoot {
  Bar {}
  LockScreen {}
  Ipc {}
}
