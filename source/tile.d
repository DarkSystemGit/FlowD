module tile;
import std.math;
import std.string;
import raylib;
struct Tile
{
    float id = 0;
    float x = 0;
    float y = 0;
    float angle = 0;
    Vector2 offset=Vector2(0,0);
    Color tfloat = Colors.WHITE;
    Tileset tileset;
    this(float id,float x,float y)
    {
        this.id=id;
        this.x=x;
        this.y=y;
    }
    void draw(Tileset tileset)
    {       
        this.tileset=tileset;
        this.x+=offset.x;
        this.y+=offset.y;
        tileset.drawTile(this);
        this.x-=offset.x;
        this.y-=offset.y;
    }

    void setId(float id)
    {
        this.id = id;
        this.draw( this.tileset);
    }

    void setX(float x)
    {
        this.x = x;
        this.draw( this.tileset);
    }

    void setY(float y)
    {
        this.y = y;
        this.draw( this.tileset);
    }

    void setAngle(float angle)
    {
        this.angle = angle;
        this.draw(  this.tileset);
    }

    void setTfloat(Color tfloat)
    {
        this.tfloat = tfloat;
        this.draw( this.tileset);
    }
}

class TilemapLayer
{
    float x=0;
    float y=0;
    Tile[] tiles = new Tile[0];
    void drawMap( Tileset tileset)
    {
        foreach (ref Tile tile; tiles)
        {
            tile.offset=Vector2(this.x,this.y);
            tile.draw(tileset);
        }
    }

    void addTile(Tile tile)
    {
        this.tiles.length++;
        this.tiles[this.tiles.length - 1] = tile;
    }
    void loadFromArray(float[] tiles,float width){
        foreach (i,ref float tile; tiles){
            this.tiles.length++;
        this.tiles[this.tiles.length - 1] = Tile(tile,i%width,floor(i/width));
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
}

interface Tileset
{
    void drawTile(Tile tile);
    
}
