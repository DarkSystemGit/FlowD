module tiled;
import std;
import tmx;
//import dumper;
import tile;
void loadMap(string path){
    tmx_map* map=tmx.tmx_load(path.toStringz());
    if(map is null){
        writeln("Cannot load map");
        return;
    }
    
    EngineTileset etile=new EngineTileset();
    //dump_map(map);
    //etile.load(std.conv.to!string(*(tileset.image).source),cast(float)tileset.tile_width,cast(float)tileset.tile_height,cast(float)tileset.spacing);
}