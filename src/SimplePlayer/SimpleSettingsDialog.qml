// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    property var camera

    title: 'Настройки'
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
            validator: RegularExpressionValidator {
                regularExpression: /^((?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])\.){0,3}(?:[0-1]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$/
            }
        }

        Label {
            text: 'Маска: '
        }

        SpinBox {
            id: ipPrefixField
            enabled: !isDHCPBox.checked
            value: camera.ipPrefix
            from: 1
            to: 31
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
        camera.ipPrefix = ipPrefixField.value
        camera.pushNetworkSettings()
    }
}
