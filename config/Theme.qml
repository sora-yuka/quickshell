pragma Singleton
import QtQuick
import Quickshell


Singleton {
    id: root

    // colors
    readonly property color bg: "#080808"
    readonly property color text: "#f5f5f5"
    readonly property color textDim: "#a4a4a4"
    readonly property color cardColor: "#6d191919"
    readonly property color searchBorderColor: "#33ffffff"
    readonly property color highlight: "#33ffffff"
    readonly property color badge: "#33ffffff"
    readonly property color selection: "#66ffffff"

    // Font parameters
    readonly property string fontFamily: "Inter"
    readonly property int fontSize: 14
    readonly property int searchFontSize: 15
    readonly property int resultFontSize: 15
    readonly property int badgeFontSize: 13

    // Bar
    readonly property int barHeight: 36
    readonly property int barRadius: 16

    // workspace indicator
    readonly property color dotBorder: "#2b2b2b"
    readonly property color dotInner: "#bfbfbf"
    readonly property int wsSize: 12
    readonly property int wsSpacing: 6

    // launcher geometry
    readonly property int searchWidth: 600
    readonly property int searchRadius: 8
    readonly property int cardPadding: 4
    readonly property int topMargin: 200
    readonly property int rowHeight: 48
    readonly property int rowRadius: 6
    readonly property int rowPadding: 4
    readonly property int rowSpacing: 14
    readonly property int iconSize: 32
}
