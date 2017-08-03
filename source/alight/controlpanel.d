module alight.controlpanel;

import typescreen;
import armos.math.vector;
import alight.track;
import alight.controller;

private alias V2 = Vector2f;
private alias V3 = Vector3f;
private alias V4 = Vector4f;
private alias Vs2 = Vector!(size_t, 2);

/++
+/
class ControlPanel {
    public{
        this(){
            import std.path;
            string fontPath = buildNormalizedPath(__FILE_FULL_PATH__.dirName, "..", "..", "data", "font.png");

            _fontSize = Vs2(8, 8);
            _gridSize = Vs2(120, 32);
            _screenSize = _fontSize * _gridSize;
            _screen = new Screen(_gridSize, _fontSize, fontPath);
        }

        Vs2 screenSize()const{
            return _screenSize;
        }

        void draw(Controller center, Track left, Track right){
            drawSignals(left.signals, V2(0, 0));
            drawSignals(center.signals, V2(5*8, 0));
            drawSignals(right.signals, V2(_gridSize.x-5*8, 0));
            _screen.draw;
        }

        void drawSignals(int[int] signals, V2 position){
            _screen.writeParams(position+V2(0, _screen.size.y-1), [
                    signals[0], 
                    signals[1], 
                    signals[2], 
                    signals[3], 
                    signals[4], 
                    signals[5], 
                    signals[6], 
                    signals[7], 
            ]);

            _screen.writeParams(position+V2(0, _screen.size.y-2), [
                    signals[8], 
                    signals[9], 
                    signals[10], 
                    signals[11], 
                    signals[12], 
                    signals[13], 
                    signals[14], 
                    signals[15], 
            ]);
        };
    }//public

    private{
        Screen _screen;

        Vs2 _fontSize;
        Vs2 _gridSize;
        Vs2 _screenSize;
    }//private
}//class ControlPanel

void writeParams(Screen screen, V2 position, int[8] arr){
    string str;
    foreach (v; arr) {
        import std.format;
        str ~= format("[%03d]", v);
    }
    writeString(screen, position, str);
}
void writeString(Screen screen, V2 position, string str){
    foreach (int i, ch; str) {
        if(position.x + i > screen.size.x)break;
        V2 cursor = position + V2(i, 0);
        screen.character(cursor).ascii = ch;
    }
}
