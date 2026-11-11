pragma Singleton
import QtQuick
import Quickshell


Singleton {
    id: root

    // colors
    readonly property color bg: "#080808"
    readonly property color text: "#f5f5f5"
    readonly property color textDim: "#a4a4a4"

    // font
    readonly property string fontFamily: "Inter"
    readonly property int fontSize: 14

    // bar shape
    readonly property int barHeight: 36
    readonly property int barRadius: 16

    // workspace indicator
    readonly property color wsBorder: "#BAC2DE"
    readonly property color wsEmpty: "#2b2b2b"
    readonly property int wsSize: 12
    readonly property int wsSpacing: 6
}
