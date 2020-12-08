import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1


    // Application Bar
    Rectangle {
        id: menuRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right





            GridView {
                id: clothesGrid
                width: 1000
                height: 720
                cellWidth: 320
                cellHeight: 320
                focus: true
                model: navModel

                delegate: Item {
                    width: dp(300)
                    height: dp(300)

                    Rectangle {
                        anchors.fill: parent
                        color: "whitesmoke"

                        Text {
                            text: fragment
                            anchors.fill: parent
                            font.pixelSize: dp(20)
                            renderType: Text.NativeRendering
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }

                        MouseArea {
                            anchors.fill: parent

                        }
                    }
                }
            }


    // Модель данных для списка с пунктами меню
    ListModel {
        id: navModel

        ListElement {fragment: "Одежда на продаже"}
        ListElement {fragment: "Проданная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
        ListElement {fragment: "Возвращенная одежда"}
    }

        }
