// qt headers
#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

// local headers
#include "OnvifCamera.hpp"
#include "OnvifCameraModel.hpp"
#include "OnvifAuthorizedCameraFilterModel.hpp"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QUrl url(u"qrc:/SimplePlayer/SimplePlayer.qml"_qs);

    // register local types
    qmlRegisterType<OnvifCamera>(
        "OnvifProxy", 1, 0, "OnvifCamera");
    qmlRegisterType<OnvifCameraModel>(
        "OnvifProxy", 1, 0, "OnvifCameraModel");
    qmlRegisterType<OnvifAuthorizedCameraFilterModel>(
        "OnvifProxy", 1, 0, "OnvifAuthorizedCameraFilterModel");
    engine.load(url);

    return app.exec();
}
