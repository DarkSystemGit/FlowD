module tiled;
import std;
import tmx;
import interop;
import tile;
import thepath;

void loadMap(string path)
{

    tilemap* tmap = interop.loadMap(path.toStringz());
    writeln(loadTilesets(tmap.tilesets, path));
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

TilemapLayer loadLayers(tilelayerList* head)
{
    TilemapLayer[] layers = new TilemapLayer[0];
    tilelayerList tl = *head;
    int eol = 0;
    while (!eol)
    {
        layers.length++;
        layers[layers.length - 1] = new TilemapLayer();
        tilelayer tml = *tl.tilelayer;
        //layers[layers.length - 1].loadFromArray(tl.data, tl.width);
        writeln(tml);
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
