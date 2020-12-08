import QtQuick 2.5
import QtQuick.Controls 2.1
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
        anchors.right: controlPanel
        anchors.leftMargin: 30
        anchors.topMargin: 50
        GridView {
            anchors.fill: parent
            id: clothesGrid
            width: 950
            height: 720
            cellWidth: 300
            cellHeight: 420
            focus: true
            model: navModel

            delegate: Item {
                width: dp(300)
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
                        source: imageFile
                        height: 250
                    }

                    Text {
                        anchors.margins: 5
                        id: clothesName
                        text: name
                        anchors.top: clothesImage.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: dp(20)
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    Text {
                        anchors.margins: 5
                        id: clothesPrice
                        text: price
                        anchors.top: clothesName.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        font.pixelSize: dp(20)
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    Text {
                        anchors.margins: 5
                        id: clothesAvailable
                        text: available
                        anchors.top: clothesPrice.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        font.pixelSize: dp(20)
                        renderType: Text.NativeRendering
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }

                    MouseArea {
                        id: itemMouseArea
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: {
                            itemAnimOnHover.running = true
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
        color: "#578CBF"

        ComboBox {
            id: equipmentList
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10
            width: 250
            height: 44

            model: [qsTr("Верхняя одежда"), qsTr("Обувь"), qsTr(
                    "Свитеры/Джемперы"), qsTr("Брюки/Джинсы"), qsTr(
                    "Футболки/Блузки/Рубашки"), qsTr("Юбки/Платья")]

            //the background of the combobox
            background: Rectangle {
                color: "#95A4A8"
                border.color: "white"
                radius: height / 2
            }

            delegate: ItemDelegate {
                id: itemDlgt
                width: equipmentList.width
                height: 40
                padding: 0

                contentItem: Text {
                    id: textItem
                    text: modelData
                    color: hovered ? "white" : "#507BF6"
                    font: equipmentList.font
                    elide: Text.ElideRight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                background: Rectangle {
                    radius: 20
                    color: itemDlgt.hovered ? "#507BF6" : "white"
                    anchors.left: itemDlgt.left
                    anchors.leftMargin: 0
                    width: itemDlgt.width - 2
                }

                onPressed: console.log(
                               itemDlgt.height + " " + rectDlgt.height) //are not the same!
            }

            //the arrow on the right in the combobox
            indicator: Image {
                width: 50
                height: width
                horizontalAlignment: Image.AlignRight
                source: comboPopup.visible ? "arrowOpen.png" : "arrowClose.png"
            }

            //the text in the combobox
            contentItem: Text {

                text: equipmentList.displayText
                font: equipmentList.font
                color: "white"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                elide: Text.ElideRight
            }

            //the list of elements and their style when the combobox is open
            popup: Popup {
                id: comboPopup
                y: equipmentList.height - 1
                width: equipmentList.width
                height: contentItem.implicitHeigh
                padding: 1

                contentItem: ListView {
                    id: listView
                    implicitHeight: contentHeight
                    model: equipmentList.popup.visible ? equipmentList.delegateModel : null

                    ScrollIndicator.vertical: ScrollIndicator {
                    }
                }

                background: Rectangle {
                    radius: 20
                    border.width: 1
                    border.color: "#95A4A8"
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
