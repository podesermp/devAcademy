import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

ListView {
    signal addButtonPressed(var fruta)
    signal removeButtonPressed(var fruta)
    signal updateButtonPressed(var fruta)
    clip: true
    spacing: 8
    delegate: Card {
        width: parent.width
        height: 64
        GridLayout {
            columnSpacing: 8
            columns: 6
            anchors.fill: parent
            anchors.margins: 8

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Nome"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Calorias"
                    anchors.fill: parent
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: "Preço"
                    anchors.fill: parent
                }
            }

            Button {
                Layout.rowSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/carrinho.png"
                }

                onPressed: {
                    const fruta = {
                        id: model.id,
                        name: model.nome,
                        price: model.preco
                    }
                    addButtonPressed(fruta)
                }
            }

            Button {
                Layout.rowSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/editar.png"
                }

                onPressed: {
                    const fruta = {
                        nome: model.nome,
                        preco: model.preco,
                        calorias: model.calorias,
                        index: index,
                        id: model.id
                    }
                    updateButtonPressed(fruta)
                }
            }

            Button {
                Layout.rowSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/remover.png"
                }

                onPressed: {
                    const fruta = {
                        nome: model.nome,
                        index: index,
                        id: model.id
                    }
                    removeButtonPressed(fruta)
                }
            }

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.nome
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }


            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.calorias
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }


            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Text {
                    text: model.preco
                    anchors.fill: parent
                    font.pixelSize: 22
                }
            }
        }
    }
}
