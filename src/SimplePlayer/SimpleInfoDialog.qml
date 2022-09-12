// Qt imports
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts


Dialog {
    property var camera

    title: 'Информация'
    modal: true
    focus: true
    standardButtons: Dialog.Ok | Dialog.Cancel

    ColumnLayout {
        anchors.fill: parent
        spacing: 2

        Label {
            text: 'Яркость: '
        }

        Slider {
            id: brightnessSlider
            from: 0
            stepSize: 5
            snapMode: Slider.SnapAlways
            value: camera.brightness
            to: 100
            ToolTip {
            parent: brightnessSlider.handler
            visible: brightnessSlider.pressed
            text: brightnessSlider.value.toFixed(0)
            }
        }
       

        Label {
            text: 'Насыщенность: '
        }

        Slider {
            id: saturationSlider
            from: 0
            stepSize: 5
            snapMode: Slider.SnapAlways
            value: camera.saturation
            to: 100
            ToolTip {
            parent: saturationSlider.handler
            visible: saturationSlider.pressed
            text: saturationSlider.value.toFixed(0)
            }

        }
        
        Label {
            text: 'Контраст: '
        }

        Slider {
            id: contrastSlider
            from: 0
            stepSize: 5
            snapMode: Slider.SnapAlways
            value: camera.contrast
            to: 100
             ToolTip {
            parent: contrastSlider.handler
            visible: contrastSlider.pressed
            text: contrastSlider.value.toFixed(0)
            }
        }

        Label {
            text: 'Четкость: '
        }

        Slider {
            id: sharpnessSlider
            from: 0
            stepSize: 5
            snapMode: Slider.SnapAlways
            value: camera.sharpness
            to: 100
             ToolTip {
            parent: sharpnessSlider.handler
            visible: sharpnessSlider.pressed
            text: sharpnessSlider.value.toFixed(0)
            }
        }
    }

    onAccepted: {
        camera.brightness = brightnessSlider.value
        camera.saturation = saturationSlider.value
        camera.contrast = contrastSlider.value
        camera.sharpness = sharpnessSlider.value
        camera.pushImagingSettings()
    }
}
