import QtQuick 6
import QtQuick.Window 2.15
import QtQuick.Controls 6
import QtQuick.Controls.Material 2.15

ApplicationWindow{
    id: window
    width: 400
    height: 580
    visible:true
    title: qsTr("Login Page")

    // Set Flags
    flags: Qt.WindowCloseButtonHint | Qt.WindowMinimizeButtonHint | Qt.CustomizeWindowHint | Qt.Dialog | Qt.WindowTitleHint

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Rectangle {
        width: 400; height: 580
        color: '#1e1e1e'

        Row {
            anchors.centerIn: parent
            spacing: 20
            Image {
                id: sourceImage
                width: 80; height: width
                source: 'assets/tulips.jpg'
            }
            ShaderEffect {
                id: effect
                width: 80; height: width
                property variant source: sourceImage
            }
            ShaderEffect {
                id: effect2
                width: 80; height: width
                // the source where the effect shall be applied to
                property variant source: sourceImage
                // default vertex shader code
                vertexShader: "
                    uniform highp mat4 qt_Matrix;
                    attribute highp vec4 qt_Vertex;
                    attribute highp vec2 qt_MultiTexCoord0;
                    varying highp vec2 qt_TexCoord0;
                    void main() {
                        qt_TexCoord0 = qt_MultiTexCoord0;
                        gl_Position = qt_Matrix * qt_Vertex;
                    }"
                // default fragment shader code
                fragmentShader: "
                    varying highp vec2 qt_TexCoord0;
                    uniform sampler2D source;
                    uniform lowp float qt_Opacity;
                    void main() {
                        gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity;
                    }"
            }
        }
    }
}