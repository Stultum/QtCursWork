#ifndef RETURNEDMODEL_H
#define RETURNEDMODEL_H


#include <QObject>
#include <QSqlQueryModel>

class ReturnedModel : public QSqlQueryModel
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
        ReturnDateRole,
        MaleFemaleRole,
        ReasonRole
    };

    explicit ReturnedModel(QObject *parent = 0);

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:

public slots:
    void updateModel();
    void updateModelWithFilter(const QString& category, const QString& filter, const QString& reason);
    int getId(int row);
};

#endif // RETURNEDMODEL_H
