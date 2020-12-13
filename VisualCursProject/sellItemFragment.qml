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

        Label {
            anchors.leftMargin: 15
            anchors.topMargin: 40
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            id: categoryComboBoxLabel
            font.family: "Times"
            font.pointSize: 13
            font.bold: true
            text: "Категория товара"
            color: "#1760A6"
        }

        ComboBox {
            id: controlCategory
            anchors.margins: 10
            anchors.top: categoryComboBoxLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            model: ["Верхняя одежда", "Обувь", "Свитеры/Джемперы", "Брюки/Джинсы", "Футболки/Блузки/Рубашки", "Юбки/Платья"]

            delegate: ItemDelegate {
                width: controlCategory.width
                contentItem: Text {
                    text: modelData
                    color: hovered ? "#1760A6" : "#47A4FF"
                    font: controlCategory.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: controlCategory.highlightedIndex == index
            }

            indicator: Canvas {
                id: canvas
                x: controlCategory.width - width - controlCategory.rightPadding
                y: controlCategory.topPadding + (controlCategory.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"
                rotation: listview.visible ? 180 : 0

                Connections {
                    target: controlCategory
                    onPressedChanged: canvas.requestPaint()
                }

                onPaint: {
                    context.reset()
                    context.moveTo(0, 0)
                    context.lineTo(width, 0)
                    context.lineTo(width / 2, height)
                    context.closePath()
                    context.fillStyle = controlCategory.pressed ? "#1760A6" : "#47A4FF"
                    context.fill()
                }
            }

            contentItem: Text {
                id: content
                text: controlCategory.displayText
                font: controlCategory.font
                color: controlCategory.hovered ? "#1760A6" : "#47A4FF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                border.color: controlCategory.hovered ? "#1760A6" : "#47A4FF"
                border.width: controlCategory.visualFocus ? 5 : 3
                radius: 4
            }

            popup: Popup {
                y: controlCategory.height - 1
                width: controlCategory.width
                onAboutToHide: {
                    controlMaleRadio.checked
                            == true ? onSaleModel.updateModelWithFilter(
                                          controlCategory.displayText,
                                          controlSize.displayText,
                                          qsTr("Мужская"),
                                          controlSortBy.displayText) : onSaleModel.updateModelWithFilter(
                                          controlCategory.displayText,
                                          controlSize.displayText,
                                          qsTr("Женская"),
                                          controlSortBy.displayText)
                }
                implicitHeight: listview.contentHeight
                padding: 1

                contentItem: ListView {
                    id: listview
                    clip: true
                    model: controlCategory.popup.visible ? controlCategory.delegateModel : null
                    currentIndex: controlCategory.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {
                    }
                }

                background: Rectangle {
                    border.color: controlCategory.hovered ? "#1760A6" : "#47A4FF"
                    radius: 4
                }
            }
        }

        Button {
            anchors.topMargin: 30
            anchors.leftMargin: 60
            anchors.rightMargin: 60
            anchors.top: controlCategory.bottom
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
                width: 170
                anchors.right: buttonChange.left
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                id: buttonDelete

                contentItem: Text {
                    text: "Удалить товар"
                    font: controlAddNew.font
                    opacity: enabled ? 1.0 : 0.3
                    color: controlAddNew.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: controlAddNew.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }
                onClicked: {
                    database.removeFromOnSaleTable(dialogVars.thisId)
                    moreDialog.close()
                    onSaleModel.updateModel()
                }
            }

            Button {
                anchors.margins: 20
                width: 170
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                id: buttonChange

                contentItem: Text {
                    text: "Редактировать товар"
                    font: controlAddNew.font
                    opacity: enabled ? 1.0 : 0.3
                    color: controlAddNew.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: controlAddNew.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }
                onClicked: {
                    dialogVars.addOrChange = "Сохранить изменения"
                    addDialog.open()
                }
            }
        }
    }
}
