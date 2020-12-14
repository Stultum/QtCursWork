import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0


// Application Bar
Rectangle {

    id: menuRect

    anchors.fill: parent

    Rectangle {
        id: gridRect
        width: 900
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.leftMargin: 30
        anchors.topMargin: 50

        Item {
            id: dialogVars
            property int thisId: 0
            property string thisName: ""
            property string thisPrice: ""
            property string thisCategory: ""
            property string thisSize: ""
            property string thisMadeBy: ""
            property string thisImage: ""
            property string thisRecieveDate: ""
            property string thisMaleFemale: ""
            property string addOrChange: ""
            property bool addStatus: false
        }

        GridView {
            anchors.fill: parent
            id: clothesGrid
            width: 950
            height: 720
            cellWidth: 300
            cellHeight: 420
            focus: true
            model: onSaleModel

            delegate: Item {
                width: 250
                height: 360

                Rectangle {
                    border.color: "#578CBF"
                    border.width: 4
                    id: itemList
                    anchors.fill: parent
                    radius: 10
                    color: "#9ACDFF"

                    PropertyAnimation {
                        id: itemAnimOnHover
                        target: itemList
                        property: "color"
                        to: "#578CBF"
                        duration: 500
                    }

                    PropertyAnimation {
                        id: itemAnimOutHover
                        target: itemList
                        property: "color"
                        to: "#9ACDFF"
                        duration: 500
                    }

                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: false
                        radius: 2
                        samples: 5
                        horizontalOffset: 7
                        verticalOffset: 7
                        color: "#a9a9a9"
                    }

                    Image {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 10
                        id: clothesImage
                        source: imageModel
                        height: 250
                    }

                    Text {
                        anchors.margins: 15
                        id: clothesName
                        text: nameModel
                        anchors.top: clothesImage.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: dp(18)
                        renderType: Text.NativeRendering
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#1760A6"
                    }

                    Text {
                        anchors.margins: 5
                        id: clothesPrice
                        text: priceModel + " рублей"
                        anchors.top: clothesName.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        font.pixelSize: dp(24)
                        font.bold: true
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#1760A6"
                    }

                    MouseArea {
                        id: itemMouseArea
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: {
                            itemAnimOnHover.running = true
                        }
                        onClicked: {
                            dialogVars.thisId = idModel
                            dialogVars.thisName = nameModel
                            dialogVars.thisPrice = priceModel
                            dialogVars.thisCategory = categoryModel
                            dialogVars.thisSize = sizeModel
                            dialogVars.thisMadeBy = madebyModel
                            dialogVars.thisImage = imageModel
                            dialogVars.thisRecieveDate = recievedateModel
                            dialogVars.thisMaleFemale = maleorfemaleModel
                            moreDialog.open()
                        }

                        onExited: {
                            itemAnimOutHover.running = true
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: gridRect.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        color: "#9ACDFF"

        Text {
            id: title
            text: "Продажа одежды"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            font.bold: true
            font.pixelSize: dp(25)
            color: "#1760A6"

            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            anchors.leftMargin: 15
            anchors.topMargin: 40
            anchors.top: title.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            id: categoryComboBoxLabel
            font.family: "Times"
            font.pointSize: 13
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            text: "Поиск товара"
            color: "#1760A6"
        }

        TextField {
            anchors.topMargin: 20
            anchors.leftMargin: 15
            anchors.rightMargin: 15
            id: searchField
            height: 40
            anchors.top: categoryComboBoxLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            placeholderText: "Введите название товара"
            font.bold: true
            font.pointSize: 10
            maximumLength: 22
            font.italic: false
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#1760A6"
            onTextChanged: {
                onSaleModel.updateModelWithSearch(searchField.text)
            }
        }

        Button {
            anchors.topMargin: 30
            anchors.leftMargin: 60
            anchors.rightMargin: 60
            anchors.top: searchField.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            id: controlInShop

            contentItem: Text {
                text: qsTr("Показать все товары")
                font: controlInShop.font
                opacity: enabled ? 1.0 : 0.3
                color: controlInShop.down ? "#47A4FF" : "#1760A6"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: controlInShop.down ? "#47A4FF" : "#1760A6"
                border.width: 1
                radius: 4
            }
            onClicked: {
                onSaleModel.updateModel()
            }
        }
    }

    //Дилоговое окно с подробной информацией
    Dialog {
        id: moreDialog
        width: 400
        height: 640
        onClosed: {

            dialogVars.thisId = ""
            dialogVars.thisName = ""
            dialogVars.thisPrice = ""
            dialogVars.thisCategory = ""
            dialogVars.thisSize = ""
            dialogVars.thisMadeBy = ""
            dialogVars.thisImage = ""
            dialogVars.thisRecieveDate = ""
            dialogVars.thisMaleFemale = ""
        }

        enter: Transition {
            NumberAnimation {
                property: "x"
                from: -700
                to: 300
                duration: 400
            }
            NumberAnimation {
                property: "y"
                from: 50
                to: 50
                duration: 400
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "x"
                from: 300
                to: 1500
                duration: 100
            }
            NumberAnimation {
                property: "y"
                from: 50
                to: 50
                duration: 100
            }
        }

        Rectangle {
            border.color: "#578CBF"
            border.width: 4
            anchors.margins: -15
            id: itemListDialog
            anchors.fill: parent
            radius: 10
            color: "#9ACDFF"

            Image {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 20
                id: clothesImageDialog
                source: dialogVars.thisImage
                height: 350
            }

            Label {
                anchors.topMargin: 15
                anchors.leftMargin: 15
                anchors.top: clothesImageDialog.bottom
                anchors.left: parent.left
                anchors.right: clothesNameDialog.left
                id: moreNameLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Название"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 15
                anchors.rightMargin: 15
                id: clothesNameDialog
                text: dialogVars.thisName
                anchors.top: clothesImageDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreNameLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesPriceDialog.left
                id: morePriceLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Цена"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesPriceDialog
                text: dialogVars.thisPrice
                anchors.top: clothesNameDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: morePriceLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesCategoryDialog.left
                id: moreCategoryLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Категория"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesCategoryDialog
                text: dialogVars.thisCategory
                anchors.top: clothesPriceDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreCategoryLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesSizeDialog.left
                id: moreSizeLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Размер"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesSizeDialog
                text: dialogVars.thisSize
                anchors.top: clothesCategoryDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreSizeLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesMadeByDialog.left
                id: moreMadeByLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Изготовитель"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesMadeByDialog
                text: dialogVars.thisMadeBy
                anchors.top: clothesSizeDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreMadeByLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesRecDateDialog.left
                id: moreRecDateLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Дата приема"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesRecDateDialog
                text: database.convertDate(dialogVars.thisRecieveDate)
                anchors.top: clothesMadeByDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreRecDateLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesMaleFemaleDialog.left
                id: moreMaleFemaleLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Пол"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesMaleFemaleDialog
                text: dialogVars.thisMaleFemale
                anchors.top: clothesRecDateDialog.bottom
                anchors.right: parent.right
                font.pointSize: 13
                font.bold: true
                font.italic: true
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
            }

            Button {
                anchors.margins: 20
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                id: buttonSell

                contentItem: Text {
                    text: "Продать товар"
                    font.bold: true
                    font.pixelSize: 10
                    opacity: enabled ? 1.0 : 0.3
                    color: buttonSell.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: buttonSell.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }
                onClicked: {
                    confirmDialog.open()
                }
            }
        }
    }
    Dialog {
        id: confirmDialog
        height: 200
        width: 300
        x: 500
        y: 300
        Rectangle {
            border.color: "#578CBF"
            border.width: 4
            anchors.margins: -15
            anchors.fill: parent
            radius: 10
            color: "#9ACDFF"

            Label {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 50
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                horizontalAlignment: Text.AlignHCenter
                text: "Вы действительно\nхотите продать товар?"
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                color: "#1760A6"
            }

            Button {
                id: nopeButton
                anchors.bottomMargin: 10
                anchors.leftMargin: 30
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.margins: 10

                contentItem: Text {
                    text: "Да"
                    font.bold: true
                    font.pixelSize: 10
                    opacity: enabled ? 1.0 : 0.3
                    color: nopeButton.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: nopeButton.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }

                onClicked: {
                    database.removeFromOnSaleTable(dialogVars.thisId)
                    database.insertIntoSoldTable(dialogVars.thisName,
                                                 dialogVars.thisPrice,
                                                 dialogVars.thisCategory,
                                                 dialogVars.thisSize,
                                                 dialogVars.thisMadeBy,
                                                 dialogVars.thisImage,
                                                 dialogVars.thisRecieveDate,
                                                 dialogVars.thisMaleFemale)
                    onSaleModel.updateModel()
                    SoldModel.updateModel()
                    confirmDialog.close()
                    moreDialog.close()
                }
            }

            Button {
                id: yepButton
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                anchors.rightMargin: 30

                contentItem: Text {
                    text: "Нет"
                    font.bold: true
                    font.pixelSize: 10
                    opacity: enabled ? 1.0 : 0.3
                    color: yepButton.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: yepButton.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }

                onClicked: {
                    confirmDialog.close()
                }
            }
        }
    }
}
