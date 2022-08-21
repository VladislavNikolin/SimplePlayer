// standard c+ headers
#include <cstring>

// local headers
#include "OnvifCamera.hpp"

OnvifCamera::OnvifCamera(const OnvifData &data, QObject *parent) : _onvif_data(data), QObject(parent)
{
}

QString OnvifCamera::name() const
{
    return _onvif_data.camera_name;
}

QUrl OnvifCamera::url() const
{   
    return _url;
}

bool OnvifCamera::is_authorized() const
{
    return _is_authorized;
}

void OnvifCamera::authorize(const QString &username, const QString &password)
{
    strcpy(_onvif_data.username, qPrintable(username));
    strcpy(_onvif_data.password, qPrintable(password));

    if (!fillRTSP(&_onvif_data))
    {
        _url.setUrl(_onvif_data.stream_uri);
        _url.setUserName(username);
        _url.setPassword(password);
        emit urlChanged(_url);

        _is_authorized = true;
        emit isAuthorizedChanged(_is_authorized);
    }
}
