import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services
import qs.theme

PopupPanel {
  id: root

  readonly property var player: Players.active

  // MPRIS position does not tick on its own - it only changes when something
  // seeks - so the progress bar re-reads it on a timer while the popup is open
  property real position: 0

  readonly property real length: root.player?.length ?? 0
  readonly property real progress: root.length > 0 ? Math.min(1, root.position / root.length) : 0

  implicitWidth: Style.mediaPopupWidth
  implicitHeight: layout.implicitHeight + root.padding * 2

  onVisibleChanged: if (root.visible)
    root.position = root.player?.position ?? 0

  // Last player went away - close rather than sit there showing a dead track
  onPlayerChanged: if (!root.player)
    root.visible = false

  function formatTime(seconds) {
    if (!seconds || seconds < 0)
      return "0:00";
    const total = Math.floor(seconds);
    const mins = Math.floor(total / 60);
    const secs = total % 60;
    return `${mins}:${String(secs).padStart(2, "0")}`;
  }

  ColumnLayout {
    id: layout

    anchors.fill: parent
    spacing: Style.spacingMd

    RowLayout {
      Layout.fillWidth: true
      spacing: Style.spacingMd

      Rectangle {
        implicitWidth: Style.mediaArtSize
        implicitHeight: Style.mediaArtSize
        radius: Style.radiusSm
        color: Theme.surfaceAlt
        clip: true

        Image {
          id: art

          anchors.fill: parent
          source: root.player?.trackArtUrl ?? ""
          fillMode: Image.PreserveAspectCrop
          asynchronous: true
          visible: art.status === Image.Ready
        }

        // spotify serves art over https, so it can be slow or fail outright -
        // show a glyph rather than an empty box
        StyledText {
          anchors.centerIn: parent

          visible: !art.visible
          text: Icons.music
          font.family: Style.iconFamily
          font.pixelSize: Style.fontSizeLg
          color: Theme.textDim
        }
      }
      
      ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.spacingXs

        StyledText {
          Layout.fillWidth: true
          text: root.player?.trackTitle || "Nothing playing"
          font.bold: true
          elide: Text.ElideRight
        }

        StyledText {
          Layout.fillWidth: true
          visible: text !== ""
          text: root.player?.trackArtist ?? ""
          color: Theme.textMuted
          elide: Text.ElideRight
        }

        StyledText {
          Layout.fillWidth: true
          visible: text !== ""
          text: root.player?.trackAlbum ?? ""
          color: Theme.textDim
          font.pixelSize: Style.fontSizeSm
          elide: Text.ElideRight
        }
      }
    }

    ColumnLayout {
      Layout.fillWidth: true
      spacing: Style.spacingXs
      visible: root.length > 0

      Rectangle {
        id: track

        Layout.fillWidth: true
        implicitHeight: 4
        radius: height / 2
        color: Theme.surfaceAlt

        Rectangle {
          width: track.width * root.progress
          height: track.height
          radius: track.radius
          color: Theme.accent
        }

        MouseArea {
          anchors.fill: parent
          enabled: root.player?.canSeek ?? false

          onClicked: event => {
            const target = (event.x / track.width) * root.length;
            root.player.position = target;
            root.position = target;
          }
        }
      }

      RowLayout {
        Layout.fillWidth: true

        StyledText {
          text: root.formatTime(root.position)
          font.family: Style.monoFamily
          font.pixelSize: Style.fontSizeSm
          color: Theme.textMuted
        }

        Item {
          Layout.fillWidth: true
        }

        StyledText {
          text: root.formatTime(root.length)
          font.family: Style.monoFamily
          font.pixelSize: Style.fontSizeSm
          color: Theme.textMuted
        }
      }
    }

    RowLayout {
      Layout.alignment: Qt.AlignHCenter
      spacing: Style.spacingSm

      IconButton {
        glyph: Icons.previous
        enabled: root.player?.canGoPrevious ?? false

        onClicked: root.player.previous()
      }

      IconButton {
        glyph: root.player?.isPlaying ? Icons.pause : Icons.play
        enabled: root.player?.canTogglePlaying ?? false

        onClicked: root.player.togglePlaying()
      }

      IconButton {
        glyph: Icons.next
        enabled: root.player?.canGoNext ?? false

        onClicked: root.player.next()
      }
    }
  }

  Timer {
    running: root.visible && (root.player?.isPlaying ?? false)
    interval: 1000
    repeat: true

    onTriggered: root.position = root.player?.position ?? 0
  }
}
