#ifndef ONSALEMODEL_H
#define ONSALEMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class OnSaleModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles{
        IdRole = Qt::UserRole + 1, //id
        NameRole,
        PriceRole,
        CategoryRole,
        SizeRole,
        MadeByRole,
        ImageRole,
        RecieveDateRole,
        MaleFemaleRole
    };

    explicit OnSaleModel(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateModelWithFilter(const QString& category, const QString& size, const QString& maleFemale, const QString& filter);
    int getId(int row);
    void updateModelWithSearch(const QString& key);
};

#endif // ONSALEMODEL_H
