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
    // property color backgroundColor: Material.color(Material.Grey)
    property color backgroundColor: "#d9d9d9"
    property int paddingSize: 70

    // Title
    title: qsTr("Main View")
    
    // Set Window Flags
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.WindowMaximizeButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint
    
    // Set Dark Material Theme as main theme and set the accent to light blue
    Material.theme: Material.Light
    Material.accent: Material.LightGreen

    ListModel {
        id: textListModel

        ListElement { 
            align: Text.AlignLeft
            leftMargin: 0
            rightMargin: 70
            description: " It's a <i>space</i> opera story about <b>resistance and revolution</b>. It kicks off inside a dream with a betrayal of interests. (Note that: someone in the story has been afraid of change.) And there's a twist! There is an accidental bodyswap at one point in the plot. "
        }
        ListElement { 
            align: Text.AlignRight
            leftMargin: 70
            rightMargin: 0            
            description: " It's a space opera story about the definition of evolution. It kicks off on Ares X with a failed mission. (Note that: someone in the story has been afraid of change.) And there's a twist! It has an unhappy ending. <p style=\"color:blue;font-size:14px;\"> I'm a big, blue, <strong>strong</strong> paragraph </p>"
        }
        ListElement { 
            align: Text.AlignLeft
            leftMargin: 0
            rightMargin: 70
            description: " It's a robot fiction story about religion and power. It kicks off on a dead star with a conspiracy being uncovered. (Note that: someone in the story has been on the run from someone else.) And there's a twist! A parallel universe will play a big role in the plot. "
        }
        ListElement { 
            align: Text.AlignRight
            leftMargin: 70
            rightMargin: 0
            description: " It's a hard science fiction story about the ```futility of ambition```. It kicks off in the year 4001 with a space battle that ends poorly for the protagonist. (Note that: this story spans five centuries.) And there's a twist! The story is a retelling of a Greek myth. "
        }
        ListElement { 
            align: Text.AlignLeft
            leftMargin: 0
            rightMargin: 70
            description: " It's a hard science fiction story about the illusion of free will. It **kicks** off on Titan with a failed experiment. (Note that: this story spans one millennium. ) And there's a twist! It's a *utopia*. "
        }
    }

    Component {
        id: textDelegateRight
        Item {
            id: item
            width: parent.width
            height: 150
            Text {

                clip: true
                width: item.width
                height: item.height
                text: description
                horizontalAlignment: align
                textFormat: Text.PlainText

                leftPadding: leftMargin
                rightPadding: rightMargin

                font.pointSize: 12
                font.family: "Monaco"    // Monaco
                wrapMode: Text.WordWrap  // Make the text multi-line

                DebugRectangle {}
            }
        }
    }    

    Component {
        id: textDelegateMiddle
        Item {
            id: item
            width: parent.width
            height: 150
            Text {
                clip: true
                width: item.width
                height: item.height
                text: description
                textFormat: Text.RichText
                horizontalAlignment: align

                font.pointSize: 12
                font.family: "Monaco"    // Monaco
                wrapMode: Text.WordWrap  // Make the text multi-line
            }
        }
    }   

    Component {
        id: textDelegateLeft
        Item {
            id: item
            width: 300
            height: 150
            anchors.right: parent.right
            Text {
                clip: true
                width: item.width
                height: item.height
                text: description
                textFormat: Text.MarkdownText

                fontSizeMode: Text.HorizontalFit

                font.pointSize: 12
                font.family: "Monaco"    // Monaco
                wrapMode: Text.WordWrap  // Make the text multi-line

                DebugRectangle {}
            }
        }
    }

    // Create a horizontal SplitView
    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        // Left Rectangle with Vertical Splitview
        Rectangle {
            implicitWidth: 1000
            SplitView.maximumWidth: 1400
            SplitView.minimumWidth: 600
            SplitView {
                anchors.fill: parent
                orientation: Qt.Horizontal
                // Top Left Rectangle 
                Rectangle {
                    id: topleftview
                    color: backgroundColor
                    implicitWidth: 400
                    SplitView.maximumWidth: 600
                    SplitView.minimumWidth: 200
                    ListView {
                        anchors.fill: parent
                        spacing: 10
                        model: textListModel
                        delegate: textDelegateLeft
                    }                    

                }
                // Lower Left Rectangle
                Rectangle {
                    color: backgroundColor
                    id: root
                    ListView {
                        anchors.fill: parent
                        spacing: 10
                        model: textListModel
                        delegate: textDelegateMiddle
                    }                    
                }
            }
        }

        // Right DataFrame Table View with x Items
        Rectangle {
            color: backgroundColor
            id: rightitem

            ListView {
                anchors.fill: parent
                spacing: 10
                model: textListModel
                delegate: textDelegateRight
            }
        }
    }
}