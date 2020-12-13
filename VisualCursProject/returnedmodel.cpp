#include "returnedmodel.h"
#include "shopdatabase.h"

#include <iostream>

using namespace std;

ReturnedModel::ReturnedModel(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}

QVariant ReturnedModel::data(const QModelIndex & index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> ReturnedModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "idModel";
    roles[NameRole] = "nameModel";
    roles[PriceRole] = "priceModel";
    roles[CategoryRole] = "categoryModel";
    roles[SizeRole] = "sizeModel";
    roles[MadeByRole] = "madebyModel";
    roles[ImageRole] = "imageModel";
    roles[ReturnDateRole] = "returndateModel";
    roles[MaleFemaleRole] = "maleorfemaleModel";
    roles[ReasonRole] = "reasonModel";

    return roles;
}

void ReturnedModel::updateModel(){
         QString prepare = "SELECT id, "
                 TABLE_NAME ", "
                 TABLE_PRICE ", "
                 TABLE_CATEGORY ", "
                 TABLE_SIZE ", "
                 TABLE_MADEBY ", "
                 TABLE_IMAGE ", "
                 TABLE_RETURN_DATE ", "
                 TABLE_MALE_FEMALE", "
                 TABLE_REASON_OF_RETURN " FROM "
                 RETURNED_TABLE;
    this->setQuery(prepare);

}

void ReturnedModel::updateModelWithFilter(const QString& category, const QString& filter, const QString& reason){
    QString topWear = "Цена по возрастанию";
    QString footWear = "Цена по убыванию";
    QString warmWear = "Дата поступления по возрастнию ";
    QString botWear = "Дата поступления по убыванию";
    QString prepare = "";

    if(filter == topWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, ReturnDate, MaleOrFemale, ReasonOfReturn FROM ReturnedClothes WHERE Category='" + category + "' AND ReasonOfReturn='" + reason + "' ORDER BY Price DESC";
    } else if(filter == footWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, ReturnDate, MaleOrFemale, ReasonOfReturn FROM ReturnedClothes WHERE Category='" + category + "' AND ReasonOfReturn='" + reason + "' ORDER BY Price DESC";
    } else if(filter == warmWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, ReturnDate, MaleOrFemale, ReasonOfReturn FROM ReturnedClothes WHERE Category='" + category + "' AND ReasonOfReturn='" + reason + "' ORDER BY ReturnDate ASC";
    } else if(filter == botWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, ReturnDate, MaleOrFemale, ReasonOfReturn FROM ReturnedClothes WHERE Category='" + category + "' AND ReasonOfReturn='" + reason + "' ORDER BY ReturnDate DESC";
    }
    this->setQuery(prepare);
}


int ReturnedModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}

