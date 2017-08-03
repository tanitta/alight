module alight.scene;
import alight.paramtype;

/++
+/
interface Scene{
    public{

        void setup();

        void update();

        void draw();

        ///
        void volume(in float);

        ///
        void signal(in int id, in int v);
    }//public

    private{
    }//private
}//interface Scene
