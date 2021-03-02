import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ListView {
    clip: true
    spacing: 8
    signal removePressed(int index)
    signal quantidadeChanged()
    delegate: Card {
        height: 50
        width: parent.width
        RowLayout {
            anchors {
                fill: parent
                leftMargin: 16
                rightMargin: 16
            }

            Text {
                Layout.fillWidth: true
                text: model.name
            }

            Button {
                text: "-"
                enabled: model.quantidade > 0
                onPressed: {
                    if(model.quantidade == 1) {
                        removePressed(index)
                        return
                    }
                    model.quantidade -= 1
                    quantidadeChanged();
                }
            }

            Text {
                text: model.quantidade + "x"
            }

            Button {
                text: "+"
                onPressed: {
                    model.quantidade += 1
                    quantidadeChanged();
                }
            }

            Text {
                Layout.fillWidth: true
                text: model.price
                horizontalAlignment: Text.AlignRight
            }
            Button {
                Material.foreground: "white"
                background: Rectangle {
                    color: "#146d99"
                    radius: 16
                }

                text: "Remover"
                onPressed: {
                    removePressed(index)
                }
            }
        }
    }
}
