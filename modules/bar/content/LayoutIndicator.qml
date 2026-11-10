import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Rectangle {
    id: root

    property var names: []
    property int current: 0

    readonly property var codes: ({
        "Russian": "RU"
    })

    function shortCode(n) {
        if (!n) return "--"
        const lang = n.split(" (")[0]
        if (codes[lang]) return codes[lang]
        if (lang === "English") {
            const m = n.match(/\(([A-Za-z]{2})\b/)
            return m ? m[1].toUpperCase() : "US"
        }
        return lang.substring(0, 2).toUpperCase()
    }

    readonly property string code: shortCode(current < names.length ? names[current] : "")

    implicitWidth: label.implicitWidth + 12
    implicitHeight: 18
    radius: 5
    color: "transparent"
    border { width: 1.5; color: Theme.text }

    Text {
        id: label
        text: root.code
        color: Theme.text
        anchors.centerIn: parent
        font { pixelSize: 11; family: Theme.fontFamily; weight: 700; }
    }

    Process {
        id: query
        command: ["niri", "msg", "--json", "keyboard-layouts"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(text)
                    root.names = data.names
                    root.current = data.current_idx
                } catch (e) {
                    console.warn("LayoutIndicator: failed to parse niri output", e)
                }
            }
        }
    }

    Process {
        id: events
        running: true
        command: ["niri", "msg", "--json", "event-stream"]
        stdout: SplitParser {
            onRead: line => {
                if (line.indexOf("KeyboardLayout") !== 1) debounce.restart()
            }
        }
    }

    Timer {
        id: debounce
        interval: 30
        onTriggered: query.running = true
    }

    Component.onCompleted: query.running = true

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["niri", "msg", "action", "switch-layout", "next"])
    }
}
