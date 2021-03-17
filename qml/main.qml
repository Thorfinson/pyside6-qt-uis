import QtQuick 6
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15
import QtQuick.Particles 2.15

ApplicationWindow{
    id: window
    width: 1600
    height: 900
    visible:true
    title: qsTr("Main View")
    property color menuBackgroundColor: "#3C3C3C"
    property color menuBorderColor: "#282828"
    
    // Set Flags
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint | FramelessWindowHint
    
    Material.theme: Material.Dark
    Material.accent: Material.LightBlue   

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        Rectangle {
            implicitWidth: 1150
            SplitView.maximumWidth: 1400
            SplitView.minimumWidth: 200
            SplitView {
                anchors.fill: parent
                orientation: Qt.Vertical
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
                                text: "Delay Button"
                                delay: 3000
                            }
                            Dial {
                               height: 80
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
                Rectangle {
                    color: "#2e2e2e"
                    id: root
                    SplitView.fillHeight: true
                    // main particle system
                    ParticleSystem {id: particlesSystem}

                    // firework emitter
                    Emitter {
                        id: fireWorkEmitter
                        system: particlesSystem
                        enabled: true
                        lifeSpan: 1600
                        maximumEmitted: 30
                        // Specify the logical group that
                        // the emitter belongs to
                        group: "A"
                        // we want to emit particles
                        // from the bottom of the window
                        anchors{
                            left: parent.left
                            right: parent.right
                            bottom: parent.bottom
                        }

                        velocity:  AngleDirection {
                                    angle: 270
                                    angleVariation: 10
                                    magnitude: 200
                                }
                        GroupGoal {
                            // on which group to apply
                            groups: ["A"]
                            // the goalState
                            goalState: "exploding"
                            system: particlesSystem
                            // switch once the particles reach the window center
                            y: - root.height / 2
                            width: parent.width
                            height: 10
                            // make the particles immediately move to the goal state
                            jump: true
                        }
                        ImageParticle {
                            source: "../resources/particle.png"
                            system: particlesSystem
                            color: "red"
                            groups: ["A"]
                        }
                    }
                    TrailEmitter {
                        system: particlesSystem
                        group: "B"
                        // follow particle emitted by fireWorkEmitter
                        follow: "A"
                        size: 12
                        emitRatePerParticle: 30
                        velocity: PointDirection {yVariation: 10; xVariation: 10}
                        acceleration: PointDirection {y:  10}
                        ImageParticle {
                            source: "../resources/particle.png"
                            system: particlesSystem
                            groups: ["B"]
                            color: "white"
                        }
                    }
                    ParticleGroup {
                        name: "exploding"
                        duration: 3000
                        system: particlesSystem

                        TrailEmitter {
                            group: "C"
                            enabled: true
                            anchors.fill: parent
                            lifeSpan: 1000
                            emitRatePerParticle: 1000
                            size: 14
                            velocity: AngleDirection {angleVariation: 360; magnitude: 100}
                            acceleration: PointDirection {y:  20}
                            ImageParticle {
                                source: "../resources/particle.png"
                                system: particlesSystem
                                groups: ["C"]
                                color: "red"
                                colorVariation: 1.2
                            }                            
                        }
                    }
                    ShaderEffect {
                        id: shaderEffect
                        anchors {
                            left: parent.left
                            top: parent.top
                        }
                        property variant source: background
                        property real frequency: 20
                        property real amplitude: 0.05
                        property real time
                        
                        NumberAnimation on time {
                            from: 0; to: Math.PI*2
                            duration: 1000
                            loops: Animation.Infinite
                        }
                        fragmentShader: "../resources/effect.cso"
                    }
                }
            }
        }
        Rectangle {
            color: "#2e2e2e"
            id: rightitem
            SplitView.minimumWidth: 200
            SplitView.fillWidth: true
        }
    }
}