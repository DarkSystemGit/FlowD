module audio;
import raylib;
import model;
import std.stdio;
import std.string;
class AudioAsset{
    Music audio;
    float pitch=1.0;
    float volume=1.0;
    float time=0.0;
    float pan=0.0;
    bool looping=false;
    AudioEffect[] effects=new AudioEffect[0];
    void load(string path){
        this.audio=LoadMusicStream(path.toStringz());
        this.audio.looping=false;
    }
    void onFrame(){
        UpdateMusicStream(this.audio);
        this.time=GetMusicTimePlayed(this.audio);
        this.setPitch(this.pitch);
        this.setVolume(this.volume);
        this.setPan(this.pan);
        this.setLooping(this.looping);
        for(int i=0;i<this.effects.length;i++){
            this.effects[i].onFrame(this);
        }
    }
    void play(){
        PlayMusicStream(this.audio);
    }
    void pause(){
        PauseMusicStream(this.audio);
    }
    void resume(){
        ResumeMusicStream(this.audio);
    }
    void stop(){
        StopMusicStream(this.audio);
    }
    void setPitch(float pitch){
        this.pitch=pitch;
        SetMusicPitch(this.audio,pitch);
    }
    void setPosition(float time){
        SeekMusicStream(this.audio,time);
    }
    void setVolume(float volume){
        this.volume=volume;
        SetMusicVolume(this.audio,volume);
    }   
    void setPan(float pan){
        this.pan=pan;
        SetMusicPan(this.audio,pan);
    }
    void setLooping(bool loop){
        this.looping=loop;
        this.audio.looping=loop;
    }
    bool playing(){
        return IsMusicStreamPlaying(this.audio);
    }
    float getTime(){
        return GetMusicTimePlayed(this.audio);
    }
    float getLength(){
        return GetMusicTimeLength(this.audio);
    }
    void addEffect(AudioEffect effect){
        this.effects.length++;
        this.effects[this.effects.length-1]= effect;
        
    }
    ~this(){
        UnloadMusicStream(this.audio);
    } 
}
interface AudioEffect{
    void onFrame(AudioAsset audio);
}