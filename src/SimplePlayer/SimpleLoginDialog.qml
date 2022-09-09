// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


Dialog {
    property var loginFunc
    property var rejectFunc

    property alias login: loginField.text
    property alias password: passwordField.text

    title: 'Авторизация'
    modal: true
    focus: true

    onRejected: rejectFunc

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Label {
            text: 'Имя пользователя: '
        }

        TextField {
            id: loginField
            text: 'viewer'
        }

        Label {
            text: 'Пароль: '
        }

        TextField {
            id: passwordField
            echoMode: TextInput.Password
            text: 'viewernstu1'
        }

        DialogButtonBox {
            Button {
                text: 'Подключиться!'
                onClicked: {
                    if (loginFunc(login, password)) {
                        done(Dialog.Accepted)
                    }
                }
            }

            Button {
                text: 'Отмена'
                DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
                onClicked: done(Dialog.Rejected)
            }
        }
    }
}
