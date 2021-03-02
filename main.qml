import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3

import Models 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt Dev.Academy")
    color: "#fafafa"

    RemoveFrutaDialog {
        id: removeFrutaDialog
        onAccepted: {
            dbFrutas.deleteRow(fruta.id)
        }
    }

    AddFrutaDialog {
        id: addFrutaDialog
        onCancelPressed: {
            addFrutaDialog.clearFields()
            addFrutaDialog.close()
        }
        onOkPressed: {
            dbFrutas.newRow(name, price, calories)
            addFrutaDialog.clearFields()
            addFrutaDialog.close()
        }
    }

    AddFrutaDialog {
        id: updateFrutaDialog
        title: "Editar fruta"
        onCancelPressed: {
            updateFrutaDialog.close()
        }
        onOkPressed: {
            dbFrutas.updateRow(id, name, price, calories)
            updateFrutaDialog.close()
        }
    }

    FrutaDatabaseModel {
        id: dbFrutas
    }

    FrutaListModel {
        id: frutas
        Component.onCompleted: {
            frutas.insertFruta("Tangerina", 5.55, 100)
        }
    }

    ListModel {
        id: carrinho
        function getTotal() {
            let total = 0;
            for(let i = 0; i < carrinho.rowCount(); i++) {
                total += carrinho.get(i).price * carrinho.get(i).quantidade
            }
            return total;
        }
    }

    ColumnLayout {
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Text {
                text: `Carrinho do ${myModel.name}`
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            TextField {
                id: nameField
            }
            Button {
                text: "Salvar"
                enabled: nameField != ""
                onPressed: {
                    if(nameField != "") {
                        myModel.setName(nameField.text, myModel.id)
                    }
                }
            }
        }


        CarrinhoView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: carrinho
            onQuantidadeChanged: {
                totalText.text = "Total: " + carrinho.getTotal()
            }

            onRemovePressed: {
                carrinho.remove(index)
                totalText.text = "Total: " + carrinho.getTotal()
            }
        }

        Text {
            id: totalText
            text: "Total: " + carrinho.getTotal()
            Layout.fillWidth: true
            font.pixelSize: 20
        }

        RowLayout {
            Text {
                text: "Produtos"
                Layout.fillWidth: true
                font.pixelSize: 20
            }
            Button {

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                    anchors.margins: 16
                    source: "qrc:/icons/adicionar.png"
                }

                onPressed: {
                    addFrutaDialog.open()
                }
            }
        }

        FrutasView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: dbFrutas
            onAddButtonPressed: {
                fruta.quantidade = 1
                for(let i = 0; i < carrinho.rowCount(); i++) {
                    if(carrinho.get(i).id == fruta.id) {
                        carrinho.get(i).quantidade += 1
                        totalText.text = "Total: " + carrinho.getTotal()
                        return
                    }
                }
                carrinho.append(fruta)

                totalText.text = "Total: " + carrinho.getTotal()
            }
            onUpdateButtonPressed: {
                updateFrutaDialog.setFields(fruta)
                updateFrutaDialog.open()
            }
            onRemoveButtonPressed: {
                removeFrutaDialog.fruta = fruta
                removeFrutaDialog.open()
            }
        }
    }
}
