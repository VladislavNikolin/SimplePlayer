// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// local imports
import OnvifProxy


ApplicationWindow {
    title: "Simple Player"
    visible: true
    minimumWidth: 800
    minimumHeight: 480

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
            camera: modelData
            width: gridView.cellWidth - 2
            height: gridView.cellHeight - 2
        }
    }

    OnvifCameraModel {
        id: cameras
        Component.onCompleted: scan()
    }
}
