module text;
import model;
import std.format;
import std.stdio;
import std.string;
import std.math.traits;
import raylib;
import raymath;

class TextAsset : GAsset
{
    float width = 0;
    float height = 0;
    float size = 10;
    float angle = 0;
    string text;
    string name;
    raylib.Font font;
    Vector2 origin;
    raylib.Color color = Colors.WHITE;
    string type = "Text";
    void load()
    {
    }

    void free()
    {
    }

    void load(string text)
    {
        this.text = text;
        this.font = GetFontDefault();
    }

    void setFont(Font font)
    {
        this.font = font.getData();
    }

    void setSize(float size)
    {
        this.size = size;
    }

    void setText(string text)
    {
        this.text = text;
    }

    void rotate(float angle)
    {
        this.angle += angle;
    }

    void setColor(raylib.Color color)
    {
        this.color = color;
    }

    void setOrigin(float x, float y)
    {
        this.origin = Vector2(x, y);
    }

    void draw(float x, float y)
    {   
        
        Vector2 dims = MeasureTextEx(this.font, this.text.toStringz(), this.size, this.size / this.font.baseSize);
        this.width=dims.x;
        this.height=dims.y;
        Vector2 origin=Vector2(this.width/2,this.height/2);
        if ((!isNaN(this.origin.x)) && (!isNaN(this.origin.y)))
            origin = this.origin;
        DrawTextPro(this.font, this.text.toStringz(), Vector2(x+origin.x, y+origin.y), origin, this.angle, this.size, this.size / this
                .font.baseSize, this.color);
    }
}

class Font : Asset
{
    raylib.Font data;
    bool loaded = false;
    string path;
    void load(string path)
    {
        this.path = path;
        this.load();
    }

    void load()
    {
        this.data = LoadFont(this.path.toStringz());
        this.loaded = true;
    }

    void free()
    {
        UnloadFont(this.data);
        this.loaded = false;
    }

    raylib.Font getData()
    {
        if (!this.loaded)
            this.load();
        return this.data;
    }
}
