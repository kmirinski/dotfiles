import QtQuick

import qs.theme

// Text with the shell's defaults already applied. Use this instead of Text so
// font and colour decisions stay in theme/.
Text {
  color: Theme.text
  font.family: Style.fontFamily
  font.pixelSize: Style.fontSize
  verticalAlignment: Text.AlignVCenter
}
