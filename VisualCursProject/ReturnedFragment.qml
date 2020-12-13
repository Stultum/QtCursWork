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
            property string thisReturnDate: ""
            property string thisMaleFemale: ""
            property string thisReason: ""
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
            model: ReturnModel

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
                            dialogVars.thisReturnDate = returndateModel
                            dialogVars.thisMaleFemale = maleorfemaleModel
                            dialogVars.thisReason = reasonModel
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
                    ReturnModel.updateModelWithFilter(
                                controlCategory.displayText,
                                controlSortBy.displayText,
                                controlSize.displayText)
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

        Label {
            anchors.leftMargin: 15
            anchors.topMargin: 40
            anchors.top: controlCategory.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            id: sortByComboBoxLabel
            font.family: "Times"
            font.pointSize: 13
            font.bold: true
            text: "Сортировать"
            color: "#1760A6"
        }

        ComboBox {
            id: controlSortBy
            anchors.margins: 10
            anchors.top: sortByComboBoxLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            model: ["Цена по возрастанию", "Цена по убыванию", "Дата поступления по возрастнию ", "Дата поступления по убыванию"]

            delegate: ItemDelegate {
                width: controlSortBy.width
                contentItem: Text {
                    text: modelData
                    color: hovered ? "#1760A6" : "#47A4FF"
                    font: controlSortBy.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: controlSortBy.highlightedIndex == index
            }

            indicator: Canvas {
                id: canvasSortBy
                x: controlSortBy.width - width - controlSortBy.rightPadding
                y: controlSortBy.topPadding + (controlSortBy.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"
                rotation: listviewSortBy.visible ? 180 : 0

                Connections {
                    target: controlSortBy
                    onPressedChanged: canvasSortBy.requestPaint()
                }

                onPaint: {
                    context.reset()
                    context.moveTo(0, 0)
                    context.lineTo(width, 0)
                    context.lineTo(width / 2, height)
                    context.closePath()
                    context.fillStyle = controlSortBy.pressed ? "#1760A6" : "#47A4FF"
                    context.fill()
                }
            }

            contentItem: Text {
                id: contentSortBy
                text: controlSortBy.displayText
                font: controlSortBy.font
                color: controlSortBy.hovered ? "#1760A6" : "#47A4FF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                border.color: controlSortBy.hovered ? "#1760A6" : "#47A4FF"
                border.width: controlSortBy.visualFocus ? 5 : 3
                radius: 4
            }

            popup: Popup {
                y: controlSortBy.height - 1
                width: controlSortBy.width
                implicitHeight: listviewSortBy.contentHeight
                padding: 1
                onAboutToHide: {
                    ReturnModel.updateModelWithFilter(
                                controlCategory.displayText,
                                controlSortBy.displayText,
                                controlSize.displayText)
                }

                contentItem: ListView {
                    id: listviewSortBy
                    clip: true
                    model: controlSortBy.popup.visible ? controlSortBy.delegateModel : null
                    currentIndex: controlSortBy.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {
                    }
                }

                background: Rectangle {
                    border.color: controlSortBy.hovered ? "#1760A6" : "#47A4FF"
                    radius: 4
                }
            }
        }

        Label {
            anchors.leftMargin: 15
            anchors.topMargin: 40
            anchors.top: controlSortBy.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            id: sizeComboBoxLabel
            font.family: "Times"
            font.pointSize: 13
            font.bold: true
            text: "Причина возврата"
            color: "#1760A6"
        }

        ComboBox {
            id: controlSize
            anchors.margins: 10
            anchors.top: sizeComboBoxLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            model: ["Брак", "Недовольство товаром"]

            delegate: ItemDelegate {
                width: controlSize.width
                contentItem: Text {
                    text: modelData
                    color: hovered ? "#1760A6" : "#47A4FF"
                    font: controlSize.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                }
                highlighted: controlSize.highlightedIndex == index
            }

            indicator: Canvas {
                id: canvasSize
                x: controlSize.width - width - controlSize.rightPadding
                y: controlSize.topPadding + (controlSize.availableHeight - height) / 2
                width: 12
                height: 8
                contextType: "2d"
                rotation: listviewSize.visible ? 180 : 0

                Connections {
                    target: controlSize
                    onPressedChanged: canvasSize.requestPaint()
                }

                onPaint: {
                    context.reset()
                    context.moveTo(0, 0)
                    context.lineTo(width, 0)
                    context.lineTo(width / 2, height)
                    context.closePath()
                    context.fillStyle = controlSize.pressed ? "#1760A6" : "#47A4FF"
                    context.fill()
                }
            }

            contentItem: Text {
                id: contentSize
                text: controlSize.displayText
                font: controlSize.font
                color: controlSize.hovered ? "#1760A6" : "#47A4FF"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                implicitWidth: 120
                implicitHeight: 40
                border.color: controlSize.hovered ? "#1760A6" : "#47A4FF"
                border.width: controlSize.visualFocus ? 5 : 3
                radius: 4
            }

            popup: Popup {
                y: controlSize.height - 1
                width: controlSize.width
                implicitHeight: listviewSize.contentHeight
                padding: 1
                onAboutToHide: {
                    ReturnModel.updateModelWithFilter(
                                controlCategory.displayText,
                                controlSortBy.displayText,
                                controlSize.displayText)
                }

                contentItem: ListView {
                    id: listviewSize
                    clip: true
                    model: controlSize.popup.visible ? controlSize.delegateModel : null
                    currentIndex: controlSize.highlightedIndex

                    ScrollIndicator.vertical: ScrollIndicator {
                    }
                }

                background: Rectangle {
                    border.color: controlSize.hovered ? "#1760A6" : "#47A4FF"
                    radius: 4
                }
            }
        }

        Button {
            anchors.topMargin: 30
            anchors.leftMargin: 60
            anchors.rightMargin: 60
            anchors.top: controlSize.bottom
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
                ReturnModel.updateModel()
            }
        }

        //        Label {
        //            anchors.leftMargin: 70
        //            anchors.topMargin: 50
        //            anchors.top: controlInShop.bottom
        //            anchors.left: parent.left
        //            anchors.right: parent.right
        //            id: totalCashLabel
        //            font.family: "Times"
        //            font.pointSize: 13
        //            font.bold: true
        //            text: "Итоговая прибыль:"
        //            color: "#1760A6"
        //        }

        //        ListView {
        //            model: CashModel
        //            anchors.leftMargin: 100
        //            anchors.topMargin: 20
        //            anchors.top: totalCashLabel.bottom
        //            anchors.left: parent.left
        //            anchors.right: parent.right
        //            delegate: Item {
        //                anchors.fill: parent
        //                Text {
        //                    id: totalCashValue
        //                    font.family: "Times"
        //                    font.pointSize: 13
        //                    font.bold: true
        //                    text: moneyModel + " рублей"
        //                    color: "#1760A6"
        //                }
        //            }
        //        }
        Button {
            anchors.margins: 10
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            id: controlAddNew
            text: qsTr("Распечатать отчет")

            contentItem: Text {
                text: controlAddNew.text
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
            dialogVars.thisReturnDate = ""
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
                height: 340
            }

            Label {
                anchors.topMargin: 5
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
                anchors.topMargin: 5
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
                text: "Дата возврата"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesRecDateDialog
                text: database.convertDate(dialogVars.thisReturnDate)
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

            Label {
                anchors.topMargin: 5
                anchors.leftMargin: 15
                anchors.top: moreMaleFemaleLabel.bottom
                anchors.left: parent.left
                anchors.right: clothesReasonDialog.left
                id: moreReasonLabel
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Причина возврата"
                color: "#1760A6"
            }

            Text {
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesReasonDialog
                text: dialogVars.thisReason
                anchors.top: clothesMaleFemaleDialog.bottom
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
                    database.removeFromReturnedTable(dialogVars.thisId)
                    moreDialog.close()
                    ReturnModel.updateModel()
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

    //Дилоговое окно добавления товара
    Dialog {
        id: addDialog
        width: 720
        height: 640
        enter: Transition {
            NumberAnimation {
                property: "x"
                from: -700
                to: 100
                duration: 400
            }
            NumberAnimation {
                property: "y"
                from: 50
                to: 50
                duration: 400
            }
        }

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
            anchors.margins: -15
            id: addListDialog
            anchors.fill: parent
            radius: 10
            color: "#9ACDFF"
            border.color: "#578CBF"
            border.width: 4

            Image {
                anchors.top: parent.top
                anchors.left: parent.left
                width: 300
                height: 300
                anchors.topMargin: 20
                anchors.leftMargin: 40
                id: dropImageDialogAdd
                source: "data:image/png;base64,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"
                DropArea {
                    id: dropArea
                    anchors.fill: parent
                    onEntered: {
                        drag.accept(Qt.LinkAction)
                    }
                    onDropped: {
                        console.log(drop.urls)
                        dialogVars.thisImage = drop.text
                        clothesImageDialogAdd.visible = false
                        clothesImageDialogAdd.visible = true
                    }
                }
            }

            Image {
                anchors.top: parent.top
                anchors.right: parent.right
                width: 300
                height: 300
                anchors.topMargin: 20
                anchors.rightMargin: 40
                id: clothesImageDialogAdd
                source: dialogVars.thisImage
            }

            Label {
                anchors.topMargin: 35
                anchors.leftMargin: 15
                anchors.top: clothesImageDialogAdd.bottom
                anchors.left: parent.left
                anchors.right: clothesNameDialog.left
                id: moreNameLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Название"
                color: "#1760A6"
            }

            TextField {
                width: 300
                height: 25
                anchors.topMargin: 35
                anchors.rightMargin: 15
                id: clothesNameDialogAdd
                placeholderText: "Введите название"
                anchors.top: clothesImageDialogAdd.bottom
                anchors.right: parent.right
                font.bold: true
                text: dialogVars.thisName
                font.pointSize: 10
                maximumLength: 22
                font.italic: false
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
                onTextChanged: {
                    errorLabel.visible = false
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: moreNameLabelAdd.bottom
                anchors.left: parent.left
                anchors.right: clothesPriceDialogAdd.left
                id: morePriceLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Цена"
                color: "#1760A6"
            }

            TextField {
                width: 300
                height: 25
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesPriceDialogAdd
                placeholderText: "Введите цену"
                anchors.top: clothesNameDialogAdd.bottom
                anchors.right: parent.right
                font.bold: true
                font.pointSize: 10
                text: dialogVars.thisPrice
                maximumLength: 22
                font.italic: false
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
                onTextChanged: {
                    errorLabel.visible = false
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: morePriceLabelAdd.bottom
                anchors.left: parent.left
                id: moreCategoryLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Категория"
                color: "#1760A6"
            }

            ComboBox {
                id: controlCategoryAdd
                anchors.topMargin: 5
                anchors.rightMargin: 15
                anchors.top: clothesPriceDialogAdd.bottom
                anchors.right: parent.right
                width: 300

                model: ["Верхняя одежда", "Обувь", "Свитеры/Джемперы", "Брюки/Джинсы", "Футболки/Блузки/Рубашки", "Юбки/Платья"]

                delegate: ItemDelegate {
                    width: controlCategoryAdd.width
                    contentItem: Text {
                        text: modelData
                        color: hovered ? "#1760A6" : "#47A4FF"
                        font: controlCategoryAdd.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: controlCategoryAdd.highlightedIndex == index
                }

                indicator: Canvas {
                    id: canvasAdd
                    x: controlCategoryAdd.width - width - controlCategoryAdd.rightPadding
                    y: controlCategoryAdd.topPadding
                       + (controlCategoryAdd.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"
                    rotation: listviewAdd.visible ? 0 : 180

                    Connections {
                        target: controlCategoryAdd
                        onPressedChanged: canvasAdd.requestPaint()
                    }

                    onPaint: {
                        context.moveTo(0, 0)
                        context.lineTo(width, 0)
                        context.lineTo(width / 2, height)
                        context.closePath()
                        context.fillStyle = controlCategoryAdd.pressed ? "#1760A6" : "#47A4FF"
                        context.fill()
                    }
                }

                contentItem: Text {
                    id: contentAdd
                    text: controlCategoryAdd.displayText
                    font: controlCategoryAdd.font
                    color: controlCategoryAdd.hovered ? "#1760A6" : "#47A4FF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 30
                    border.color: controlCategoryAdd.hovered ? "#1760A6" : "#47A4FF"
                    border.width: controlCategoryAdd.visualFocus ? 5 : 3
                    radius: 4
                }

                popup: Popup {
                    y: controlCategoryAdd.height - 1
                    width: controlCategoryAdd.width
                    implicitHeight: listviewAdd.contentHeight
                    padding: 1

                    contentItem: ListView {
                        id: listviewAdd
                        clip: true
                        model: controlCategoryAdd.popup.visible ? controlCategoryAdd.delegateModel : null
                        currentIndex: controlCategoryAdd.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator {
                        }
                    }

                    background: Rectangle {
                        border.color: controlCategoryAdd.hovered ? "#1760A6" : "#47A4FF"
                        radius: 4
                    }
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: moreCategoryLabelAdd.bottom
                anchors.left: parent.left
                id: moreSizeLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Размер"
                color: "#1760A6"
            }

            ComboBox {
                id: controlSizeAdd
                anchors.topMargin: 5
                anchors.rightMargin: 15
                anchors.top: controlCategoryAdd.bottom
                anchors.right: parent.right
                width: 300
                model: ["S", "M", "L ", "XL", "XXL"]

                delegate: ItemDelegate {
                    width: controlSizeAdd.width
                    contentItem: Text {
                        text: modelData
                        color: hovered ? "#1760A6" : "#47A4FF"
                        font: controlSizeAdd.font
                        elide: Text.ElideRight
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: controlSizeAdd.highlightedIndex == index
                }

                indicator: Canvas {
                    id: canvasSizeAdd
                    x: controlSizeAdd.width - width - controlSizeAdd.rightPadding
                    y: controlSizeAdd.topPadding + (controlSizeAdd.availableHeight - height) / 2
                    width: 12
                    height: 8
                    contextType: "2d"
                    rotation: listviewSizeAdd.visible ? 0 : 180

                    Connections {
                        target: controlSizeAdd
                        onPressedChanged: canvasSizeAdd.requestPaint()
                    }

                    onPaint: {
                        context.moveTo(0, 0)
                        context.lineTo(width, 0)
                        context.lineTo(width / 2, height)
                        context.closePath()
                        context.fillStyle = controlSizeAdd.pressed ? "#1760A6" : "#47A4FF"
                        context.fill()
                    }
                }

                contentItem: Text {
                    id: contentSizeAdd
                    text: controlSizeAdd.displayText
                    font: controlSizeAdd.font
                    color: controlSizeAdd.hovered ? "#1760A6" : "#47A4FF"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 120
                    implicitHeight: 30
                    border.color: controlSizeAdd.hovered ? "#1760A6" : "#47A4FF"
                    border.width: controlSizeAdd.visualFocus ? 5 : 3
                    radius: 4
                }

                popup: Popup {
                    y: controlSizeAdd.height - 1
                    width: controlSizeAdd.width
                    implicitHeight: listviewSizeAdd.contentHeight
                    padding: 1

                    contentItem: ListView {
                        id: listviewSizeAdd
                        clip: true
                        model: controlSizeAdd.popup.visible ? controlSizeAdd.delegateModel : null
                        currentIndex: controlSizeAdd.highlightedIndex

                        ScrollIndicator.vertical: ScrollIndicator {
                        }
                    }

                    background: Rectangle {
                        border.color: controlSizeAdd.hovered ? "#1760A6" : "#47A4FF"
                        radius: 4
                    }
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: moreSizeLabelAdd.bottom
                anchors.left: parent.left
                anchors.right: clothesMadeByDialogAdd.left
                id: moreMadeByLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Изготовитель"
                color: "#1760A6"
            }

            TextField {
                height: 25
                width: 300
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesMadeByDialogAdd
                placeholderText: "Введите Изготовителя"
                anchors.top: controlSizeAdd.bottom
                anchors.right: parent.right
                font.bold: true
                text: dialogVars.thisMadeBy
                font.pointSize: 10
                maximumLength: 22
                font.italic: false
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
                onTextChanged: {
                    errorLabel.visible = false
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: moreMadeByLabelAdd.bottom
                anchors.left: parent.left
                anchors.right: clothesRecDateDialogAdd.left
                id: moreRecDateLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Дата продажи"
                color: "#1760A6"
            }

            TextField {
                height: 25
                width: 300
                anchors.topMargin: 5
                anchors.rightMargin: 15
                id: clothesRecDateDialogAdd
                placeholderText: "Дата приема в формате dd.mm.yyyy"
                anchors.top: clothesMadeByDialogAdd.bottom
                anchors.right: parent.right
                font.bold: true
                text: database.convertDate(dialogVars.thisRecieveDate)
                font.pointSize: 10
                maximumLength: 10
                font.italic: false
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "#1760A6"
                onTextChanged: {
                    errorLabel.visible = false
                }
            }

            Label {
                anchors.topMargin: 12
                anchors.leftMargin: 15
                anchors.top: moreRecDateLabelAdd.bottom
                anchors.left: parent.left
                id: moreMaleFemaleLabelAdd
                font.family: "Times"
                font.pointSize: 13
                font.bold: true
                text: "Пол"
                color: "#1760A6"
            }

            Row {
                spacing: 30
                id: radioColumnAdd
                anchors.topMargin: 5
                anchors.leftMargin: 65
                anchors.top: clothesRecDateDialogAdd.bottom
                anchors.left: moreRecDateLabelAdd.right
                anchors.right: parent.right
                RadioButton {
                    id: controlMaleRadioAdd
                    text: qsTr("Мужская")
                    checked: false

                    indicator: Rectangle {
                        id: indicatorMaleAdd
                        implicitWidth: 26
                        implicitHeight: 26
                        x: controlMaleRadioAdd.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 13
                        border.color: controlMaleRadioAdd.down ? "#47A4FF" : "#1760A6"

                        Rectangle {
                            width: 14
                            height: 14
                            x: 6
                            y: 6
                            radius: 7
                            color: controlMaleRadioAdd.down ? "#47A4FF" : "#1760A6"
                            visible: controlMaleRadioAdd.checked
                        }
                    }

                    contentItem: Text {
                        id: maleTextAdd
                        anchors.left: indicatorMaleAdd.right
                        anchors.leftMargin: 10
                        text: controlMaleRadioAdd.text
                        font: controlMaleRadioAdd.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlMaleRadioAdd.down ? "#47A4FF" : "#1760A6"
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                RadioButton {
                    id: controlFemaleRadioAdd
                    text: qsTr("Женская")
                    checked: false

                    indicator: Rectangle {
                        id: indicatorFemaleAdd
                        implicitWidth: 26
                        implicitHeight: 26
                        x: controlMaleRadioAdd.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 13
                        border.color: controlFemaleRadioAdd.down ? "#47A4FF" : "#1760A6"

                        Rectangle {
                            width: 14
                            height: 14
                            x: 6
                            y: 6
                            radius: 7
                            color: controlFemaleRadioAdd.down ? "#47A4FF" : "#1760A6"
                            visible: controlFemaleRadioAdd.checked
                        }
                    }

                    contentItem: Text {
                        anchors.leftMargin: 10
                        anchors.left: indicatorFemaleAdd.right
                        text: controlFemaleRadioAdd.text
                        font: controlFemaleRadioAdd.font
                        opacity: enabled ? 1.0 : 0.3
                        color: controlFemaleRadioAdd.down ? "#47A4FF" : "#1760A6"
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }

            Button {
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                anchors.bottomMargin: 20
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                id: buttonDiscard

                contentItem: Text {
                    text: dialogVars.addOrChange
                    font: controlAddNew.font
                    opacity: enabled ? 1.0 : 0.3
                    color: buttonDiscard.down ? "#47A4FF" : "#1760A6"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    opacity: enabled ? 1 : 0.3
                    border.color: buttonDiscard.down ? "#47A4FF" : "#1760A6"
                    border.width: 1
                    radius: 4
                }
                onClicked: {
                    controlMaleRadioAdd.checked
                            == true ? dialogVars.thisMaleFemale
                                      = "Мужская" : dialogVars.thisMaleFemale = "Женская"
                    database.removeFromReturnedTable(dialogVars.thisId)
                    database.insertIntoReturnedTable(
                                clothesNameDialogAdd.text,
                                clothesPriceDialogAdd.text,
                                controlCategoryAdd.displayText,
                                controlSizeAdd.displayText,
                                clothesMadeByDialogAdd.text,
                                dialogVars.thisImage,
                                clothesRecDateDialogAdd.text,
                                dialogVars.thisMaleFemale)
                            == true ? dialogVars.addStatus = true : dialogVars.addStatus = false
                    dialogVars.addStatus == true ? addDialog.close(
                                                       ) : errorLabel.visible = true
                    dialogVars.addStatus == true ? moreDialog.close(
                                                       ) : errorLabel.visible = true
                    dialogVars.addStatus == true ? ReturnModel.updateModel(
                                                       ) : errorLabel.visible = true
                    dialogVars.addStatus == true ? errorLabel.visible
                                                   = false : errorLabel.visible = true
                }
            }

            Label {
                id: errorLabel
                visible: false
                anchors.top: buttonDiscard.bottom
                anchors.right: parent.right
                horizontalAlignment: "AlignHCenter"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                font.pointSize: 13
                font.bold: true
                color: "red"
                text: "Ошибка! Поля не должны быть пустыми!"
            }
        }
    }

    // Модель данных для списка с пунктами меню
    ListModel {
        id: navModel

        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
        ListElement {
            name: "Куртка Райна Гослинга"
            imageFile: "mock.jpg"
            price: "Бесценно"
            available: "Есть в наличии"
        }
    }
}
