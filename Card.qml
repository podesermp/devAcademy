import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0

Item {
    id: cardItem
    property int elevation: 1
    property alias color: rect.color
    Rectangle {
        id: rect
        anchors.fill: parent
        color: "white"
        radius: 4
        layer.enabled: cardItem.elevation > 0
        layer.effect: ElevationEffect {
            elevation: cardItem.elevation
        }
    }
}
