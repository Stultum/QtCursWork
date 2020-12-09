#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>

#include "shopdatabase.h"
#include "onsalemodel.h"

using namespace std;


int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ShopDataBase database;
    database.connectToDataBase();

    OnSaleModel *onSaleModel = new OnSaleModel();

    engine.rootContext()->setContextProperty("onSaleModel", onSaleModel);
    engine.rootContext()->setContextProperty("database", &database);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
