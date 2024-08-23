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
	InitWindow(800, 640, "Flow.D");
	InitAudioDevice();
	tiled.loadMap("./test/map.tmx");
	scope (exit)
	{
		CloseAudioDevice();
		CloseWindow();
	}
	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);	
		DrawFPS(700, 0);
		EndDrawing();
	}
}
