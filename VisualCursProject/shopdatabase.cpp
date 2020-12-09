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
    if(!QFile(DATABASE_NAME).exists()){
            std::cout<<"DataBase connection error!"<<std::endl;
        } else {
            this->openDataBase();
        }
}


bool ShopDataBase::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("ShopDataBase");
    db.setDatabaseName(DATABASE_NAME);
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

}

bool ShopDataBase::insertIntoOnSaleTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &recievedate, const QString &maleorfemale){

}

bool ShopDataBase::insertIntoReturnedTable(const QVariantList &data){

}

bool ShopDataBase::insertIntoReturnedTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &returndate, const QString &maleorfemale, const QString &reason){

}

bool ShopDataBase::insertIntoSoldTable(const QVariantList &data){

}

bool ShopDataBase::insertIntoSoldTable(const QString &name, const QString &price, const QString &category, const QString &size, const QString &madeby, const QString &image, const QString &solddate, const QString &maleorfemale){

}

bool ShopDataBase::removeFromOnSaleTable(const int id){

}

bool ShopDataBase::removeFromReturnedTable(const int id){

}

bool ShopDataBase::removeFromSoldTable(const int id){

}

