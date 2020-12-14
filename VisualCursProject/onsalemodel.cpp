#include "onsalemodel.h"
#include "shopdatabase.h"

#include <iostream>

using namespace std;

OnSaleModel::OnSaleModel(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}

QVariant OnSaleModel::data(const QModelIndex & index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> OnSaleModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "idModel";
    roles[NameRole] = "nameModel";
    roles[PriceRole] = "priceModel";
    roles[CategoryRole] = "categoryModel";
    roles[SizeRole] = "sizeModel";
    roles[MadeByRole] = "madebyModel";
    roles[ImageRole] = "imageModel";
    roles[RecieveDateRole] = "recievedateModel";
    roles[MaleFemaleRole] = "maleorfemaleModel";

    return roles;
}

void OnSaleModel::updateModel(){
         QString prepare = "SELECT id, "
                 TABLE_NAME ", "
                 TABLE_PRICE ", "
                 TABLE_CATEGORY ", "
                 TABLE_SIZE ", "
                 TABLE_MADEBY ", "
                 TABLE_IMAGE ", "
                 TABLE_RECIEVE_DATE ", "
                 TABLE_MALE_FEMALE " FROM "
                 ON_SALE_TABLE;
    this->setQuery(prepare);

}

void OnSaleModel::updateModelWithFilter(const QString& category, const QString& size, const QString& maleFemale, const QString& filter){
    QString topWear = "Цена по возрастанию";
    QString footWear = "Цена по убыванию";
    QString warmWear = "Дата поступления по возрастнию ";
    QString botWear = "Дата поступления по убыванию";
    QString prepare = "";

    if(filter == topWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale FROM ClothesOnSale WHERE Category='" + category + "' AND Size='" + size + "' AND MaleOrFemale='" + maleFemale + "' ORDER BY Price DESC";
    } else if(filter == footWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale FROM ClothesOnSale WHERE Category='" + category + "' AND Size='" + size + "' AND MaleOrFemale='" + maleFemale + "' ORDER BY Price ASC";
    } else if(filter == warmWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale FROM ClothesOnSale WHERE Category='" + category + "' AND Size='" + size + "' AND MaleOrFemale='" + maleFemale + "' ORDER BY RecieveDate ASC";
    } else if(filter == botWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale FROM ClothesOnSale WHERE Category='" + category + "' AND Size='" + size + "' AND MaleOrFemale='" + maleFemale + "' ORDER BY RecieveDate DESC";
    }
    this->setQuery(prepare);
}


int OnSaleModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}

void OnSaleModel::updateModelWithSearch(const QString& key){
    QString prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, RecieveDate, MaleOrFemale FROM ClothesOnSale WHERE Name='" + key + "'";
     this->setQuery(prepare);
}
