module model;

interface GAsset : Asset
{
    void draw(float x, float y);
}

interface Asset
{


    void load();

    void free();

}