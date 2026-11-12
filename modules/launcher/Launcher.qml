import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.config
import qs.modules.launcher.content

Scope{
    id: launcher

    signal closeRequested()

    function runAndClose(item) {
        Search.run(item, searchRow.text)
    }

    PanelWindow {
        anchors { top: true; bottom: true; left: true; right: true; }
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "launcher-backdrop"
        WlrLayershell.layer: WlrLayer.Top

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
            onClicked: launcher.closeRequested()
        }
    }

    PanelWindow {
        anchors.top: true
        margins.top: Theme.topMargin
        implicitWidth: Theme.searchWidth
        implicitHeight: card.height

        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.namespace: "launcher"
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        BackgroundEffect.blurRegion: Region { item: card; radius: Theme.searchRadius; }

        Rectangle {
            id: card
            anchors { top: parent.top; left: parent.left; right: parent.right; }
            height: col.implicitHeight + Theme.cardPadding * 2
            radius: Theme.searchRadius
            color: Theme.cardColor
            border { color: Theme.searchBorderColor; width: 1; }

            Behavior on height {
                NumberAnimation { duration: 140; easing.type: Easing.OutCubic; }
            }

            ColumnLayout {
                id: col
                anchors {
                    top: parent.top;
                    left: parent.left;
                    right: parent.right;
                    margins: Theme.cardPadding;
                }
                spacing: 8

                SearchRow {
                    id: searchRow
                    Layout.fillWidth: true

                    onTextChanged: list.currentIndex = 0
                    onDown: list.incrementCurrentIndex()
                    onUp: list.decrementCurrentIndex()
                    onCancelled: launcher.closeRequested()
                    onAccepted: launcher.runAndClose(list.model[list.currentIndex])
                }

                ListView {
                    id: list
                    Layout.fillWidth: true
                    Layout.preferredHeight: contentHeight
                    visible: count > 0
                    interactive: false
                    spacing: 4
                    model: Search.build(searchRow.text)

                    highlightMoveDuration: 80
                    highlight: Rectangle { radius: Theme.rowRadius; color: Theme.highlight; }

                    delegate: ResultRow{
                        onClicked: launcher.runAndClose(modelData)
                    }
                }
            }
        }
    }
}
