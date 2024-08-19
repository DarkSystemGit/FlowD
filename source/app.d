import std.stdio;
import std.format;
import std.string;
import tile;
import raylib;
import raymath;

void main()
{
	SetTargetFPS(60);
	InitWindow(800, 640, "Flow.D");
	InitAudioDevice();
	TilemapLayer map=new TilemapLayer();
	EngineTileset tileset=new EngineTileset();
	tileset.load("source/worldtiles.png",16,16,1);
	float[] tiles=new float[400];
	for(int i=0;i<tiles.length;i++){
		tiles[i]=1;
	}
	map.loadFromArray(tiles,40);
	
	scope (exit)
	{
		CloseAudioDevice();
		CloseWindow();
	}
	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		DrawFPS(700,0);
		map.x+=0.01;
		map.y+=0.01;
		map.drawMap(tileset);
		EndDrawing();
	}
}
