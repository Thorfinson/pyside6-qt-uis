import QtQuick 6
import QtQuick.Controls.Material 2.15
Rectangle {
  property var toFill: parent          // instantiation site "can" (optionally) override
  property color customColor: 'black' // instantiation site "can" (optionally) override
  property int customThickness: 1      // instantiation site "can" (optionally) override

  anchors.fill: toFill
  z: -1
  color: Material.color(Material.Grey)
  border.color: customColor
  border.width: customThickness
}
