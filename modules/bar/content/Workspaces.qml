import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Row {
    id: root
    spacing: Theme.wsSpacing

    property int minCount: 2
    property var workspaces: []

    // Always 5 dots for workspace indicator.
    // Grows if you go past 5
    readonly property int count: {
        let m = minCount
        for (const w of workspaces)
            if (w.idx > minCount) m = w.idx
        return m
    }

    Process {
        id: query
        command: ["niri", "msg", "--json", "workspaces"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const all = JSON.parse(text)
                    const focused = all.find(w => w.is_focused)
                    const output = focused ? focused.output : (all.length ? all[0].output : "")
                    root.workspaces = all.filter(w => w.output == output)
                } catch (e) {
                    console.warn("Workspaces: failed to parse niri output", e)
                }
            }
        }
    }

    Process {
        id: events
        running: true
        command: ["niri", "msg", "--json", "event-stream"]
        stdout: SplitParser { onRead: debounce.restart() }
    }

    Timer {
        id: debounce
        interval: 50
        onTriggered: query.running = true
    }

    Component.onCompleted: query.running = true

    Repeater {
        model: root.count

        Rectangle {
            id: dot
            required property int index
            readonly property int wsIdx: index + 1
            readonly property var ws: root.workspaces.find(w => w.idx === wsIdx)
            readonly property bool active: ws !== undefined && ws.is_active
            readonly property bool occupied: ws !== undefined
                && ws.active_window_id !== null && ws.active_window_id !== undefined

            implicitHeight: Theme.wsSize
            implicitWidth: active ? Theme.wsSize * 2 : Theme.wsSize
            border { color: Theme.dotBorder; width: 2; }

            radius: height / 2
                color: dot.active ? Theme.dotBorder : Theme.dotInner

            Behavior on color { ColorAnimation { duration: 100; } }
            Behavior on implicitWidth { NumberAnimation { duration: 100; easing.type: Easing.OutCubic } }

            MouseArea {
                anchors { fill: parent; margins: -3; }
                cursorShape: Qt.PointingHandCursor
                onClicked: Quickshell.execDetached(
                    ["niri", "msg", "action", "focus-workspace", String(dot.wsIdx)]
                )
            }
        }
    }
}
