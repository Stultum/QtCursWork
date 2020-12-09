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
         qDebug() << "updating";
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

void OnSaleModel::updateModelFilter(const QString& filter){
    QString topWear = "Верхняя одежда";
    QString footWear = "Обувь";
    QString warmWear = "Свитеры/Джемперы";
    QString botWear = "Брюки/Джинсы";
    QString lightWear = "Футболки/Блузки/Рубашки";
    QString femaleWear = "Юбки/Платья";

    if(filter == topWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Category = 'Верхняя Одежда'");
    } else if(filter == footWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Category = 'Обувь'");
    } else if(filter == warmWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Category = 'Свитеры/Джемперы'");
    } else if(filter == botWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Category = 'Брюки/Джинсы'");
    } else if(filter == lightWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Category = 'Футболки/Блузки/Рубашки'");
    }
    else if(filter == femaleWear){
            qDebug()<<"here";
            this->setQuery("SELECT id, "
                            TABLE_NAME ", "
                            TABLE_PRICE ", "
                            TABLE_CATEGORY ", "
                            TABLE_SIZE ", "
                            TABLE_MADEBY ", "
                            TABLE_IMAGE ", "
                            TABLE_RECIEVE_DATE ", "
                            TABLE_MALE_FEMALE " FROM "
                            ON_SALE_TABLE " WHERE Category = 'Юбки/Платья'");
        }
}

void OnSaleModel::updateModelSize(const QString& size){
    QString topWear = "S";
    QString footWear = "M";
    QString warmWear = "L";
    QString botWear = "XL";
    QString lightWear = "XXL";

    if(size == topWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Size = 'S'");
    } else if(size == footWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Size = 'M'");
    } else if(size == warmWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Size = 'L'");
    } else if(size == botWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Size = 'XL'");
    } else if(size == lightWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE Size = 'XXL'");
    }
}

void OnSaleModel::updateModelSort(const QString& size){
    QString topWear = "Цена по возрастанию";
    QString footWear = "Цена по убыванию";
    QString warmWear = "Дата поступления по возрастнию ";
    QString botWear = "Дата поступления по убыванию";

    if(size == topWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " ORDER BY Price ASC");
    } else if(size == footWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " ORDER BY Price DESC");
    } else if(size == warmWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " ORDER BY RecieveDate ASC");
    } else if(size == botWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " ORDER BY RecieveDate DESC");
    }
}

void OnSaleModel::updateModelSex(const QString& size){
    QString topWear = "Мужская";
    QString footWear = "Женская";

    if(size == topWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE MaleOrFemale = 'Мужская'");
    } else if(size == footWear){
        qDebug()<<"here";
        this->setQuery("SELECT id, "
                        TABLE_NAME ", "
                        TABLE_PRICE ", "
                        TABLE_CATEGORY ", "
                        TABLE_SIZE ", "
                        TABLE_MADEBY ", "
                        TABLE_IMAGE ", "
                        TABLE_RECIEVE_DATE ", "
                        TABLE_MALE_FEMALE " FROM "
                        ON_SALE_TABLE " WHERE MaleOrFemale = 'Женская'");
    }
}

int OnSaleModel::getId(int row){
    return this->data(this->index(row, 0), IdRole).toInt();
}
