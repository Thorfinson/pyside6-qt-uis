import QtQuick 6
import QtQuick.Controls 6

Item {
    width: 300
    height: 480

    // Filter Text Field - sets the filter string on TextChanged
    TextField {
        id: filterText
        selectByMouse: true
        placeholderText: "Your filter here"
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter

        onTextChanged: accordion_list.setFilterFixedString(text)
    }
    
    // The List View with the model accordion_list, set in main.py
    ListView {
        id: listView

        anchors.topMargin: 40
        anchors.fill: parent

        delegate: detailsDelegate
        model: accordion_list
    }

    // The Delegate Component - defines how the model is rendered, the interaction, the states and the transition
    Component {
        id: detailsDelegate

        Item {
            id: wrapper

            width: listView.width
            height: 30

            // Rectangle for title
            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                height: 30
                color: "#2e2e2e"
                border.color: Qt.lighter(color, 1.2)
                Text {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 4

                    font.pixelSize: parent.height-12
                    color: '#fff'

                    text: model.user_name
                }
            }

            // Rectangle for image - has then 2 states - small and large
            Rectangle {
                id: image

                width: 26
                height: 26

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 2
                anchors.topMargin: 2

                color: "black"
                
                Image {
                    anchors.fill: parent

                    fillMode: Image.PreserveAspectFit

                    source: model.user_image
                }
            }

            // Mouse area to click and expand
            MouseArea {
                anchors.fill: parent
                onClicked: parent.state = "expanded"
            }

            // Item for the lorem text - hidden at first
            Item {
                id: factsView

                anchors.top: image.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                opacity: 0

                Rectangle {
                    anchors.fill: parent
                    border.color: '#000000'
                    border.width: 2

                    Text {
                        anchors.fill: parent
                        anchors.margins: 5

                        clip: true
                        wrapMode: Text.WordWrap
                        color: '#1f1f21'

                        font.pixelSize: 12

                        text: model.user_text
                    }
                }
            }

            // Close Button on the small spot the image was
            Rectangle {
                id: closeButton

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 2
                anchors.topMargin: 2

                width: 26
                height: 26

                color: "#157efb"
                border.color: Qt.lighter(color, 1.1)

                opacity: 0

                // Mouse area to shrink again
                MouseArea {
                    anchors.fill: parent
                    onClicked: wrapper.state = ""
                }
            }

            // State Defintions and which Properties have which values
            states: [
                State {
                    name: "expanded"

                    PropertyChanges { target: wrapper; height: listView.height }
                    PropertyChanges { target: image; width: listView.width; height: listView.width; anchors.rightMargin: 0; anchors.topMargin: 30 }
                    PropertyChanges { target: factsView; opacity: 1 }
                    PropertyChanges { target: closeButton; opacity: 1 }
                }
            ]

            // State transitions
            transitions: [
                Transition {
                    NumberAnimation {
                        duration: 500;
                        properties: "height,width,anchors.rightMargin,anchors.topMargin,opacity"
                    }
                }
            ]
        }
    }
}