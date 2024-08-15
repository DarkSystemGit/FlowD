module text;
import model;
import std.format;
import std.stdio;
import std.string;
import std.math.traits;
import raylib;
import raymath;

class Text : GAsset
{
    float size = 10;
    float angle = 0;
    string text;
    string name;
    raylib.Font font;
    Vector2 origin = Vector2(0, 0);
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
        writeln(this.font);
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

    void rotate(int angle)
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
        DrawTextPro(this.font, this.text.toStringz(), Vector2(x, y), this.origin, this.angle, this.size, this.size / this
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
