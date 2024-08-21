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
	Tilemap map=new Tilemap();
	EngineTileset tileset=new EngineTileset();
	tileset.load("source/worldtiles.png",16,16,1);
	float[] tiles=new float[400];
	for(int i=0;i<tiles.length;i++){
		tiles[i]=1;
	}
	map.createLayer(tiles,40,tileset,1);
	
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
		map.draw();
		EndDrawing();
	}
}
