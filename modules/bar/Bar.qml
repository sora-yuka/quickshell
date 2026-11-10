import QtQuick
import Quickshell
import qs.config
import qs.modules.bar.content

PanelWindow {
    id: bar

    anchors {
        top: true;
        left: true;
        right: true;
    }

    implicitHeight: Theme.barHeight
    color: "transparent"

    Item {
        id: container
        anchors.fill: parent

        Rectangle {
            id: pill
            anchors {
                horizontalCenter: parent.horizontalCenter;
                top: parent.top;
                topMargin: -Theme.barRadius;
            }
            color: Theme.bg
            radius: Theme.barRadius
            width: clock.implicitWidth + 60
            height: Theme.barHeight + Theme.barRadius

            Clock {
                id: clock
                anchors {
                    centerIn: parent;
                    verticalCenterOffset: Theme.barRadius / 2;
                }
            }
        }

        Corner {
            color: Theme.bg
            radius: Theme.barRadius
            anchors { right: pill.left; top: parent.top; }
        }

        Corner {
            flip: true
            color: Theme.bg
            radius: Theme.barRadius
            anchors { left: pill.right; top: parent.top; }
        }
    }
}
