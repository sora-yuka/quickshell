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
    readonly property color wsActive: "#f5f5f5"
    readonly property color wsOccupied: "#8a8a8a"
    readonly property color wsEmpty: "#3a3a3a"
    readonly property int wsSize: 8
    readonly property int wsSpacing: 6
}
