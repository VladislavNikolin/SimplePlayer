// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

// local imports
import OnvifProxy


ApplicationWindow {
    id: root
    title: "Simple Player"
    visible: true
    width: 800
    height: 480

    OnvifCameraModel {
        id: cameras
        Component.onCompleted: scan()
    }

    Dialog {
        property var chosenCamera;

        id: addDialog
        title: "Выберите камеру: "
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        height: 400
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted: {
            addDialog.chosenCamera = cameras.get(camerasView.currentIndex)
            authDialog.open()
        }

        ListView {
            id: camerasView
            anchors.margins: 10
            anchors.fill: parent
            spacing: 10
            clip: true
            model: cameras

            // highlight: Rectangle {
            //     width: parent.width
            //     color: "lightgray"
            // }

            delegate: Item {
                visible: !modelData.is_authorized
                width: parent.width
                height: 20

                Text {
                    anchors.fill: parent
                    text: modelData.name
                }

                // MouseArea {
                //     anchors.fill: parent
                //     onClicked: list.currentIndex = index
                // }
            }
        }
    }

    Dialog {
        property var username;
        property var password;

        id: authDialog
        title: "Авторизация"
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        height: 150
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 2

            TextField {
                id: usernameField
                placeholderText: "Введите имя пользователя"
            }

            TextField {
                id: passwordField
                placeholderText: "Введите пароль"
            }
        }

        onAccepted: {
            username = usernameField.text
            password = passwordField.text
            addDialog.chosenCamera.authorize(username, password)
        }
    }

    GridView {
        // property int columns: Math.ceil(Math.sqrt(parent.cameras))
        property int columns: 1

        model: cameras
        anchors.fill: parent
        interactive: false

        cellWidth: width / columns
        onWidthChanged: {
            cellWidth = width / columns
        }

        cellHeight: height / columns
        onHeightChanged: {
            cellHeight = height / columns
        }

        header: Component {
            Button {
                text: "Добавить камеру"
                onClicked: {
                    addDialog.open()
                }
            }
        }

        delegate: Item {
            visible: modelData.is_authorized
            anchors.fill: parent

            MediaPlayer {
                videoOutput: videoOutput
                source: modelData.url
                Component.onCompleted: play()
                
                onSourceChanged: function(source) {
                    stop()
                    play()
                }

                onErrorOccurred: function(error, errorString) {
                    console.log(errorString)
                }
            }

            VideoOutput {
                id: videoOutput
                anchors.fill: parent
            }
        }
    }
}
