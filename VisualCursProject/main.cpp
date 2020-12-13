#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>

#include "shopdatabase.h"
#include "onsalemodel.h"
#include "soldmodel.h"
#include "onsalemodel.h"
#include "cashmodel.h"

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
    SoldModel* soldModel = new SoldModel();
    CashModel* cashModel = new CashModel();

    engine.rootContext()->setContextProperty("onSaleModel", onSaleModel);
    engine.rootContext()->setContextProperty("SoldModel", soldModel);
    engine.rootContext()->setContextProperty("CashModel", cashModel);
    engine.rootContext()->setContextProperty("database", &database);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
