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
                // Top Left Rectangle with the loads of Standard Controls - mostly taken from https://doc.qt.io/qt-5/qtquick-controls2-qmlmodule.html
                Rectangle {
                    id: topleftview
                    color: "#2e2e2e"
                    implicitHeight: 250
                    SplitView.minimumHeight: 200
                    SplitView.maximumHeight: 450
                    Flow {
                        id: flow
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        Button {
                            text: "test"

                            checkable: true
                            Material.accent: Material.Orange
                        }
                        Button {
                            text: "test"
                            checkable: true
                        }
                        Button {
                            text: "test"
                            checkable: true
                            Material.accent: Material.Orange
                        }
                        Column {
                            RadioButton { text: qsTr("Small") }
                            RadioButton { text: qsTr("Medium");  checked: true }
                            RadioButton { text: qsTr("Large") }
                            RadioButton { text: qsTr("ExtraLarge") }
                        }
                        Column {
                            RoundButton {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Round Button"
                                onClicked: popup.open()

                                Popup {
                                    id: popup

                                    parent: Overlay.overlay

                                    x: Math.round((parent.width - width) / 2)
                                    y: Math.round((parent.height - height) / 2)
                                    width: 100
                                    height: 100
                                }                                
                            }
                            DelayButton {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Add " + numberOfRowsToAdd.value.toFixed(0) + " Rows" 
                                delay: 1000
                                onClicked: tableView.model.addRows(numberOfRowsToAdd.value)
                            }
                            Button {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Empty DataFrame"
                                onClicked: tableView.model.emptyDataFrame()
                            }
                            Dial {
                                anchors.horizontalCenter: parent.horizontalCenter
                                id: numberOfRowsToAdd
                                height: 80
                                stepSize: 1
                                snapMode: Dial.SnapOnRelease
                                from: 0
                                to: 100
                                rotation: 150
                            }
                            Text {
                                text: numberOfRowsToAdd.value
                                anchors.horizontalCenter: parent.horizontalCenter
                                color: "white"
                            }
                        }
                        Column {
                            BusyIndicator {
                                running: true
                                Material.accent: Material.Orange
                            }
                            BusyIndicator {
                                running: true
                            }
                            BusyIndicator {
                                running: true
                                Material.accent: Material.Orange
                            }
                        }
                        Column {
                            CheckBox {
                                checked: true
                                text: qsTr("First")
                            }
                            CheckBox {
                                text: qsTr("Second")
                            }
                            CheckBox {
                                checked: true
                                text: qsTr("Third")
                            }                        
                        }
                        Column {
                            anchors.margins: 8
                            spacing: 4                            
                            ProgressBar {
                                indeterminate: true
                            }
                            ProgressBar {
                                indeterminate: true
                            }
                            ProgressBar {
                                indeterminate: true
                            }
                            RangeSlider {
                                from: 1
                                to: 100
                                first.value: 25
                                second.value: 75
                                Material.accent: Material.Orange
                            }
                            SpinBox {
                                value: 50
                            }                
                        }
                        Column {
                            Switch {
                                text: qsTr("Wi-Fi")
                                Material.accent: Material.Orange
                            }
                            Switch {
                                text: qsTr("Bluetooth")
                            }
                            Switch {
                                text: qsTr("Wi-Fi")
                                Material.accent: Material.Orange
                            }
                            Switch {
                                text: qsTr("Bluetooth")
                            }
                        }
                        Frame {
                            id: frame
                            Row {
                                id: row

                                Tumbler {
                                    id: hoursTumbler
                                    model: 12
                                    Material.accent: Material.Orange
                                }

                                Tumbler {
                                    id: minutesTumbler
                                    model: 60
                                }

                                Tumbler {
                                    id: amPmTumbler
                                    model: ["AM", "PM"]
                                }
                            }
                        }
                    }
                }
                // Lower Left Rectangle with  fireworks
                Rectangle {
                    color: "#2e2e2e"
                    id: root
                    SplitView.fillHeight: true
                    
                    // defined in Fireworks.qml
                    Fireworks {
                        color: "#2e2e2e"
                        anchors.fill: parent
                        emittedRockets: 4
                    }
                }
            }
        }
        // Right DataFrame Table View with x Items
        Rectangle {
            color: "#2e2e2e"
            id: rightitem
            SplitView.minimumWidth: 200
            SplitView.fillWidth: true

            TableView {
                id: tableView

                columnWidthProvider: function (column) { return 100; }
                rowHeightProvider: function (column) { return 20; }
                anchors.fill: parent
                // set here and define the model in backend with engine.rootContext().setContextProperty("table_model", model)
                model: table_model
                delegate: Rectangle {
                    color: "#2e2e2e"
                    Text {
                        text: display
                        anchors.fill: parent
                        anchors.margins: 10
                        color: 'white'
                        font.pixelSize: 15
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                ScrollIndicator.horizontal: ScrollIndicator { }
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }
}