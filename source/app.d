import std.stdio;
import std.format;
import std.string;
import tile;
import raylib;
import raymath;
import tiled;
void main()
{
	SetTargetFPS(60);
	InitWindow(1000, 1000, "Flow.D");
	InitAudioDevice();
	Tilemap map=tiled.loadMap("./test/map.tmx");
	scope (exit)
	{
		CloseAudioDevice();
		CloseWindow();
	} 
	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		map.draw(0,0);	
		DrawFPS(700, 0);
		EndDrawing();
	}
}
