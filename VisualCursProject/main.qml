import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

ApplicationWindow {
    visible: true
    width: 1280
    height: 720
    title: qsTr("Hello World")

    // Пересчёт независимых от плотности пикселей в физические пиксели устройства
    readonly property int dpi: Screen.pixelDensity * 25.4
    function dp(x){ return (dpi < 120) ? x : x*(dpi/160); }

    // Application Bar
    Rectangle {
        id: menuRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 48
        color: "#4cd964"

        // Иконка-Гамбургер
        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: dp(48)
            color: "#4cd964"

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: dp(16)
                anchors.left: parent.left
                anchors.leftMargin: dp(14)
                width: dp(20)
                height: dp(2)
            }

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: dp(23)
                anchors.left: parent.left
                anchors.leftMargin: dp(14)
                width: dp(20)
                height: dp(2)
            }

            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: dp(30)
                anchors.left: parent.left
                anchors.leftMargin: dp(14)
                width: dp(20)
                height: dp(2)
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    nav.toggle()
                }
            }
        }

    }

    // Loader для смены Фрагментов
    Loader {
        id: loader
        anchors.top: parent.top
        anchors.left: menuRect.right
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        source: "OnSaleFragment.qml"

        // Функция для смены содержимого Loader
        function loadFragment(index){

            switch(index){
            case 0:
                loader.source = "OnSaleFragment.qml"
                break;
            case 1:
                loader.source = "SoldFragment.qml"
                break;
            case 2:
                loader.source = "ReturnedFragment.qml"
                break;
            default:
                loader.source = "OnSaleFragment.qml"
                break;
            }
        }
    }

    NavigationDrawer {
        id: nav
        Rectangle {
            anchors.fill: parent
            color: "white"

            // Список с пунктами меню
            ListView {
                anchors.fill: parent

                delegate: Item {
                    height: dp(48)
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: dp(5)
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

                            // По нажатию на пункт меню заменяем компонент в Loader
                            onClicked: {
                                loader.loadFragment(index)
                                nav.hide()
                            }
                        }
                    }
                }

                model: navModel
            }
        }
    }

    // Модель данных для списка с пунктами меню
    ListModel {
        id: navModel

        ListElement {fragment: "Fragment 1"}
        ListElement {fragment: "Fragment 2"}
        ListElement {fragment: "Fragment 3"}
    }
}

