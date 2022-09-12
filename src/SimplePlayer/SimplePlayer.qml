// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// local imports
import OnvifProxy


ApplicationWindow {
    id: root
    title: 'Simple Player'
    visible: true
    minimumWidth: 1200
    minimumHeight: 720

        menuBar: MenuBar {
        Menu {
            title: 'Camera'

            MenuItem { 
                action: Action {
                    text: "Status"
                    onTriggered: addCameraDialog.open()
                }
            }

            MenuItem { 
                action: Action {
                    text: "Update"
                    onTriggered: cameras.scan()
                }
            }
        }
    }

    OnvifCameraModel {
        id: cameras
    }

    OnvifAuthorizedCameraFilterModel {
        id: authorized_cameras
        sourceModel: cameras
    }

    GridView {
        property int columns: 3

        id: gridView
        model: authorized_cameras
        anchors.fill: parent
        clip: true
        interactive: false

        cellWidth: width / columns
        onWidthChanged: {
            cellWidth = width / columns
        }

        cellHeight: height / columns
        onHeightChanged: {
            cellHeight = height / columns
        }

        delegate: SimpleCamera {
            width: gridView.cellWidth - 2
            height: gridView.cellHeight - 2
            camera: modelData

            onInfoClicked: {
                var component = Qt.createComponent("SimpleInfoDialog.qml")
                var dialog = component.createObject(root, { 
                    camera: modelData,
                    x: (root.width - width) / 2,
                    y: (root.height - height) / 2
                });
                dialog.open()
            }

            onSettingsClicked: {
                var component = Qt.createComponent("SimpleSettingsDialog.qml")
                var dialog = component.createObject(root, {
                    camera: modelData,
                    x: (root.width - width) / 2,
                    y: (root.height - height) / 2
                });
                dialog.open()
            }
        }
    }

    SimpleAddCameraDialog {
        id: addCameraDialog
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        cameras: cameras

        onAddCamera: function(camera, button) {
            var component = Qt.createComponent("SimpleLoginDialog.qml")
            var dialog = component.createObject(root, {
                x: (root.width - width) / 2,
                y: (root.height - height) / 2,
                username: 'viewer',
                password: 'viewernstu1',
            })
            dialog.accepted.connect(function() {
                if (camera.login(dialog.username, dialog.password))
                    authorized_cameras.filter()
                else
                    button.checked = false
            })
            dialog.rejected.connect(function() {
                button.checked = false
            })
            dialog.open()
        }

        onRemoveCamera: function(camera) {
            camera.logoff()
            authorized_cameras.filter()
        }
    }

    SimpleLoginDialog {
        id: loginDialog
        x: (root.width - width) / 2
        y: (root.height - height) / 2
    }
}
