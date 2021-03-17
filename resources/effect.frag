varying highp vec2 coord;
uniform sampler2D source;
uniform lowp float qt_Opacity;
uniform highp float frequency;
uniform highp float amplitude;
uniform highp float time;
void main(){
    vec2 p= sin(time + frequency*coord);
    gl_FragColor = texture2D(source, coord + amplitude*vec2(p.y, -p.x))*qt_Opacity;
}
