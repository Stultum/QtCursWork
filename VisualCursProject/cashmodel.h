#ifndef CASHMODEL_H
#define CASHMODEL_H


#include <QObject>
#include <QSqlQueryModel>

class CashModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles{
        IdRole = Qt::UserRole + 1, //id
        MoneyRole
    };

    explicit CashModel(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    int getId(int row);
};

#endif // CASHMODEL_H
