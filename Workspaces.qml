import QtQuick
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "minimal.dot.workspace"

  function workspaceById(id) {
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id === id) return values[i]
    }

    return null
  }

  function focusWorkspace(id) {
    if (!root.bar) return
    root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"" + id + "\" })"))
  }

  function computeIds() {
    var maxId = 5
    var values = Hyprland.workspaces.values
    for (var i = 0; i < values.length; i++) {
      if (values[i].id > maxId && values[i].id <= 10) maxId = values[i].id
    }
    var ids = []
    for (var i = 1; i <= maxId; i++) ids.push(i)
    return ids
  }

  readonly property var workspaceIds: computeIds()

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight

  Row {
    id: row
    anchors.centerIn: parent
    spacing: Style.space(3)

    Repeater {
      model: root.workspaceIds

      Item {
        required property int modelData

        readonly property var workspace: root.workspaceById(modelData)
        readonly property bool occupied: workspace !== null && workspace.toplevels.values.length > 0
        readonly property bool focused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === modelData

        width: Style.space(14)
        height: Style.space(14)

        Rectangle {
          anchors.centerIn: parent
          width: Style.space(7)
          height: width
          radius: width / 2
          visible: !focused
          color: root.bar ? Qt.rgba(root.bar.barForeground.r, root.bar.barForeground.g, root.bar.barForeground.b, occupied ? 1.0 : 0.25)
                          : Qt.rgba(Color.foreground.r, Color.foreground.g, Color.foreground.b, occupied ? 1.0 : 0.25)

          Behavior on color {
            ColorAnimation { duration: 200 }
          }
        }

        Text {
          anchors.centerIn: parent
          visible: focused
          text: "⦿"
          font.pixelSize: Style.space(14)
          color: root.bar ? root.bar.barForeground : Color.foreground
          renderType: Text.NativeRendering
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: root.focusWorkspace(modelData)
        }
      }
    }
  }
}
