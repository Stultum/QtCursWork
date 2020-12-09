#include "shopdatabase.h"
#include <iostream>

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
    query.prepare("INSERT INTO ClothesOnSale ( Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale ) "
            "VALUES (:Name, :Price, :Category, :Size, :MadeBy, :Image, :RecieveDate, :MaleFemale)");
    query.bindValue(":Name", data[0].toString());
    query.bindValue(":Price", data[1].toString());
    query.bindValue(":Category", data[2].toString());
    query.bindValue(":Size", data[3].toString());
    query.bindValue(":MadeBy", data[4].toString());
    query.bindValue(":Image", data[5].toString());
    query.bindValue(":RecieveDate", data[6].toString());
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
    query.prepare("INSERT INTO" RETURNED_TABLE " ( "
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
    query.bindValue(":ReturnDate", data[6].toString());
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

    if(insertIntoOnSaleTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::insertIntoSoldTable(const QVariantList &data){
    QSqlQuery query;
    query.prepare("INSERT INTO" SOLD_TABLE " ( "
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
    query.bindValue(":SoldDate", data[6].toString());
    query.bindValue(":MaleFemale", data[7].toString());

    if(!query.exec()){
        std::cout<< "error insert into "<<SOLD_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
        return false;
    } else {
        return true;
    }
    return false;
}

bool ShopDataBase::insertIntoSoldTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &solddate, const QString &maleorfemale){
    QVariantList data;
    data.append(name);
    data.append(price);
    data.append(category);
    data.append(size);
    data.append(madeby);
    data.append(image);
    data.append(solddate);
    data.append(maleorfemale);

    if(insertIntoOnSaleTable(data))
        return true;
    else
        return false;
}

bool ShopDataBase::removeFromOnSaleTable(const int id){
    QSqlQuery query;

    query.prepare("DELETE FROM" ON_SALE_TABLE "WHERE id = :ID ;");
    query.bindValue(":ID", id);

    if(!query.exec()){
        std::cout<< "error delete from "<<ON_SALE_TABLE<<std::endl;
        std::cout<< query.lastError().text().toStdString()<<std::endl;
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
