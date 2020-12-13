import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

TabBar {
    id: control

    background: Rectangle {
        color: "#9ACDFF"
        ScrollView {
            anchors.fill: parent
            Label {
                anchors.fill: parent
                anchors.topMargin: 50
                anchors.leftMargin: 10
                id: helpText
                color: "#1760A6"
                font.pixelSize: 16
                font.bold: true
                text: "Example 1"
            }
        }
    }
    TabButton {
        contentItem: Text {
            text: "Начальная страница"
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 1"
        }
    }
    TabButton {
        contentItem: Text {
            text: qsTr("Раздел товаров на продаже")
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 2"
        }
    }
    TabButton {
        contentItem: Text {
            text: qsTr("Раздел проданных товаров")
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 3"
        }
    }
    TabButton {
        contentItem: Text {
            text: qsTr("Раздел возвращенных товаров")
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 4"
        }
    }
    TabButton {
        contentItem: Text {
            text: qsTr("Продажа товаров")
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 5"
        }
    }
    TabButton {
        contentItem: Text {
            text: qsTr("Возврат товаров")
            opacity: enabled ? 1.0 : 0.3
            color: "#1760A6"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        onClicked: {
            helpText.text = "Example 6"
        }
    }
}
