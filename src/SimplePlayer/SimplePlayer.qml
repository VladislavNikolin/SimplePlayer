// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

// local imports
import OnvifProxy


ApplicationWindow {
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

    Dialog {
        id: addCameraDialog
        title: 'Список камер'
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        width: parent.width / 4
        height: 3 * parent.height / 4
        standardButtons: Dialog.Ok | Dialog.Cancel

        ListView {
            width: parent.width
            id: addCameraList
            model: cameras
            interactive: false
            anchors.fill: parent
            spacing: 2

            ScrollBar.vertical: ScrollBar {
                active: true
            }
    
            delegate: Button {
                property var camera: modelData

                id: button
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
                        loginDialog.loginFunc = (u, p) => {
                            if (camera.login(u, p)) {
                                authorized_cameras.filter()
                                return true;
                            }
                            else
                                return false;
                        }
                        loginDialog.open()
                    }
                    else {
                        camera.logoff()
                        authorized_cameras.filter()
                    }
                }

                SimpleLoginDialog {
                    id: loginDialog
                    x: (parent.width - width) / 2
                    y: (parent.height - height) / 2

                    onAccepted: {
                        button.checked = true
                    }

                    onRejected: {
                        button.checked = false
                    }
                }
            }
        }
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
        }
    }
}
