// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia


Rectangle
{
    property var camera

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
                hoverEnabled: false
                text: 'ⓘ'
                onClicked: infoDialog.open()
            }

            ToolButton {
                hoverEnabled: false
                text: '⚙'
                onClicked: settingsDialog.open()
            }

            // ToolButton {
            //     id: closeButton
            //     text: '✖'
            //     // onClicked:
            // }
        }
    }

    Label {
        anchors.fill: parent
        visible: !camera.isAuthorized
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.bold: true
        font.capitalization: Font.AllUppercase
        color: 'white'
        text: 'Кликните чтобы подключиться'
        background: Rectangle {
            color: 'blue'
        }

        MouseArea {
            anchors.fill: parent
            onClicked: authDialog.open()
        }
    }

    Dialog {
        id: authDialog
        title: 'Авторизация'
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            anchors.fill: parent
            spacing: 2

            Label {
                text: 'Имя пользователя: '
            }

            TextField {
                id: usernameField
                text: 'admin'
            }

            Label {
                text: 'Пароль: '
            }

            TextField {
                id: passwordField
                echoMode: TextInput.Password
                text: 'admin'
            }
        }

        onAccepted: {
            var username = usernameField.text
            var password = passwordField.text
            if (!camera.authorize(username, password))
                console.log('bad login / password')
        }
    }

    Dialog {
        id: infoDialog
        title: 'Информация'
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        standardButtons: Dialog.Ok

        ColumnLayout {
            anchors.fill: parent
            spacing: 2

            Label {
                text: 'Яркость: '
            }

            TextField {
                readOnly: true
                text: camera.brightness
            }

            Label {
                text: 'Насыщенность: '
            }

            TextField {
                readOnly: true
                text: camera.saturation
            }

            Label {
                text: 'Контраст: '
            }

            TextField {
                readOnly: true
                text: camera.contrast
            }

            Label {
                text: 'Четкость: '
            }

            TextField {
                readOnly: true
                text: camera.sharpness
            }
        }
    }

    Dialog {
        id: settingsDialog
        title: 'Настройки'
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            anchors.fill: parent
            spacing: 2

            CheckBox {
                checked: camera.isDHCP
                text: 'DHCP'
                onCheckedChanged: { 
                    camera.isDHCP = checked
                }
            }

            Label {
                text: 'IP адрес: '
            }

            TextField {
                enabled: !camera.isDHCP
                text: camera.ipAddress
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegularExpressionValidator {
                    regularExpression: /^((?: [0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0, 3}(?: [0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                }
                onEditingFinished: { 
                    camera.ipAddress = text
                }
            }

            Label {
                text: 'Маска: '
            }

            TextField {
                enabled: !camera.isDHCP
                text: camera.ipPrefix
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: IntValidator {
                    bottom: 1
                    top: 31
                }
                onEditingFinished: { 
                    camera.ipPrefix = text
                }
            }

            Button {
                text: 'Перезагрузить камеру'
                onClicked: camera.reboot()
            }

            Button {
                text: 'Сбросить до заводских настроек'
                palette: Palette { button: 'red' }
                onClicked: camera.factoryReset()
            }
        }

        onAccepted: {
            camera.pushNetworkSettings()
        }
    }
}
