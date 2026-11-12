import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config

Item {
    id: row

    required property var modelData
    signal clicked()

    width: ListView.view ? ListView.view.width : 0
    height: Theme.rowHeight

    RowLayout {
        anchors {
            fill: parent;
            leftMargin: Theme.rowPadding;
            rightMargin: Theme.rowPadding;
        }
        spacing: Theme.rowSpacing

        Item {
            id: iconBox
            Layout.preferredWidth: Theme.iconSize
            Layout.preferredHeight: Theme.iconSize

            property string src: row.modelData.kind === "app" && row.modelData.icon
                ? Quickshell.iconPath(row.modelData.icon, true) : ""

            Image {
                anchors.fill: parent
                visible: iconBox.src !== ""
                source: iconBox.src
                sourceSize: Qt.size(Theme.iconSize, Theme.iconSize)
            }

            Rectangle {
                anchors.fill: parent
                visible: iconBox.src === ""
                radius: width / 2
                color: Theme.badge

                Text {
                    anchors.centerIn: parent
                    text: row.modelData.kind === "web" ? "W"
                        : row.modelData.kind === "term" ? ">_"
                        : row.modelData.label.charAt(0).toUpperCase()
                    color: "white"
                    font {
                        bold: true;
                        family: Theme.fontFamily;
                        pixelSize: Theme.badgeFontSize;
                    }
                }
            }
        }

        Text {
            text: row.modelData.label
            color: Theme.text
            elide: Text.ElideRight
            font { family: Theme.fontFamily; pixelSize: Theme.resultFontSize; }
            Layout.fillWidth: true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: row.clicked()
    }
}
