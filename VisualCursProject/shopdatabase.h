#ifndef SHOPDATABASE_H
#define SHOPDATABASE_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>
#define ON_SALE_TABLE "ClothesOnSale"
#define RETURNED_TABLE "ReturnedClothes"
#define SOLD_TABLE "SoldClothes"
#define CASH_TABLE "TotalCash"

#define TABLE_NAME "Name"
#define TABLE_PRICE "Price"
#define TABLE_CATEGORY "Category"
#define TABLE_SIZE "Size"
#define TABLE_MADEBY "MadeBy"
#define TABLE_IMAGE "Image"
#define TABLE_RECIEVE_DATE "RecieveDate"
#define TABLE_MALE_FEMALE "MaleOrFemale"
#define TABLE_RETURN_DATE "ReturnDate"
#define TABLE_REASON_OF_RETURN "ReasonOfReturn"
#define TABLE_SOLD_DATE "SoldDate"
#define TABLE_CASH "Cash"
#define TABLE_COUNT "ClothesCount"
#define DATABASE_NAME "shopDataBase.db"


class ShopDataBase : public QObject
{
    Q_OBJECT
public:
    explicit ShopDataBase(QObject *parent = 0);
    ~ShopDataBase();
    void connectToDataBase();
private:
    QSqlDatabase db;
private:
    bool openDataBase();
    void closeDataBase();
public slots:
    bool insertIntoOnSaleTable(const QVariantList &data);
    bool insertIntoReturnedTable(const QVariantList &data);
    bool insertIntoSoldTable(const QVariantList &data);
    bool insertIntoOnSaleTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &recievedate, const QString &maleorfemale);
    bool insertIntoReturnedTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &returndate, const QString &maleorfemale, const QString &reason);
    bool insertIntoSoldTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &solddate, const QString &maleorfemale);
    bool removeFromOnSaleTable(const int id);
    bool insertIntoCashTable(const QVariantList &data);
    bool insertIntoCashTable(const QString &money);
    bool removeFromCashTable(const int id);
    bool removeFromReturnedTable(const int id);
    bool removeFromSoldTable(const int id);
    bool getByFilter(const QString& filter);
    QString convertDate(QString dateToFlip);
};


#endif // SHOPDATABASE_H
