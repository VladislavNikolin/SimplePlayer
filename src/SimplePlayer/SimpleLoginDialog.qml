// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


Dialog {
    property alias username: usernameField.text
    property alias password: passwordField.text

    title: 'Авторизация'
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
        }

        Label {
            text: 'Пароль: '
        }

        TextField {
            id: passwordField
            echoMode: TextInput.Password
        }
    }
}
