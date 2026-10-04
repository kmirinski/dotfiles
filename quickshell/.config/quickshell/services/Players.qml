pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

// Picks one active player out of everything on MPRIS
//
// Prefers whatever is playing and then stays on it, so the bar doesn't flicker
// between Spotify and a browser when both are open
Singleton {
  id: root

  property MprisPlayer active: null

  readonly property bool available: root.active !== null

  readonly property var all: Mpris.players.values

  // Reading isPlaying inside the filter is what makes this binding depend on
  // every player's state, so it re-runs whenever any of them starts or stops
  readonly property var playing: root.all.filter(p => p.isPlaying)

  onAllChanged: root.select()
  onPlayingChanged: root.select()

  function select() {
    const ps = root.all;

    if (ps.length === 0) {
      root.active = null;
      return;
    }
    
    // stay put while the current one is still playing
    if (root.active && ps.includes(root.active) && root.active.isPlaying)
      return;
    
    const nowPlaying = ps.find(p => p.isPlaying);
    if (nowPlaying) {
      root.active = nowPlaying;
      return;
    }
    
    // nothing is playing - keep the current one rather than jumping away
    if (root.active && ps.includes(root.active))
      return;

    root.active = ps[0];
  }
}
