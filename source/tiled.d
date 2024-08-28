module tiled;
import std;
import tmx;
import interop;
import tile;
import thepath;

Tilemap loadMap(string path)
{

    tilemap* tmap = interop.loadMap(path.toStringz());
    Tilemap tilemap = new Tilemap();
    EngineTileset[] tilesets=loadTilesets(tmap.tilesets, path);
    TilemapLayer[] layers=loadLayers(tmap.layers);
    tilemap.layers=layers;
    tilemap.layers.length++;
    tilemap.tilesets=tilesets;
    tilemap.tilesets.length++;
    return tilemap;
}

EngineTileset[] loadTilesets(tilesetList* head, string path)
{
    EngineTileset[] etiles = new EngineTileset[0];
    string base = Path(path).parent.toString();
    int eol = 0;
    tilesetList ts = *head;
    while (!eol)
    {
        etiles.length++;
        auto tileset = (*ts.tileset);
        etiles[etiles.length - 1] = new EngineTileset();
        etiles[etiles.length - 1].load(Path(base).join(to!string(tileset.path))
                .toString(), tileset.tilewidth, tileset.tileheight, tileset.spacing);
        if (ts.next == null)
        {
            eol = 1;
        }
        else
        {
            ts = *ts.next;
        }

    };
    return etiles;
}

TilemapLayer[] loadLayers(tilelayerList* head)
{
    TilemapLayer[] layers = new TilemapLayer[0];
    tilelayerList tl = *head;
    int eol = 0;
    while (!eol)
    {
        tilelayer tml = *tl.tilelayer;
        Tile[] tiles= new Tile[tml.tilecount];
        
        for(int i = 0; i < tml.tilecount; i++){
            tiles[i] = new Tile(tml.tiles[i]&0x1FFFFFFF, i % tml.width, floor((cast(float)i / cast(float)tml.width)));
            int flags = tml.tiles[i]&~0x1FFFFFFF;
            if(flags & 0x80000000){
                tiles[i].horizFlip = 1;
            }
            if(flags & 0x40000000){
                tiles[i].vertFlip = 1;
            }
            if(flags & 0x20000000){
                tiles[i].angle+=45;
            }  
        }
        layers.length++;
        layers[layers.length - 1]=new TilemapLayer();
        layers[layers.length-1].tiles = tiles;
        if (tl.next == null)
        {
            eol = 1;
        }
        else
        {
            tl = *tl.next;
        }
    }
    return layers;
}
