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
                text: "<h1>Добро пожаловать в программу для учета продажи одежды<h1> <p>&nbsp;</p>
<h3>Данное окно предназначено для предоставаления справки о том, как работать в программе.<h3> <p>&nbsp;</p>
<h3>Чтобы получить помощь по функционалу интересующего вас окна, нажмите на соответствующую вкладку сверху.<h3><p>&nbsp;</p>"
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
            helpText.text
                    = "<h1>Добро пожаловать в программу для учета продажи одежды<h1> <p>&nbsp;</p>
<h3>Данное окно предназначено для предоставаления справки о том, как работать в программе.<h3> <p>&nbsp;</p>
<h3>Чтобы получить помощь по функционалу интересующего вас окна, нажмите на соответствующую вкладку сверху.<h3><p>&nbsp;</p>"
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
            helpText.text = "<h1>Раздел товаров на продаже<h1> <p>&nbsp;</p>
<h3>На этом экране показывается список товаров, находящихся в данный момент на продаже.  <p>&nbsp;</p><p>&nbsp;</p>Здесь можно кликнуть на товар и увидеть подробную информацию о товаре.<p>&nbsp;</p> <p>&nbsp;</p>
Также, в подробном описании можно удалить товар из позиции и редактировать описание товара.  <p>&nbsp;</p><p>&nbsp;</p>Помимо списка, на экране присутствуют различные
средства для фильтрации и сортировки списка <p>&nbsp;</p>по заданным параметрам. <p>&nbsp;</p> <p>&nbsp;</p>Чтобы показать список товаров без фильтров, нажмите кнопку Показать все товары.<p>&nbsp;</p> <p>&nbsp;</p>
Для добавления товара в список, нажмите кнопку Добавить товар.  <p>&nbsp;</p><p>&nbsp;</p>При нажатии на кнопку откроется окно, которое содержит поля для описания товара,<p>&nbsp;</p>а также
поле для загрузки изображения товара.<p>&nbsp;</p> <p>&nbsp;</p>
<h3>"
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
            helpText.text = "<h1>Раздел проданных товаров<h1> <p>&nbsp;</p>
<h3>На этом экране показывается список проданных товаров.  <p>&nbsp;</p><p>&nbsp;</p>Здесь можно кликнуть на товар и увидеть подробную информацию о товаре.<p>&nbsp;</p> <p>&nbsp;</p>
Также, в подробном описании можно удалить товар из позиции и редактировать описание товара.  <p>&nbsp;</p><p>&nbsp;</p>Помимо списка, на экране присутствуют различные
средства для фильтрации и сортировки списка <p>&nbsp;</p>по заданным параметрам. <p>&nbsp;</p> <p>&nbsp;</p>Чтобы показать список товаров без фильтров, нажмите кнопку Показать все товары.<p>&nbsp;</p> <p>&nbsp;</p>
Для формирования отчета за определенный период, введите в соответствующие поля дату в формате дд.мм.гг. <p>&nbsp;</p><p>&nbsp;</p>
<h3>"
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
            helpText.text = "<h1>Раздел возвращенных товаров<h1> <p>&nbsp;</p>
<h3>На этом экране показывается список возвращенных товаров.  <p>&nbsp;</p><p>&nbsp;</p>Здесь можно кликнуть на товар и увидеть подробную информацию о товаре.<p>&nbsp;</p> <p>&nbsp;</p>
Также, в подробном описании можно удалить товар из позиции и редактировать описание товара.  <p>&nbsp;</p><p>&nbsp;</p>Помимо списка, на экране присутствуют различные
средства для фильтрации и сортировки списка <p>&nbsp;</p>по заданным параметрам. <p>&nbsp;</p> <p>&nbsp;</p>Чтобы показать список товаров без фильтров, нажмите кнопку Показать все товары.<p>&nbsp;</p> <p>&nbsp;</p>
<h3>"
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
            helpText.text = "<h1>Окно продажи товара<h1> <p>&nbsp;</p>
<h3>На этом экране реализована продажа товаров из магазина.  <p>&nbsp;</p><p>&nbsp;</p>Здесь можно ввести в текстовое поле название товара, и будет выведен список товаров с таким именем.<p>&nbsp;</p> <p>&nbsp;</p>
Кликнув на товар, можно увидеть его подробное описание и кнопку продажи товара.  <p>&nbsp;</p><p>&nbsp;</p>При нажатии на кнопку проаджу, появится окно с подтверждением продажи. <p>&nbsp;</p> <p>&nbsp;</p>Чтобы показать список всех товаров, нажмите кнопку Показать все товары.<p>&nbsp;</p> <p>&nbsp;</p>
<h3>"
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
            helpText.text = "<h1>Окно возврата товара<h1> <p>&nbsp;</p>
<h3>На этом экране реализован возврат товаров из магазина.  <p>&nbsp;</p><p>&nbsp;</p>Здесь можно ввести в текстовое поле название товара, и будет выведен список товаров с таким именем.<p>&nbsp;</p> <p>&nbsp;</p>
Кликнув на товар, можно увидеть его подробное описание и кнопку возврата товара.  <p>&nbsp;</p><p>&nbsp;</p>При нажатии на кнопку возврата, появится окно с подтверждением возврата и указанием причины возврата. <p>&nbsp;</p> <p>&nbsp;</p>Чтобы показать список всех товаров, нажмите кнопку Показать все товары.<p>&nbsp;</p> <p>&nbsp;</p>
<h3>"
        }
    }
}
