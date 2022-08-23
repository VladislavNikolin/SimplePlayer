#pragma once

// Qt headers
#include <QObject>
#include <QUrl>

// 3rdparty headers
#include "onvif.h"

class OnvifCamera : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name CONSTANT)
    Q_PROPERTY(QUrl uri READ uri NOTIFY uriChanged)
    Q_PROPERTY(bool is_authorized READ is_authorized NOTIFY isAuthorizedChanged)

signals:
    void uriChanged(QUrl uri);
    void isAuthorizedChanged(bool is_authorized);

public:
    OnvifCamera(const OnvifData& data, QObject *parent = nullptr);

    QString name() const;
    QUrl uri() const;
    bool is_authorized() const;

    Q_INVOKABLE void authorize(const QString &username, const QString &password);

private:
    OnvifData _onvif_data;

    bool _is_authorized;
    QUrl _uri;
};
