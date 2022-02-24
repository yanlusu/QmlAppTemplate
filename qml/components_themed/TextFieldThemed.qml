import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0

T.TextField {
    id: control
    implicitWidth: 256
    implicitHeight: Theme.componentHeight

    padding: 12

    // colors
    property string colorText: Theme.colorComponentText
    property string colorPlaceholderText: Theme.colorSubText
    property string colorBorder: Theme.colorComponentBorder
    property string colorBackground: Theme.colorComponentBackground
    property string colorSelectedText: Theme.colorHighContrast
    property string colorSelection: Theme.colorPrimary

    text: ""
    color: colorText
    font.pixelSize: Theme.fontSizeComponent
    verticalAlignment: Text.AlignVCenter

    placeholderText: ""
    placeholderTextColor: colorPlaceholderText

    selectByMouse: false
    selectedTextColor: colorSelectedText
    selectionColor: colorSelection

    onEditingFinished: focus = false

    background: Rectangle {
        border.width: 2
        border.color: control.activeFocus ? control.colorSelection : control.colorBorder
        radius: Theme.componentRadius
        color: control.colorBackground
    }
}