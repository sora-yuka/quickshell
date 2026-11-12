import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules.bar
import qs.modules.launcher

ShellRoot {
    id: root

    property bool open: false

    IpcHandler{
        target: "launcher"
        function toggle(): void { root.open = !root.open }
    }

    LazyLoader {
        active: root.open

        Launcher {
            onCloseRequested: root.open = false
        }
    }

    Bar {}
}
