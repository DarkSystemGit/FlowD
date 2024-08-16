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
	Text text2=new Text;
	text2.load("Hi World");
	text.load("Hi World");
	text.setSize(100);
	text2.setSize(100);
	
	while (!WindowShouldClose()){
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		text.rotate(1);
		text.draw(200,300);
		text2.draw(200,300);
		EndDrawing();
	}
}



