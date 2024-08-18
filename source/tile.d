module tile;
import std.math;

struct Tile
{
    int id = 0;
    int x = 0;
    int y = 0;
    float angle = 0;
    Color tint=Colors.WHITE;
    Tileset tileset;
    Tilemap map;
    void draw(Tileset tileset, Tilemap map)
    {
        this.tileset = tileset;
        this.map = map;
        tileset.drawTile(this.x, this.y, map, this.angle);
    }

    void setId(int id)
    {
        this.id = id;
        this.draw(this.tileset, this.map, this.angle);
    }

    void setX(int x)
    {
        this.x = x;
        this.draw(this.tileset, this.map, this.angle);
    }

    void setY(int y)
    {
        this.y = y;
        this.draw(this.tileset, this.map, this.angle);
    }
    void setAngle(float angle){
        this.angle=angle;
        this.draw(this.tileset, this.map, this.angle);
    }
    void setTint(Color tint){
        this.tint=tint;
        this.draw(this.tileset, this.map, this.angle);
    }
}

class Tilemap
{
    float x;
    float y;

    void drawMap(float x, float y)
    {

    }
}

class EngineTileset : Tileset
{
    Texture2D tileset;
    int tilewidth;
    int tileheight;
    int spacing=0;
    void load(string path, int tilewidth,
        int tileheight,int tilespacing)
    {
        this.tileset = LoadTexture(path.toStringz());
        this.tilewidth = tilewidth;
        this.tileheight = tileheight;
        this.spacing=tilespacing;
    }

    void drawTile(Tile tile)
    {

        Rectangle src = {
            (tile.id % ceil(tileset.width / tilewidth)) * tilewidth,
            floor(tile.id / ceil(tileset.width / tilewidth)) * tileheight,
            tilewidth,
            tileheight
        };
        if(!(src.x==0||src.x==tileset.width))src.x+=spacing*(tile.id % ceil(tileset.width / tilewidth));
        if(!(src.y==0||src.y==tileset.height))src.y+=spacing*floor(tile.id / ceil(tileset.width / tilewidth));
        Rectangle dest = {
            tile.x*tilewidth,tile.y*tileheight,tilewidth,tileheight
        };
        Vector2 origin = {tilewidth / 2, tileheight / 2};
        DrawTexturePro(this.tileset, src, dest, origin, tile.angle, tile.tint);
    }
}

interface Tileset
{
    void drawTile(int x, int y, Tilemap map, float angle);
    void load(string path, ...);
}
