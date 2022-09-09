#pragma once

// Qt headers
#include <QByteArray>
#include <QObject>
#include <QAbstractListModel>
#include <QVariant>
#include <QQmlListProperty>
#include <QSortFilterProxyModel>

// local headers
#include "OnvifCamera.hpp"

class OnvifCameraModel : public QAbstractListModel
{
    Q_OBJECT
    Q_DISABLE_COPY(OnvifCameraModel)
    Q_PROPERTY(QQmlListProperty<OnvifCamera> content READ content)
    Q_CLASSINFO("DefaultProperty", "content")

    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)

signals:
    void countChanged(int count);

public slots:
    static void onvifCameraModelAppend(QQmlListProperty<OnvifCamera> *list, OnvifCamera *camera);
    static qsizetype onvifCameraModelCount(QQmlListProperty<OnvifCamera> *list);
    static OnvifCamera *onvifCameraModelAt(QQmlListProperty<OnvifCamera> *list, qsizetype i);
    static void onvifCameraModelClear(QQmlListProperty<OnvifCamera> *list);

    void setCount(int count);

public:
    explicit OnvifCameraModel(QObject *parent = nullptr);

    QQmlListProperty<OnvifCamera> content();
    QHash<int, QByteArray> roleNames() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    int count() const;
    Q_INVOKABLE void append(OnvifCamera *camera);
    Q_INVOKABLE void insert(OnvifCamera *camera, int i);
    Q_INVOKABLE void remove(int i);
    Q_INVOKABLE OnvifCamera *get(int i);
    Q_INVOKABLE void reset();

    Q_INVOKABLE void scan();

private:
    int _count;
    QList<OnvifCamera *> _cameras;
};
