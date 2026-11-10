import QtQuick
import Quickshell
import qs.config

Item {
    id: root

    property string format: "hh:mm"

        implicitWidth: label.implicitWidth
        implicitHeight: label.implicitHeight

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: Qt.formatDateTime(clock.date, root.format)
            color: Theme.text
            font { pixelSize: Theme.fontSize; family: Theme.fontFamily; weight: 500; }
        }
    }
