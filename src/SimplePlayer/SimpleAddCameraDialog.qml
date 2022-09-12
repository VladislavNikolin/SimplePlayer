// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

Dialog {
    property var cameras

    signal addCamera(var camera, var button)
    signal removeCamera(var camera)

    title: 'Список камер'
    modal: true
    focus: true
    width: parent.width / 4
    height: 3 * parent.height / 4
    standardButtons: Dialog.Ok | Dialog.Cancel

    ListView {
        id: addCameraList

        width: parent.width
        interactive: false
        anchors.fill: parent
        spacing: 2
        model: cameras

        ScrollBar.vertical: ScrollBar {
            active: true
        }

        delegate: Button {
            property var camera: modelData

            width: addCameraList.width
            checkable: true

            contentItem: ColumnLayout {
                Label {
                    text: camera.name
                }

                Label {
                    text: camera.host
                    font.pixelSize: 10
                }
            }

            onToggled: {
                if (checked) {
                    addCamera(camera, this)
                }
                else {
                    removeCamera(camera)
                }
            }
        }
    }
}
