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
    roles[IdRole] = "id";
    roles[NameRole] = "name";
    roles[PriceRole] = "priceThis";
    roles[CategoryRole] = "category";
    roles[SizeRole] = "size";
    roles[MadeByRole] = "madeby";
    roles[ImageRole] = "image";
    roles[RecieveDateRole] = "recievedate";
    roles[MaleFemaleRole] = "maleorfemale";

    return roles;
}

void OnSaleModel::updateModel(){
    this->setQuery("SELECT id, "
                    TABLE_NAME ", "
                    TABLE_PRICE ", "
                    TABLE_CATEGORY ", "
                    TABLE_SIZE ", "
                    TABLE_MADEBY ", "
                    TABLE_IMAGE ", "
                    TABLE_RECIEVE_DATE ", "
                    TABLE_MALE_FEMALE " FROM "
                    ON_SALE_TABLE);
}

int OnSaleModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}
