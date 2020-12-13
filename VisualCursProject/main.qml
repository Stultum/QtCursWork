import QtQuick.Window 2.0
import QtQuick.Layouts 1.1

import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0

Loader {
    id: loaderSplash
    Component {
        id: splash
        Window {
            id: splashWindow
            signal timeout
            width: 300
            height: 200
            modality: Qt.ApplicationModal
            flags: Qt.SplashScreen
            color: "#DEDEDE"
            Image {
                anchors.fill: parent
                id: splashImage
                source: "splash.jfif"
                height: 250
            }
            ProgressBar {
                id: progress
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                value: 0
                from: 0
                to: 100
            }
            Timer {
                id: timer
                interval: 50
                running: true
                repeat: true
                onTriggered: {
                    progress.value++
                    if (progress.value >= 1) {
                        timer.stop()
                        splashWindow.timeout()
                    }
                }
            }
        }
    }

    Component {
        id: root

        ApplicationWindow {
            visible: true
            width: 1280
            height: 720
            maximumHeight: height
            maximumWidth: width
            minimumHeight: height
            minimumWidth: width
            title: qsTr("Смешные цены")

            readonly property int dpi: Screen.pixelDensity * 25.4
            function dp(x) {
                return (dpi < 120) ? x : x * (dpi / 160)
            }

            Rectangle {
                id: menuRect
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                width: 48
                color: "#1760A6"

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: 48
                    color: "#578CBF"

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

            Loader {
                id: loader
                anchors.top: parent.top
                anchors.left: menuRect.right
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                source: "OnSaleFragment.qml"

                // Функция для смены содержимого Loader
                function loadFragment(index) {

                    switch (index) {
                    case 0:
                        loader.source = "OnSaleFragment.qml"
                        break
                    case 1:
                        loader.source = "SoldFragment.qml"
                        break
                    case 2:
                        loader.source = "ReturnedFragment.qml"
                        break
                    case 3:
                        loader.source = "SellItemFragment.qml"
                        break
                    case 4:
                        loader.source = "ReturnItemFragment.qml"
                        break
                    case 5:
                        loader.source = "HelpFragment.qml"
                        break
                    default:
                        loader.source = "OnSaleFragment.qml"
                        break
                    }
                }
            }

            NavigationDrawer {
                id: nav
                Rectangle {
                    anchors.fill: parent
                    color: "#578CBF"

                    // Список с пунктами меню
                    ListView {
                        spacing: 10
                        anchors.fill: parent

                        delegate: Item {
                            height: dp(110)
                            anchors.left: parent.left
                            anchors.right: parent.right

                            Rectangle {
                                border.color: "#1760A6"
                                border.width: 3
                                radius: 18
                                anchors.fill: parent
                                anchors.margins: dp(5)
                                color: "#9ACDFF"

                                Text {
                                    text: fragment
                                    anchors.fill: parent
                                    font.bold: true
                                    font.pixelSize: dp(25)
                                    color: "#1760A6"

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
        }
    }

    sourceComponent: splash
    active: true
    visible: true
    onStatusChanged: {
        if (loaderSplash.status === Loader.Ready)
            item.show()
    }

    Connections {
        id: connection
        target: loaderSplash.item
        onTimeout: {
            connection.target = null
            loaderSplash.sourceComponent = root
        }
    }

    // Модель данных для списка с пунктами меню
    ListModel {
        id: navModel

        ListElement {
            fragment: "Одежда на продаже"
        }
        ListElement {
            fragment: "Проданная одежда"
        }
        ListElement {
            fragment: "Возвращенная одежда"
        }
        ListElement {
            fragment: "Продажа"
        }
        ListElement {
            fragment: "Возврат"
        }
        ListElement {
            fragment: "Помощь"
        }
    }
}
