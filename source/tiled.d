module tiled;
import std;
import tmx;
import tile;
void loadMap(string path){
    tmx_map* map=tmx.tmx_load(path.toStringz());
    if(map is null){
        writeln("Cannot load map");
        return;
    }
    writeln((*map).class_type);
}