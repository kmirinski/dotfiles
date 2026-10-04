import QtQuick

import qs.components
import qs.modules.bar.popups
import qs.services
import qs.theme

// Track info in the bar; click opens the full controls
BarItem {
  id: root

  readonly property var player: Players.active

  readonly property string label: {
    const p = root.player;
    if (!p)
      return "";
    const title = p.trackTitle || "Unknown";
    return p.trackArtist ? `${title} — ${p.trackArtist}` : title;
  }

  // Held in its own property rather than as a default child, so the popup
  // window doesn't get handed to BarItem's layout row
  readonly property MediaPopup popup: MediaPopup {
    anchorItem: root
  }

  visible: Players.available
  active: root.popup.visible

  // The popup is its own window, so hiding this widget doesn't hide it. Without
  // this it's left on screen with nothing left to toggle it shut.
  onVisibleChanged: if (!root.visible)
    root.popup.visible = false

  onClicked: root.popup.visible = !root.popup.visible

  onScrolled: delta => {
    const p = root.player;
    if (!p || !p.volumeSupported)
      return;
    p.volume = Math.max(0, Math.min(1, p.volume + (delta > 0 ? 0.05 : -0.05)));
  }

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: Icons.music
    font.family: Style.iconFamily
    font.pixelSize: Style.iconSize
    color: root.player?.isPlaying ? Theme.accent : Theme.textMuted
  }

  StyledText {
    anchors.verticalCenter: parent.verticalCenter

    text: root.label
    elide: Text.ElideRight
    // implicitWidth is the un-elided width, so this caps it and elides past it
    width: Math.min(implicitWidth, Style.mediaMaxWidth)
  }
}
