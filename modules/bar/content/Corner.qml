import QtQuick
import QtQuick.Shapes

Item {
    id: root

    required property color color
    required property real radius
    property bool flip: false  // false - left corner, true - right corner

        implicitWidth: radius
        implicitHeight: radius

        Shape {
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer

            transform: Scale {
                origin.x: root.width / 2
                xScale: root.flip ? -1 : 1
            }

            ShapePath {
                fillColor: root.color
                strokeWidth: -1
                startX: 0
                startY: 0
                PathLine { x: root.radius; y: 0}
                PathLine { x: root.radius; y: root.radius }
                PathArc {
                    x: 0
                    y: 0
                    radiusX: root.radius
                    radiusY: root.radius
                    direction: PathArc.Counterclockwise
                }
            }
        }
    }
