import QtQuick 6
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15

// Main Window
ApplicationWindow{
    id: window
    // define width and height
    width: 1600
    height: 900
    visible:true

    // Title
    title: qsTr("Main View")
    
    // Set Window Flags
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    
    // Set Dark Material Theme as main theme and set the accent to light blue
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue   

    // Create a horizontal SplitView
    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        // Left Rectangle with Vertical Splitview
        Rectangle {
            implicitWidth: 1150
            SplitView.maximumWidth: 1400
            SplitView.minimumWidth: 200
            SplitView {
                anchors.fill: parent
                orientation: Qt.Vertical
                // Top Left Rectangle 
                Rectangle {
                    id: topleftview
                    color: "#2e2e2e"
                    implicitHeight: 250
                    SplitView.minimumHeight: 200
                    SplitView.maximumHeight: 450

                }
                // Lower Left Rectangle
                Rectangle {
                    color: "#2e2e2e"
                    id: root
                    SplitView.fillHeight: true
                }
            }
        }

        // Right DataFrame Table View with x Items
        Rectangle {
            color: "#2e2e2e"
            id: rightitem
            SplitView.minimumWidth: 200
            SplitView.fillWidth: true

            // add Accordion from Accordion.qml
            Accordion {
                id: accordion
                anchors.fill: parent
            }
        }
    }
}