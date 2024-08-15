import std.stdio;
import std.format;
import std.string;
import text;
import raylib;
import raymath;

void main()
{
	SetTargetFPS(60);
	InitWindow(800, 640, "Flow.D");
	scope (exit)
		CloseWindow();
	Text text=new Text;
	text.load("Hi World");
	text.setSize(100);
	while (!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		text.draw(100,100);
		EndDrawing();
	}
}



