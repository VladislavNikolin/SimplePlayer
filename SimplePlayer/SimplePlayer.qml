//import related modules
import QtQuick
import QtQuick.Controls
import QtMultimedia


//window containing the application
ApplicationWindow {

    visible: true

    //title of the application
    title: qsTr("Simple Player")
    width: 640
    height: 480

    MediaPlayer {
        id: player
        source: "rtsp://admin:admin@192.168.0.101:554/profile1"
        Component.onCompleted: play()
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }
}