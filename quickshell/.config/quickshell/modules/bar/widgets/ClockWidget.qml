import qs.components
import qs.services
import qs.theme

BarItem {
  interactive: false
  spacing: Style.spacingMd

  StyledText {
    text: Time.date
    color: Theme.textMuted
  }

  StyledText {
    text: Time.time
    font.family: Style.monoFamily
    font.bold: true
  }
}
