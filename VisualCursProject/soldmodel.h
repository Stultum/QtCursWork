#ifndef SOLDMODEL_H
#define SOLDMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class SoldModel : public QSqlQueryModel
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
        SoldDateRole,
        MaleFemaleRole
    };

    explicit SoldModel(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateModelWithFilter(const QString& category, const QString& filter, const QString& firstDate, const QString& secondDate);
    int getId(int row);
    void updateModelWithSearch(const QString& key);
};

#endif // SOLDMODEL_H
