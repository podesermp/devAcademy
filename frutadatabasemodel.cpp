#include "frutadatabasemodel.h"
#include <QCoreApplication>
#include <QModelIndex>
#include <QQmlEngine>
#include <QDebug>
#include <QSqlError>
#include <QSqlQuery>
#include <QUuid>

FrutaDatabaseModel::FrutaDatabaseModel(QObject *parent, Database *database) : QSqlTableModel(parent, database->database())
{
    setTable("fruta");
    this->configureRoles();
    this->select();
    this->setEditStrategy(QSqlTableModel::OnRowChange);
}

void FrutaDatabaseModel::configureRoles()
{
    registerRoleColumn(Id, "id");
    registerRoleColumn(Name, "nome");
    registerRoleColumn(Price, "preco");
    registerRoleColumn(Calories, "calorias");
}

QHash<int, QByteArray> FrutaDatabaseModel::roleNames() const
{
    return m_roleColumns;
}

void FrutaDatabaseModel::registerRoleColumn(int role, QByteArray columnName)
{
    m_roleColumns.insert(role, columnName);
}

QVariant FrutaDatabaseModel::data(const QModelIndex &index, int role) const
{
    if(m_roleColumns.contains(role)) {
        int column = fieldIndex(m_roleColumns.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();
}

void FrutaDatabaseModel::newRow(QString name, double price, int calories)
{
    QString id = QUuid().createUuid().toString().replace("{", "").replace("}", "");
    QSqlQuery insertQuery(QSqlTableModel::database());
    insertQuery.prepare(
                "insert into fruta(id, nome, preco, calorias) "
                "VALUES (:id, :nome, :preco, :calorias) "
    );
    insertQuery.bindValue(":id", id);
    insertQuery.bindValue(":nome", name);
    insertQuery.bindValue(":preco", price);
    insertQuery.bindValue(":calorias", calories);
    insertQuery.exec();
    select();
}

void FrutaDatabaseModel::updateRow(QString id, QString name, double price, int calories)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare(
                "update fruta set nome = :nome, preco = :preco, calorias = :calorias "
                "where id = :id"
    );
    updateQuery.bindValue(":id", id);
    updateQuery.bindValue(":nome", name);
    updateQuery.bindValue(":preco", price);
    updateQuery.bindValue(":calorias", calories);
    updateQuery.exec();
    select();
}

void FrutaDatabaseModel::deleteRow(QString id)
{
    QSqlQuery deleteQuery(QSqlTableModel::database());
    deleteQuery.prepare("delete from fruta where id = :id");
    deleteQuery.bindValue(":id", id);
    deleteQuery.exec();
    select();
}

void registerTypes() {
    qmlRegisterType<FrutaDatabaseModel>("Models", 1, 0, "FrutaDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerTypes)
