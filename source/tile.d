module tile;
import std.math;
import std.string;
import raylib;
import std.stdio;

struct Tile
{
    float id = 0;
    float x = 0;
    float y = 0;
    float angle = 0;
    Vector2 offset = Vector2(0, 0);
    Color tfloat = Colors.WHITE;
    Tilemap tilemap;
    this(float id, float x, float y)
    {
        this.id = id;
        this.x = x;
        this.y = y;
    }

    void draw(Tilemap tilemap)
    {
        this.tilemap = tilemap;
        this.x += offset.x;
        this.y += offset.y;
        tilemap.drawTile(this);
        this.x -= offset.x;
        this.y -= offset.y;
    }

    void setId(float id)
    {
        this.id = id;
        this.draw(this.tilemap);
    }

    void setX(float x)
    {
        this.x = x;
        this.draw(this.tilemap);
    }

    void setY(float y)
    {
        this.y = y;
        this.draw(this.tilemap);
    }

    void setAngle(float angle)
    {
        this.angle = angle;
        this.draw(this.tilemap);
    }

    void setTfloat(Color tfloat)
    {
        this.tfloat = tfloat;
        this.draw(this.tilemap);
    }
}

class TilemapLayer
{
    float x = 0;
    float y = 0;
    Tile[] tiles = new Tile[0];
    void drawMap(Tilemap map)
    {
        foreach (ref Tile tile; tiles)
        {
            tile.offset = Vector2(this.x, this.y);
            tile.draw(map);
        }
    }

    void addTile(Tile tile)
    {
        this.tiles.length++;
        this.tiles[this.tiles.length - 1] = tile;
    }

    void loadFromArray(float[] tiles, float width)
    {
        foreach (i, ref float tile; tiles)
        {
            this.tiles.length++;
            this.tiles[this.tiles.length - 1] = Tile(tile, i % width, floor(i / width));
        }

    }
}

class EngineTileset : Tileset
{
    Texture2D tileset;
    float tilewidth;
    float tileheight;
    float spacing = 0;
    void load(string path, float tilewidth,
        float tileheight, float tilespacing)
    {
        this.tileset = LoadTexture(path.toStringz());
        this.tilewidth = tilewidth;
        this.tileheight = tileheight;
        this.spacing = tilespacing;
    }

    void drawTile(Tile tile)
    {

        Rectangle src = {
            (tile.id % ceil(tileset.width / tilewidth)) * tilewidth,
            floor(tile.id / ceil(tileset.width / tilewidth)) * tileheight,
            tilewidth,
            tileheight
        };
        if (!(src.x == 0 || src.x == tileset.width))
            src.x += spacing * (tile.id % ceil(tileset.width / tilewidth));
        if (!(src.y == 0 || src.y == tileset.height))
            src.y += spacing * floor(tile.id / ceil(tileset.width / tilewidth));
        Rectangle dest = {
            tile.x * tilewidth, tile.y * tileheight, tilewidth, tileheight
        };
        Vector2 origin = {tilewidth / 2, tileheight / 2};
        DrawTexturePro(this.tileset, src, dest, origin, tile.angle, tile.tfloat);
    }
    float getHeighest(){
        return (floor(tileset.width / (tilewidth+spacing))*floor(tileset.height / (tileheight+spacing)))-1;
    }
}

class Tilemap
{
    TilemapLayer[] layers = new TilemapLayer[0];
    EngineTileset[] tilesets = new EngineTileset[0];
    void addLayer(TilemapLayer layer, EngineTileset tileset, int z)
    {
        if (this.layers.length < z)
            this.layers.length = z + 1;
        this.tilesets.length = this.layers.length;
        layers[z] = layer;
        tilesets[z] = tileset;
    }

    void createLayer(float[] tiles, float width, EngineTileset tileset, int z)
    {
        TilemapLayer layer = new TilemapLayer();
        layer.loadFromArray(tiles, width);
        this.addLayer(layer, tileset, z);
    }
    void drawTile(Tile tile){
        float previd=0;
        int i=0;
        EngineTileset tileset;
        while(tileset is null){
            if(!(tilesets.length>i))return;
            if((previd<tile.id)&&(previd+tilesets[i].getHeighest()>tile.id)){
                tileset=tilesets[i];
            }
            previd+=tilesets[i].getHeighest();
            i++;
        }
        tileset.drawTile(tile);
    }
    void draw(float x,float y)
    {
        foreach (i, ref TilemapLayer layer; this.layers)
        {
            if (layer !is null)
            {
                layer.x += x;
                layer.y += y;
                layer.drawMap(this);
                layer.x -= x;
                layer.y -= y;
            }
        }
    }
}

interface Tileset
{
    void drawTile(Tile tile);

}
