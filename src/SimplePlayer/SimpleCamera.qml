// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Controls.Material


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


    Dialog {
        id: infoDialog
        title: 'Информация'
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            anchors.fill: parent
            spacing: 2

            Label {
                text: 'Яркость: '
            }

            TextField {
                id: brightnessField
                text: camera.brightness
            }

            Label {
                text: 'Насыщенность: '
            }

            TextField {
                id: saturationField
                text: camera.saturation
            }

            Label {
                text: 'Контраст: '
            }

            TextField {
                id: contrastField
                text: camera.contrast
            }

            Label {
                text: 'Четкость: '
            }

            TextField {
                id: sharpnessField
                text: camera.sharpness
            }
        }

        onAccepted: {
            camera.brightness = parseInt(brightnessField.text)
            camera.saturation = parseInt(saturationField.text)
            camera.contrast = parseInt(contrastField.text)
            camera.sharpness = parseInt(sharpnessField.text)
            camera.pushImagingSettings()
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
                id: isDHCPBox
                checked: camera.isDHCP
                text: 'DHCP'
            }

            Label {
                text: 'IP адрес: '
            }

            TextField {
                id: ipAddressField
                enabled: !isDHCPBox.checked
                text: camera.ipAddress
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                // validator: RegularExpressionValidator {
                //     regularExpression: /^((?: [0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0, 3}(?: [0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
                // }
            }

            Label {
                text: 'Маска: '
            }

            TextField {
                id: ipPrefixField
                enabled: !isDHCPBox.checked
                text: camera.ipPrefix
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: IntValidator {
                    bottom: 1
                    top: 31
                }
            }

            Button {
                text: 'Перезагрузить камеру'
                onClicked: camera.reboot()
            }

            Button {
                text: 'Сбросить до заводских настроек'
                //palette: Palette { button: 'red' }
                onClicked: camera.factoryReset()
            }
        }

        onAccepted: {
            camera.isDHCP = isDHCPBox.checked
            camera.ipAddress = ipAddressField.text
            camera.ipPrefix = parseInt(ipPrefixField.text)
            camera.pushNetworkSettings()
        }
    }    
}
