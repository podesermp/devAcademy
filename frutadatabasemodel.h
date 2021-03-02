#ifndef FRUTADATABASEMODEL_H
#define FRUTADATABASEMODEL_H
#include <QtSql/QSqlTableModel>
#include "database.h"

class FrutaDatabaseModel: public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles {
        Id = Qt::UserRole + 1,
        Name,
        Calories,
        Price
    };
    Q_ENUM(Roles)
    explicit FrutaDatabaseModel(QObject *parent = nullptr, Database *database = new Database());
    void configureRoles();
    void registerRoleColumn(int role, QByteArray columnName);
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
//    void setData(const QModelIndex &index, const QVariant &value, int role) const override;

    Q_INVOKABLE void newRow(QString name, double price, int calories);
    Q_INVOKABLE void updateRow(QString id, QString name, double price, int calories);
    Q_INVOKABLE void deleteRow(QString id);

    Q_INVOKABLE QHash<int, QByteArray> roleNames() const;

private:
    Database m_db;
    QHash<int, QByteArray> m_roleColumns;
};

#endif // FRUTADATABASEMODEL_H
