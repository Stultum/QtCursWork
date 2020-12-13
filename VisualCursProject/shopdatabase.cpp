#include "shopdatabase.h"
#include <iostream>

using namespace std;

ShopDataBase::ShopDataBase(QObject *parent) : QObject(parent)
{

}

ShopDataBase::~ShopDataBase()
{

}

void ShopDataBase::connectToDataBase()
{
    if(!QFile("C:/" DATABASE_NAME).exists()){
            std::cout<<"DataBase connection error!"<<std::endl;
        } else {
            this->openDataBase();
        }
}


bool ShopDataBase::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("ShopDataBase");
    db.setDatabaseName("C:/"DATABASE_NAME);
    if(db.open()){
        std::cout<<"DataBase succesfully connected!"<<std::endl;
        return true;
    } else {
        std::cout<<"DataBase open error!"<<std::endl;
        return false;
    }
}

void ShopDataBase::closeDataBase(){
    db.close();
}

bool ShopDataBase::insertIntoOnSaleTable(const QVariantList &data){
    QSqlQuery query;
        qDebug()<<"entered insert sale";
    QString first = data[6].toString();
        QString day = "";
        QString year = "";
        QString month = "";

        if(first.size() == 10)
        {
        day += first[0];
        day += first[1];
        month += first[3];
        month += first[4];
        year += first[6];
        year += first[7];
        year += first[8];
        year += first[9];
    }

        if(first.size() == 9)
        {
            day += first[0];
            month += first[2];
            month += first[3];
            year += first[5];
            year += first[6];
            year += first[7];
            year += first[8];
    }
        QString date = year + "." + month + "." + day;

    query.prepare("INSERT INTO ClothesOnSale ( Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale ) "
            "VALUES (:Name, :Price, :Category, :Size, :MadeBy, :Image, :RecieveDate, :MaleFemale)");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Price", data[1].toString());
    query.bindValue(":Category", data[2].toString());
    query.bindValue(":Size", data[3].toString());
    query.bindValue(":MadeBy", data[4].toString());
    query.bindValue(":Image", data[5].toString());
    query.bindValue(":RecieveDate", date);
    query.bindValue(":MaleFemale", data[7].toString());

    if(!query.exec()){
        std::cout<< "error insert into "<<ON_SALE_TABLE<<std::endl;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return true;
}

bool ShopDataBase::insertIntoOnSaleTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &recievedate, const QString &maleorfemale){
    QVariantList data;
    qDebug()<<"entered insert sale";


    data.append(name);
    data.append(price);
    data.append(category);
    data.append(size);
    data.append(madeby);
    data.append(image);
    data.append(recievedate);
    data.append(maleorfemale);
    qDebug() <<data[1];

    if(insertIntoOnSaleTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::insertIntoReturnedTable(const QVariantList &data){
    QSqlQuery query;
    QString first = data[6].toString();
        QString day = "";
                qDebug()<<"entered insert return";
        QString year = "";
        QString month = "";

        if(first.size() == 10)
        {
        day += first[0];
        day += first[1];
        month += first[3];
        month += first[4];
        year += first[6];
        year += first[7];
        year += first[8];
        year += first[9];
    }

        if(first.size() == 9)
        {
            day += first[0];
            month += first[2];
            month += first[3];
            year += first[5];
            year += first[6];
            year += first[7];
            year += first[8];
    }
        QString date = year + "." + month + "." + day;
    query.prepare("INSERT INTO " RETURNED_TABLE " ( "
                  TABLE_NAME ", "
                  TABLE_PRICE ", "
                  TABLE_CATEGORY ", "
                  TABLE_SIZE ", "
                  TABLE_MADEBY ", "
                  TABLE_IMAGE ", "
                  TABLE_RETURN_DATE ", "
                  TABLE_MALE_FEMALE " , "
                  TABLE_REASON_OF_RETURN " ) "
            "VALUES (:Name, :Price, :Category, :Size, :MadeBy, :Image, :ReturnDate, :MaleFemale, :Reason)");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Price", data[1].toString());
    query.bindValue(":Category", data[2].toString());
    query.bindValue(":Size", data[3].toString());
    query.bindValue(":MadeBy", data[4].toString());
    query.bindValue(":Image", data[5].toString());
    query.bindValue(":ReturnDate", date);
    query.bindValue(":MaleFemale", data[7].toString());
    query.bindValue(":Reason", data[8].toString());

    if(!query.exec()){
        std::cout<< "error insert into "<<RETURNED_TABLE<<std::endl;
        qDebug() << query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::insertIntoReturnedTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &returndate, const QString &maleorfemale, const QString &reason){
        qDebug()<<"entered insert return";
    QVariantList data;
    data.append(name);
    data.append(price);
    data.append(category);
    data.append(size);
    data.append(madeby);
    data.append(image);
    data.append(returndate);
    data.append(maleorfemale);
    data.append(reason);

    if(insertIntoReturnedTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::insertIntoSoldTable(const QVariantList &data){
    QSqlQuery query;
        qDebug()<<"entered insert sold";
    QString first = data[6].toString();
        QString day = "";
        QString year = "";
        QString month = "";

        if(first.size() == 10)
        {
        day += first[0];
        day += first[1];
        month += first[3];
        month += first[4];
        year += first[6];
        year += first[7];
        year += first[8];
        year += first[9];
    }

        if(first.size() == 9)
        {
            day += first[0];
            month += first[2];
            month += first[3];
            year += first[5];
            year += first[6];
            year += first[7];
            year += first[8];
    }
        QString date = year + "." + month + "." + day;
        query.bindValue(":Name", data[0].toString());
        query.bindValue(":Price", data[1].toString());
        query.bindValue(":Category", data[2].toString());
        query.bindValue(":Size", data[3].toString());
        query.bindValue(":MadeBy", data[4].toString());
        query.bindValue(":Image", data[5].toString());
        query.bindValue(":RecieveDate", date);
        query.bindValue(":MaleFemale", data[7].toString());
    query.prepare("INSERT INTO " SOLD_TABLE " ( "
                  TABLE_NAME ", "
                  TABLE_PRICE ", "
                  TABLE_CATEGORY ", "
                  TABLE_SIZE ", "
                  TABLE_MADEBY ", "
                  TABLE_IMAGE ", "
                  TABLE_SOLD_DATE ", "
                  TABLE_MALE_FEMALE " ) "
            "VALUES (:Name, :Price, :Category, :Size, :MadeBy, :Image, :SoldDate, :MaleFemale)");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Price", data[1].toString());
    query.bindValue(":Category", data[2].toString());
    query.bindValue(":Size", data[3].toString());
    query.bindValue(":MadeBy", data[4].toString());
    query.bindValue(":Image", data[5].toString());
    query.bindValue(":SoldDate", date);
    query.bindValue(":MaleFemale", data[7].toString());

    if(!query.exec()){
        std::cout<< "error insert into "<<SOLD_TABLE<<std::endl;
        qDebug()<< query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::insertIntoSoldTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &solddate, const QString &maleorfemale){
    qDebug()<<"entered insert sold";
    QVariantList data;
    data.append(name);
    data.append(price);
    data.append(category);
    data.append(size);
    data.append(madeby);
    data.append(image);
    data.append(solddate);
    data.append(maleorfemale);

    if(insertIntoSoldTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::removeFromOnSaleTable(const int id){
    QSqlQuery query;

    query.prepare("DELETE FROM " ON_SALE_TABLE " WHERE id = :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        qDebug()<< query.lastError().text();
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::removeFromReturnedTable(const int id){
    QSqlQuery query;

    query.prepare("DELETE FROM" RETURNED_TABLE "WHERE id = :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        std::cout<< "error delete from "<<RETURNED_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::removeFromSoldTable(const int id){
    QSqlQuery query;

    query.prepare("DELETE FROM" SOLD_TABLE "WHERE id = :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        std::cout<< "error delete from "<<SOLD_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::getByFilter(const QString& filter){
    QSqlQuery query;
    query.prepare("SELECT *  FROM "
                        ON_SALE_TABLE " WHERE Category = :catThis");
    query.bindValue(":catThis", filter);
    if(!query.exec()){
        std::cout<< "error get from "<<SOLD_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        qDebug()<<filter;
        return true;
    }
    return false;
}
QString ShopDataBase::convertDate(QString dateToFlip){
    QString first = dateToFlip;
    QString day = "";
    QString month = "";
    QString year = "";

    if(first.size() == 10)
    {
    year += first[0];
    year += first[1];
    year += first[2];
    year += first[3];
    month += first[5];
    month += first[6];
    day += first[8];
    day += first[9];
}

    if(first.size() == 9)
    {
    year += first[0];
    year += first[1];
    year += first[2];
    year += first[3];
    month += first[5];
    month += first[6];
    day += first[8];
}
    QString date = day + "." + month + "." + year;
    return date;
}

bool ShopDataBase::insertIntoCashTable(const QVariantList &data){
    QSqlQuery query;
    query.prepare("INSERT INTO" CASH_TABLE " ( " TABLE_CASH " ) "
            "VALUES (:Money)");
    query.bindValue(":Money", data[0].toInt());

    if(!query.exec()){
        std::cout<< "error insert into "<<CASH_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::insertIntoCashTable(const QString &money){
    QVariantList data;
    data.append(money);

    if(insertIntoOnSaleTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::removeFromCashTable(const int id){
    QSqlQuery query;

    query.prepare("DELETE FROM" CASH_TABLE "WHERE id = :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        std::cout<< "error delete from "<<CASH_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        return true;
    }
    return false;
}

//void ShopDataBase::renewCash(int plusCash){
//    totalCash+=plusCash;
//}


