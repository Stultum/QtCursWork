#include "soldmodel.h"
#include "shopdatabase.h"

#include <iostream>

using namespace std;

SoldModel::SoldModel(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}

QVariant SoldModel::data(const QModelIndex & index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> SoldModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "idModel";
    roles[NameRole] = "nameModel";
    roles[PriceRole] = "priceModel";
    roles[CategoryRole] = "categoryModel";
    roles[SizeRole] = "sizeModel";
    roles[MadeByRole] = "madebyModel";
    roles[ImageRole] = "imageModel";
    roles[SoldDateRole] = "solddateModel";
    roles[MaleFemaleRole] = "maleorfemaleModel";

    return roles;
}

void SoldModel::updateModel(){
         QString prepare = "SELECT id, "
                 TABLE_NAME ", "
                 TABLE_PRICE ", "
                 TABLE_CATEGORY ", "
                 TABLE_SIZE ", "
                 TABLE_MADEBY ", "
                 TABLE_IMAGE ", "
                 TABLE_SOLD_DATE ", "
                 TABLE_MALE_FEMALE " FROM "
                 SOLD_TABLE;
    this->setQuery(prepare);

}

void SoldModel::updateModelWithFilter(const QString& category, const QString& filter, const QString& firstDate, const QString& secondDate){
    QString topWear = "Цена по возрастанию";
    QString footWear = "Цена по убыванию";
    QString warmWear = "Дата поступления по возрастнию ";
    QString botWear = "Дата поступления по убыванию";
    QString prepare = "";

    if(filter == topWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + firstDate + "' AND SoldDate <='" + secondDate + " ORDER BY Price DESC";
    } else if(filter == footWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + firstDate + "' AND SoldDate <='" + secondDate + "' ORDER BY Price DESC";
    } else if(filter == warmWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + firstDate + "' AND SoldDate <='" + secondDate + "' ORDER BY RecieveDate ASC";
    } else if(filter == botWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + firstDate + "' AND SoldDate <='" + secondDate + "' ORDER BY RecieveDate DESC";
    }
    this->setQuery(prepare);
}


int SoldModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}
