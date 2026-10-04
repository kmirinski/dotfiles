import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pam

import qs
import qs.components
import qs.theme

// password prompt backed by real PAM authentication
//
// deliberately independent of WlSessionLock so it can be tested in an ordinary
// window first - a bug found here costs nothing, the same bug found behind a
// session lock costs you a tty trip
Item {
  id: root

  signal authenticated

  property string password: ""
  property string status: ""
  property bool statusIsError: false
  property int failures: 0

  readonly property bool busy: pam.active
  readonly property bool lockedOut: root.failures >= Config.maxUnlockAttempts

  implicitWidth: layout.implicitWidth
  implicitHeight: layout.implicitHeight

  function submit() {
    if (root.password.length === 0 || pam.active || root.lockedOut)
      return;
    root.status = "";
    root.statusIsError = false;
    pam.start();
  }

  function reset() {
    root.password = "";
    root.status = "";
    root.statusIsError = false;
    root.failures = 0;
    if (pam.active)
      pam.abort();
  }

  PamContext {
    id: pam

    config: Config.pamConfig
    user: Quickshell.env("USER")

    // pam asks for the password through this rather than taking it upfront
    onPamMessage: {
      if (pam.responseRequired) {
        pam.respond(root.password);
        return;
      }
      if (pam.message !== "") {
        root.status = pam.message;
        root.statusIsError = pam.messageIsError;
      }
    }

    onCompleted: result => {
      root.password = "";

      if (result === PamResult.Success) {
        root.failures = 0;
        root.status = "";
        root.statusIsError = false;
        root.authenticated();
        return;
      }

      root.failures++;
      root.statusIsError = true;
      root.status = result === PamResult.MaxTries ? "too many attempts" : "incorrect password";
    }

    // start failed, or pam itself broke - distinct from a wrong password
    onError: err => {
      root.password = "";
      root.statusIsError = true;
      root.status = `pam error: ${PamError.toString(err)}`;
    }
  }

  ColumnLayout {
    id: layout

    anchors.fill: parent
    spacing: Style.spacingMd

    StyledText {
      Layout.alignment: Qt.AlignHCenter
      text: Quickshell.env("USER")
      font.pixelSize: Style.fontSizeLg
      font.bold: true
    }

    Rectangle {
      Layout.fillWidth: true
      implicitHeight: Style.popupRowHeight + 6
      radius: Style.radiusMd
      color: Theme.surfaceAlt
      border.width: 1
      border.color: {
        if (root.statusIsError)
          return Theme.error;
        return input.activeFocus ? Theme.accent : Theme.border;
      }

      Behavior on border.color {
        ColorAnimation {
          duration: Style.durationFast
        }
      }

      TextInput {
        id: input

        anchors.fill: parent
        anchors.leftMargin: Style.spacingMd
        anchors.rightMargin: Style.spacingMd
        verticalAlignment: TextInput.AlignVCenter
        echoMode: TextInput.Password
        enabled: !root.busy && !root.lockedOut
        color: Theme.text
        font.family: Style.fontFamily
        font.pixelSize: Style.fontSize
        selectByMouse: true
        selectionColor: Theme.accent

        focus: true
        text: root.password

        onTextChanged: root.password = text
        onAccepted: root.submit()
      }

      StyledText {
        anchors.left: parent.left
        anchors.leftMargin: Style.spacingMd
        anchors.verticalCenter: parent.verticalCenter

        visible: root.password.length === 0 && !root.busy
        text: "password"
        color: Theme.textDim
      }
    }

    StyledText {
      Layout.alignment: Qt.AlignHCenter
      Layout.fillWidth: true

      // keeps the layout from jumping as the message comes and goes
      visible: true
      text: {
        if (root.busy)
          return "checking...";
        if (root.status !== "")
          return root.status;
        return " ";
      }
      horizontalAlignment: Text.AlignHCenter
      color: root.statusIsError ? Theme.error : Theme.textMuted
      font.pixelSize: Style.fontSizeSm
    }
  }
}
