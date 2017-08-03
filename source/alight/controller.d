module alight.controller;

import armos.app.baseapp;
import alight.config;
import alight.scene;
import alight.track;
import alight.paramtype;
import alight.controlpanel;
static import osc;

/++
+/
enum TrackType {
    Center, Left, Right
}//enum TrackType

alias SceneGenerator = Scene delegate();


class Controller : BaseApp{
    this(SceneGenerator[] scenes, Config config){
        _config = config;
        _sceneLibrary = scenes;
        _oscServer = new osc.Server(8000);

        _currentTrack = TrackType.Center;
    }

    override void setup(){
        _trackLeft  = new Track;
        _trackRight = new Track;
        _controlPanel = new ControlPanel();
        _trackLeft.assign(_sceneLibrary[0]());
        _trackRight.assign(_sceneLibrary[0]());

        signals = [
            0:0,
            1:0,
            2:0, 
            3:0, 
            4:0,
            5:0,
            6:0, 
            7:0, 
            8:0,
            9:0,
            10:0, 
            11:0, 
            12:0,
            13:0,
            14:0, 
            15:0, 
        ];
    }

    override void update(){
        updateSignals;
        _trackLeft.update;
        _trackRight.update;
    }

    override void draw(){
        import armos.graphics;
        import armos.app.window;
        import std.stdio;
        windowSize.x.writeln;
        pushMatrix;
        // translate(windowSize.x*0.5-_controlPanel.screenSize.x*1, 0, 0);
        scale(2, 2, 1);
        _controlPanel.draw(this, _trackLeft, _trackRight);
        popMatrix;
        _trackLeft.draw;
        _trackRight.draw;
    }

    // override void keyPressed(ar.utils.KeyType key){}
    //
    // override void keyReleased(ar.utils.KeyType key){}
    //
    // override void mouseMoved(ar.math.Vector2i position, int button){}
    //
    // override void mousePressed(ar.math.Vector2i position, int button){}
    //
    // override void mouseReleased(ar.math.Vector2i position, int button){}

    int[int] signals;

    private{
        Config _config;
        SceneGenerator[] _sceneLibrary;
        Track _trackLeft;
        Track _trackRight;
        TrackType _currentTrack;
        osc.Server _oscServer;
        ControlPanel _controlPanel;

        void updateSignals(){
            auto ms = _oscServer.popMessages;

            foreach (m; ms) {
                import std.conv;
                import std.stdio;
                int id    = m.args[0].to!int;
                int value = m.args[1].to!int;
                // auto paramType = _config.oscDic[id];
                id.writeln;

                if(id == 60){
                    _currentTrack = TrackType.Left;
                }
                if(id == 61){
                    _currentTrack = TrackType.Center;
                }
                if(id == 62){
                    _currentTrack = TrackType.Right;
                }

                //Slider
                if( 0<= id && id < 8){
                    if(_currentTrack == TrackType.Left) _trackLeft.signal(id, value);
                    if(_currentTrack == TrackType.Right) _trackRight.signal(id, value);
                    if(_currentTrack == TrackType.Center) signals[id] = value;
                }

                //knob
                if( 16<= id && id < 24){
                    if(_currentTrack == TrackType.Left) _trackLeft.signal(id-8, value);
                    if(_currentTrack == TrackType.Right) _trackRight.signal(id-8, value);
                    if(_currentTrack == TrackType.Center) signals[id-8] = value;
                }
            }
        }
    }
}

void run(SceneGenerator[] scenes){
    static import ar = armos;
    import alight.controller;
    import armos = armos.app.runner;

    auto config = Config();
    armos.run(new Controller(scenes, config));
}
