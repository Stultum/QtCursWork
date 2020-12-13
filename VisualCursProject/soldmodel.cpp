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

    QString first = firstDate;
    QString second = secondDate;
        QString day1 = "";
        QString year1 = "";
        QString month1 = "";

        if(first.size() == 10)
        {
        day1 += first[0];
        day1 += first[1];
        month1 += first[3];
        month1 += first[4];
        year1 += first[6];
        year1 += first[7];
        year1 += first[8];
        year1 += first[9];
    }

        if(first.size() == 9)
        {
            day1 += first[0];
            month1 += first[2];
            month1 += first[3];
            year1 += first[5];
            year1 += first[6];
            year1 += first[7];
            year1 += first[8];
    }

        QString day2 = "";
        QString year2 = "";
        QString month2 = "";

        if(second.size() == 10)
        {
        day2 += second[0];
        day2 += second[1];
        month2 += second[3];
        month2 += second[4];
        year2 += second[6];
        year2 += second[7];
        year2 += second[8];
        year2 += second[9];
    }

        if(second.size() == 9)
        {
            day2 += second[0];
            month2 += second[2];
            month2 += second[3];
            year2 += second[5];
            year2 += second[6];
            year2 += second[7];
            year2 += second[8];
    }
        QString date1 = year1 + "." + month1 + "." + day1;
    QString date2 = year2 + "." + month2 + "." + day2;

    if(filter == topWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + date1 + "' AND SoldDate <='" + date2 + "' ORDER BY Price ASC";
    } else if(filter == footWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + date1 + "' AND SoldDate <='" + date2 + "' ORDER BY Price DESC";
    } else if(filter == warmWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + date1 + "' AND SoldDate <='" + date2 + "'";
    } else if(filter == botWear){
        prepare = "SELECT id, Name, Price, Category, Size, MadeBy, Image, SoldDate, MaleOrFemale FROM SoldClothes WHERE Category='" + category + "' AND SoldDate >='" + date1 + "' AND SoldDate <='" + date2 + "'";
    }
    this->setQuery(prepare);
}


int SoldModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}
