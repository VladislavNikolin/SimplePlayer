#pragma once

// standard headers
#include <cstdint>

// Qt headers
#include <QObject>
#include <QUrl>

// 3rdparty headers
#include "onvif.h"

class OnvifCamera : public QObject
{
    Q_OBJECT

    // system properties
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(QUrl uri READ uri NOTIFY uriChanged)
    Q_PROPERTY(bool isAuthorized READ isAuthorized NOTIFY isAuthorizedChanged)

    // network properties
    Q_PROPERTY(bool isDHCP READ isDHCP WRITE setDHCP NOTIFY isDHCPChanged)
    Q_PROPERTY(QString ipAddress READ ipAddress WRITE setIPAddress NOTIFY ipAddressChanged)
    Q_PROPERTY(quint8 ipPrefix READ ipPrefix WRITE setIPPrefix NOTIFY ipPrefixChanged)

    // imaging properties
    Q_PROPERTY(quint8 brightness READ brightness WRITE setBrightness NOTIFY brightnessChanged)
    Q_PROPERTY(quint8 saturation READ saturation WRITE setSaturation NOTIFY saturationChanged)
    Q_PROPERTY(quint8 contrast READ contrast WRITE setContrast NOTIFY contrastChanged)
    Q_PROPERTY(quint8 sharpness READ sharpness WRITE setSharpness NOTIFY sharpnessChanged)

signals:
    // system signals
    void nameChanged(const QString& name);
    void uriChanged(const QUrl& uri);
    void isAuthorizedChanged(const bool authorized);

    // network signals
    void isDHCPChanged(const bool enabled);
    void ipAddressChanged(const QString& ip_address);
    void ipPrefixChanged(const quint8 ip_prefix);

    // imaging signals
    void brightnessChanged(const quint8 brightness);
    void saturationChanged(const quint8 saturation);
    void contrastChanged(const quint8 contrast);
    void sharpnessChanged(const quint8 sharpness);

public:
    OnvifCamera(const OnvifData &data, QObject *parent = nullptr);

    // invokable methods
    Q_INVOKABLE bool authorize(const QString &username, const QString &password);
    Q_INVOKABLE void reboot();
    Q_INVOKABLE void factoryReset();
    Q_INVOKABLE void pushSettings();
    Q_INVOKABLE void pushNetworkSettings();
    Q_INVOKABLE void pushImagingSettings();

    // system getters / setters
    QString name() const;
    QUrl uri() const;
    bool isAuthorized() const;

    // network getters / setters
    bool isDHCP() const;
    void setDHCP(const bool enabled);
    QString ipAddress() const;
    void setIPAddress(const QString& ip_address);
    quint8 ipPrefix() const;
    void setIPPrefix(const quint8 ip_prefix);

    // imaging getters / setters
    quint8 brightness() const;
    void setBrightness(const quint8 brightness);
    quint8 saturation() const;
    void setSaturation(const quint8 saturation);
    quint8 contrast() const;
    void setContrast(const quint8 contrast);
    quint8 sharpness() const;
    void setSharpness(const quint8 sharpness);

private:
    OnvifData _onvif_data;
    bool _is_authorized;
    QUrl _uri;

    void pullSettings();
    void pullSystemSettings();
    void pullNetworkSettings();
    void pullImagingSettings();
};
