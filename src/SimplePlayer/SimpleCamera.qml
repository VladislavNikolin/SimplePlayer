// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia

Rectangle
{
    property var camera

    ColumnLayout
    {
        anchors.fill: parent

        ToolBar {
            Layout.fillWidth: true

            RowLayout {
                anchors.fill: parent

                Text {
                    Layout.fillWidth: true
                    text: camera.name
                }

                ToolButton {
                    text: "⚙"
                }

                ToolButton {
                    text: "✖"
                }
            }
        }

        Label {
            text: !camera.is_authorized ? "Кликните чтобы подключиться" : ""
            color: !camera.is_authorized ? "white" : "transparent"
            font.bold: true
            font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            Layout.fillHeight: true

            background: Rectangle {
                anchors.fill: parent
                color: !camera.is_authorized ? "blue" : "transparent"

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

                MouseArea {
                    anchors.fill: parent
                    onClicked: authDialog.open()
                }
            }

            Dialog {
                id: authDialog
                title: "Авторизация"
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                modal: true
                focus: true
                height: 130
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
                    var username = usernameField.text
                    var password = passwordField.text
                    camera.authorize(username, password)
                }
            }
        }
    }
}
