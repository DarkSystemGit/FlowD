module texture;
import model;

import std.format;
import std.string;
import std.math.traits;
import raylib;
import raymath;

class Texture : GAsset
{
    raylib.Texture2D data;
    int width;
    int height;
    float angle = 0;
    string path;
    bool loaded = false;
    Vector2 iscale = Vector2(1, 1);
    Vector2 origin;
    raylib.Color itint = Colors.RAYWHITE;
    string type = "Texture";
    void load(string path)
    {
        this.path = path;
        this.load();
    }

    void load()
    {
        if (this.loaded)
            return;
        this.data = LoadTexture(this.path.toStringz());
        this.width = this.data.width;
        this.height = this.data.height;
        this.loaded = true;
    }

    void free()
    {
        UnloadTexture(this.data);
        this.loaded = false;
    }

    void draw(float x, float y)
    {
        if (!this.loaded)
            this.load();
        Rectangle src = {0, 0, this.data.width, this.data.height};
        Rectangle dest = {
            x, y, this.data.width * this.iscale.x, this.data.height * this.iscale.y
        };
        Vector2 origin = {this.data.width / 2, this.data.height / 2};
        if ((!isNaN(this.origin.x)) && (!isNaN(this.origin.y)))
            origin = this.origin;
        DrawTexturePro(this.data, src, dest, origin, this.angle, this.itint);
    }

    void rotate(int angle)
    {
        this.angle += angle;
    }

    void scale(float x, float y)
    {
        this.iscale = Vector2(x, y);
    }

    void tint(raylib.Color tint)
    {
        this.itint = tint;
    }

    void setOrigin(float x, float y)
    {
        this.origin = Vector2(x, y);
    }
}


