import std.stdio;
import std.format;
import std.string;
import audio;
import raylib;
import raymath;

void main()
{
	class PitchRise:AudioEffect{
		void onFrame(AudioAsset audio){
			audio.volume+=0.1;
		}
	}
	SetTargetFPS(60);
	InitWindow(800, 640, "Flow.D");
	InitAudioDevice();
	scope (exit)
	{
		CloseAudioDevice();
		CloseWindow();
	}
	AudioAsset audio = new AudioAsset();
	audio.load("source/mario.wav");
	PitchRise audioEffect=new PitchRise();
	audio.addEffect(audioEffect);
	audio.play();
	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(Colors.BLACK);
		audio.onFrame();
		EndDrawing();
	}
}
