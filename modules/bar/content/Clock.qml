import QtQuick
import Quickshell
import qs.config

Item {
    id: root

    property string timeFormat: "hh:mm"
    property string dateFormat: "ddd d"

    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 10

        Text {
            color: Theme.text
            text: Qt.formatDateTime(clock.date, root.timeFormat)
            font { pixelSize: Theme.fontSize; family: Theme.fontFamily; weight: 600; }
        }

        Text {
            color: Theme.textDim
            text: Qt.formatDateTime(clock.date, root.dateFormat)
            font { pixelSize: Theme.fontSize; family: Theme.fontFamily; weight: 500; }
        }
    }

}
