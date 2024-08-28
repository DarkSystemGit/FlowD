#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

#include "./../libs/tmx/src/tmx.h"

typedef struct _tileset
{
    char *path;
    int tilewidth;
    int tileheight;
    int spacing;
    int margin;

} tileset;
typedef struct _tilemap
{
    struct _tilelayerList *layers;
    struct _tilesetList *tilesets;
} tilemap;
typedef struct _tilelayer
{
    char *name;
    int *tiles;
    int tilecount;
    int width;
    int height;
} tilelayer;
typedef struct _tilesetList
{
    tileset *tileset;
    struct _tilesetList *next;
} tilesetList;
typedef struct _tilelayerList
{
    tilelayer *tilelayer;
    struct _tilelayerList *next;
} tilelayerList;

tilesetList *convertTilesetList(tilesetList *block, tmx_tileset_list *ts)
{
    block->tileset = (tileset *)malloc(sizeof(tileset));
    block->tileset->path = ts->tileset->image->source;
    block->tileset->tilewidth = ts->tileset->tile_width;
    block->tileset->tileheight = ts->tileset->tile_height;
    block->tileset->spacing = ts->tileset->spacing;
    block->tileset->margin = ts->tileset->margin;
    if (ts->next != NULL)
    {
        block->next = convertTilesetList((tilesetList *)malloc(sizeof(tilesetList)), ts->next);
    }
    else
    {
        block->next = NULL;
    }
    return block;
}
tilelayerList *convertTilelayerList(tilelayerList *block, tmx_layer *layer, int w, int h)
{
    block->tilelayer = (tilelayer *)malloc(sizeof(tilelayer));
    block->tilelayer->name = layer->name;
    block->tilelayer->width = w;
    block->tilelayer->height = h;
    block->tilelayer->tiles = (int *)malloc(sizeof(int) * (w * h));
    block->tilelayer->tilecount = w * h;
    if (layer->type == L_LAYER)
    {
        for (int i = 0; i < w * h; i++)
        {
            block->tilelayer->tiles[i] = layer->content.gids[i];

        }
    }
    if (layer->next != NULL)
    {
        block->next = convertTilelayerList((tilelayerList *)malloc(sizeof(tilelayerList)), layer->next, w, h);
    }
    else
    {
        block->next = NULL;
    }
    return block;
}
tilemap convertMap(tmx_map *map)
{
    tilemap tmap;

    tmap.tilesets = convertTilesetList((tilesetList *)malloc(sizeof(tilesetList)), map->ts_head);

    tmap.layers = convertTilelayerList((tilelayerList *)malloc(sizeof(tilelayerList)), map->ly_head, map->height, map->width);

    return tmap;
};
tilemap *loadMap(const char *path)
{
    tmx_map *map = tmx_load(path);
    if (map == NULL)
    {
        printf("Error loading map");
        exit(1);
    }
    tilemap *tmap = (tilemap *)malloc(sizeof(tilemap));
    *tmap = convertMap(map);
    return tmap;
}
