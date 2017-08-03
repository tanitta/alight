module alight.track;

import alight.scene;
import armos.app.baseapp;
import alight.paramtype;
import armos.graphics.fbo;

/++
+/
class Track: BaseApp{
    public{

        void assign(Scene s){
            _scene = s;
            _scene.setup;
            _isPlaying = false;
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
            if(_scene && _isPlaying){
                _scene.update;
            }
        }

        override void draw(){
            if(_scene){
                _scene.draw;
            }
        }

        void reset(){
            _scene.setup;
        }

        void pause(){
            _isPlaying = false;
        }

        void play(){
            _isPlaying = true;
        }

        void signal(in int id, in int v){
            if(_scene){
                _scene.signal(id, v);
                signals[id] = v;
            }

        }

        int[int] signals;

        Fbo fbo;
    }//public

    private{
        Scene _scene;
        bool _isPlaying;
    }//private
}//class Track
