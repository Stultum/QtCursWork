import QtQuick 2.5
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
                        anchors.margins: 5
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
                        text: priceModel
                        anchors.top: clothesName.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: dp(18)
                        font.bold: true
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: "#1760A6"
                    }

                    Text {
                        anchors.margins: 5
                        id: clothesAvailable
                        text: "available"
                        anchors.top: clothesPrice.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.bold: true
                        anchors.bottom: parent.bottom
                        font.pixelSize: dp(18)
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
                    onSaleModel.updateModelFilter(content.text)
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
                    onSaleModel.updateModelSort(contentSortBy.text)
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
            text: "Размер"
            color: "#1760A6"
        }

        ComboBox {
            id: controlSize
            anchors.margins: 10
            anchors.top: sizeComboBoxLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            model: ["S", "M", "L ", "XL", "XXL"]

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
                    onSaleModel.updateModelSize(contentSize.text)
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

        Label {
            anchors.leftMargin: 15
            anchors.topMargin: 40
            anchors.top: controlSize.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            id: femaleMaleLabel
            font.family: "Times"
            font.pointSize: 13
            font.bold: true
            text: "Мужская или женская"
            color: "#1760A6"
        }

        Column {
            id: radioColumn
            anchors.topMargin: 20
            anchors.leftMargin: 15
            anchors.top: femaleMaleLabel.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            RadioButton {
                id: controlMaleRadio
                text: qsTr("Мужская одежда")
                checked: false
                onClicked: {
                    onSaleModel.updateModelSex(qsTr("Мужская"))
                }

                indicator: Rectangle {
                    id: indicatorMale
                    implicitWidth: 26
                    implicitHeight: 26
                    x: controlMaleRadio.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: controlMaleRadio.down ? "#47A4FF" : "#1760A6"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: controlMaleRadio.down ? "#47A4FF" : "#1760A6"
                        visible: controlMaleRadio.checked
                    }
                }

                contentItem: Text {
                    id: maleText
                    anchors.left: indicatorMale.right
                    anchors.leftMargin: 10
                    text: controlMaleRadio.text
                    font: controlMaleRadio.font
                    opacity: enabled ? 1.0 : 0.3
                    color: controlMaleRadio.down ? "#47A4FF" : "#1760A6"
                    verticalAlignment: Text.AlignVCenter
                }
            }

            RadioButton {
                id: controlFemaleRadio
                text: qsTr("Женская одежда")
                checked: false

                onClicked: {
                    onSaleModel.updateModelSex(qsTr("Женская"))
                }

                indicator: Rectangle {
                    id: indicatorFemale
                    implicitWidth: 26
                    implicitHeight: 26
                    x: controlMaleRadio.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 13
                    border.color: controlFemaleRadio.down ? "#47A4FF" : "#1760A6"

                    Rectangle {
                        width: 14
                        height: 14
                        x: 6
                        y: 6
                        radius: 7
                        color: controlFemaleRadio.down ? "#47A4FF" : "#1760A6"
                        visible: controlFemaleRadio.checked
                    }
                }

                contentItem: Text {
                    anchors.leftMargin: 10
                    anchors.left: indicatorFemale.right
                    text: controlFemaleRadio.text
                    font: controlFemaleRadio.font
                    opacity: enabled ? 1.0 : 0.3
                    color: controlFemaleRadio.down ? "#47A4FF" : "#1760A6"
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        CheckBox {
            anchors.topMargin: 30
            anchors.leftMargin: 15
            anchors.top: radioColumn.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            id: controlInShop
            text: qsTr("Есть в наличии")
            checked: false

            indicator: Rectangle {
                id: ind
                implicitWidth: 26
                implicitHeight: 26
                x: controlInShop.leftPadding
                y: parent.height / 2 - height / 2
                radius: 3
                border.color: controlInShop.down ? "#47A4FF" : "#1760A6"

                Rectangle {
                    width: 14
                    height: 14
                    x: 6
                    y: 6
                    radius: 2
                    color: controlInShop.down ? "#47A4FF" : "#1760A6"
                    visible: controlInShop.checked
                }
            }

            contentItem: Text {
                anchors.left: ind.right
                anchors.leftMargin: 10
                text: controlInShop.text
                font: controlInShop.font
                opacity: enabled ? 1.0 : 0.3
                color: controlInShop.down ? "#47A4FF" : "#1760A6"
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            anchors.margins: 10
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            id: controlAddNew
            text: qsTr("Добавить новый товар")

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
                //                database.insertIntoOnSaleTable("al", "al", "al", "al", "al",
                //                                               "al", "al", "al")
                onSaleModel.updateModel()
            }
        }
    }

    Dialog {
        id: moreDialog
        width: 400
        height: 640
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
                text: dialogVars.thisRecieveDate
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

                }
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
