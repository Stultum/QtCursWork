import QtQuick 2.5

Rectangle {
    anchors.fill: parent
    color: "green"

    Text {
        text: "Проданные"
        color: "blue"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: dp(50)
        font.pixelSize: dp(30)

        renderType: Text.NativeRendering
    }

}
