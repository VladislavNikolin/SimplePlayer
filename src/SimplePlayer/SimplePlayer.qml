// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// local imports
import OnvifProxy


ApplicationWindow {
    title: 'Simple Player'
    visible: true
    minimumWidth: 800
    minimumHeight: 480

    // menuBar: MenuBar {
    //     Menu {
    //         title: '&File'
    //         Action { text: '&New...' }
    //         Action { text: '&Open...' }
    //         Action { text: '&Save' }
    //         Action { text: 'Save &As...' }
    //         MenuSeparator { }
    //         Action { text: '&Quit' }
    //     }
    //     Menu {
    //         title: '&Edit'
    //         Action { text: 'Cu&t' }
    //         Action { text: '&Copy' }
    //         Action { text: '&Paste' }
    //     }
    //     Menu {
    //         title: '&Help'
    //         Action { text: '&About' }
    //     }
    // }

    GridView {
        property int columns: Math.ceil(Math.sqrt(cameras.count)) || 1

        id: gridView
        model: cameras
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
            // onCameraClose: { this.visible = false }
        }
    }

    OnvifCameraModel {
        id: cameras
        Component.onCompleted: scan()
    }
}
