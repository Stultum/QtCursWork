#include "cashmodel.h"
#include "shopdatabase.h"

#include <iostream>


using namespace std;

CashModel::CashModel(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}


QVariant CashModel::data(const QModelIndex & index, int role) const
{
    int columnId = role - Qt::UserRole - 1;
    QModelIndex modelIndex = this->index(index.row(), columnId);
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
}

QHash<int, QByteArray> CashModel::roleNames() const{
    QHash<int, QByteArray> roles;
    roles[IdRole] = "idModel";
    roles[MoneyRole] = "moneyModel";

    return roles;
}

void CashModel::updateModel(){
         QString prepare = "SELECT id, "
                 TABLE_CASH " FROM "
                 CASH_TABLE;
         qDebug()<<prepare;
    this->setQuery(prepare);

}



int CashModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}
