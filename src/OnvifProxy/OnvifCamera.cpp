// standard c+ headers
#include <cstring>

// local headers
#include "OnvifCamera.hpp"

OnvifCamera::OnvifCamera(const OnvifData &data, QObject *parent) : _onvif_data(data), QObject(parent)
{
}

bool OnvifCamera::authorize(const QString &username, const QString &password)
{
    strcpy(_onvif_data.username, qPrintable(username));
    strcpy(_onvif_data.password, qPrintable(password));
    if (fillRTSP(&_onvif_data))
        return false;
    
    pullSettings();
    emit isAuthorizedChanged(_is_authorized = true);
    return true;
}

void OnvifCamera::reboot()
{
    rebootCamera(&_onvif_data);
}

void OnvifCamera::factoryReset()
{
    hardReset(&_onvif_data);
}

void OnvifCamera::pushSettings()
{
    // push_system_settings() ???
    pushNetworkSettings();
    pushImagingSettings();
}

void OnvifCamera::pushNetworkSettings()
{
    setNetworkInterfaces(&_onvif_data);
}

void OnvifCamera::pushImagingSettings()
{
    setImagingSettings(&_onvif_data);
}

void OnvifCamera::pullSettings()
{
    pullSystemSettings();
    pullNetworkSettings();
    pullImagingSettings();
}

void OnvifCamera::pullSystemSettings()
{
    _uri.setUrl(_onvif_data.stream_uri);
    _uri.setUserName(_onvif_data.username);
    _uri.setPassword(_onvif_data.password);
    emit uriChanged(_uri);
}

void OnvifCamera::pullNetworkSettings()
{
    getNetworkInterfaces(&_onvif_data);
    emit isDHCPChanged(_onvif_data.dhcp_enabled);
    emit ipAddressChanged(_onvif_data.ip_address_buf);
    emit ipPrefixChanged(_onvif_data.prefix_length);
}

void OnvifCamera::pullImagingSettings()
{
    strcpy(_onvif_data.videoSourceConfigurationToken, "VideoStream");
    getImagingSettings(&_onvif_data);
    emit brightnessChanged(_onvif_data.brightness);
    emit saturationChanged(_onvif_data.saturation);
    emit contrastChanged(_onvif_data.contrast);
    emit sharpnessChanged(_onvif_data.sharpness);
}

QString OnvifCamera::name() const
{
    return _onvif_data.camera_name;
}

QUrl OnvifCamera::uri() const
{
    return _uri;
}

bool OnvifCamera::isAuthorized() const
{
    return _is_authorized;
}

bool OnvifCamera::isDHCP() const
{
    return _onvif_data.dhcp_enabled;
}

void OnvifCamera::setDHCP(const bool enabled)
{
    _onvif_data.dhcp_enabled = enabled;
    emit isDHCPChanged(enabled);
}

QString OnvifCamera::ipAddress() const
{
    return _onvif_data.ip_address_buf;
}

void OnvifCamera::setIPAddress(const QString& ip_address)
{
    strcpy(_onvif_data.ip_address_buf, qPrintable(ip_address));
    emit ipAddressChanged(ip_address);
}

quint8 OnvifCamera::ipPrefix() const
{
    return _onvif_data.prefix_length;
}

void OnvifCamera::setIPPrefix(const quint8 ip_prefix)
{
    _onvif_data.prefix_length = ip_prefix;
    emit ipPrefixChanged(ip_prefix);
}

quint8 OnvifCamera::brightness() const
{
    return _onvif_data.brightness;
}

quint8 OnvifCamera::saturation() const
{
    return _onvif_data.saturation;
}

quint8 OnvifCamera::contrast() const
{
    return _onvif_data.contrast;
}

quint8 OnvifCamera::sharpness() const
{
    return _onvif_data.sharpness;
}
