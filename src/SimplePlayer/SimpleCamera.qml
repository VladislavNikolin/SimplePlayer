// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material


Rectangle
{
    property var camera

    signal infoClicked
    signal settingsClicked

    Rectangle {
        anchors.fill: parent
        color: 'black'

        MediaPlayer {
            id: mediaPlayer
            videoOutput: videoOutput
            source: camera.uri
            Component.onCompleted: play()
            onSourceChanged: (source) => {
                stop()
                play()
            }
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
        }
    }

    ToolBar {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        hoverEnabled: true
        opacity: hovered ? 1.0: 0.2
        background: Rectangle {
            color: 'black'
        }

        RowLayout {
            anchors.fill: parent

            Label {
                Layout.fillWidth: true
                font.bold: true
                color: 'white'
                text: camera.name
            }

            ToolButton {
                id: infoButton
                hoverEnabled: false
                text: 'ⓘ'
                onClicked: infoClicked()
            }

            ToolButton {
                id: settingsButton
                hoverEnabled: false
                text: '⚙'
                onClicked: settingsClicked()
            }

            // ToolButton {
            //     id: closeButton
            //     text: '✖'
            //     // onClicked:
            // }
        }
    }

    // Label {
    //     anchors.fill: parent
    //     visible: !camera.isAuthorized
    //     verticalAlignment: Text.AlignVCenter
    //     horizontalAlignment: Text.AlignHCenter
    //     font.bold: true
    //     font.capitalization: Font.AllUppercase
    //     color: 'white'
    //     text: 'Кликните чтобы подключиться'
    //     background: Rectangle {
    //         color: 'blue'
    //     }

    //     MouseArea {
    //         anchors.fill: parent
    //         onClicked: authDialog.open()
    //     }
    // }


 
}
