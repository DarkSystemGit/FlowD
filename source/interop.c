#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>

#include "tmx.h"

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
    int width;
    int height;
    int *tiles;
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

tilesetList *convertTilesetList(tilesetList *block, tmx_tileset_list *tileset)
{
    block->tileset = (tileset *)malloc(sizeof(tileset));
    block->tileset->path;
    block->next=convertTilesetList((tilesetList *)malloc(sizeof(tilesetList)),tileset->next);
}
tilelayerList *convertTilelayerList(tilelayerList *block, tmx_layer *layer)
{
}
tilemap convertMap(tmx_map *map)
{
    tilemap tmap;
    // Initialize tilesetlist and tilelayerlist
    tmap.tilesets = convertTilesetList((tilesetList *)malloc(sizeof(tilesetList)), map->ts_head);
    tmap.layers = convertTilelayerList((tilelayerList *)malloc(sizeof(tilelayerList)), map->ly_head);
    return tmap;
};

// void main() {};