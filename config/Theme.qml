pragma Singleton
import QtQuick
import Quickshell


Singleton {
    id: root

    // colors
    readonly property color bg: "#080808"
    readonly property color text: "#f5f5f5"

    // font
    readonly property string fontFamily: "Inter"
    readonly property int fontSize: 14

    // bar shape
    readonly property int barHeight: 36
    readonly property int barRadius: 16
}
