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

QUrl OnvifCamera::uri() const
{   
    return _uri;
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
        _uri.setUrl(_onvif_data.stream_uri);
        _uri.setUserName(username);
        _uri.setPassword(password);
        emit uriChanged(_uri);

        _is_authorized = true;
        emit isAuthorizedChanged(_is_authorized);
    }
}
