import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioController {
  static const String _keyMusicVolume = "music_volume";
  static const String _keySfxVolume = "sfx_volume";

  static late AudioPlayer _backgroundMusicPlayer;
  static late AudioPlayer _sfxPlayer;

  static late AssetSource _buttonSoundSource;
  static late AssetSource _pitchedButtonSoundSource;
  static late AssetSource _ambientSoundSource;

  static double _musicVolume = 1.0;
  static double _sfxVolume = 1.0;

  static void initialize() {
    _loadVolumes();

    _buttonSoundSource = AssetSource("sfx/button.wav");
    _pitchedButtonSoundSource = AssetSource("sfx/button_pitched.wav");
    _ambientSoundSource = AssetSource("sfx/ambient.mp3");

    _backgroundMusicPlayer = AudioPlayer();
    _backgroundMusicPlayer.setVolume(_musicVolume);
    _backgroundMusicPlayer.play(_ambientSoundSource);
    _backgroundMusicPlayer.onPlayerComplete.listen((event) {
      _backgroundMusicPlayer.play(_ambientSoundSource);
    });

    _sfxPlayer = AudioPlayer();
    _sfxPlayer.setVolume(_sfxVolume);
  }

  static void _loadVolumes() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _musicVolume = pref.getDouble(_keyMusicVolume) ?? 1.0;
    _sfxVolume = pref.getDouble(_keySfxVolume) ?? 1.0;
  }

  static void _saveSfxVolume() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(_keySfxVolume, _sfxVolume);
  }

  static void _saveMusicVolume() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setDouble(_keyMusicVolume, _musicVolume);
  }

  static void dispose() {
    _backgroundMusicPlayer.dispose();
    _sfxPlayer.dispose();
  }

  static void playButtonSound() {
    _sfxPlayer.play(_buttonSoundSource);
  }

  static void playButtonPitchedSound() {
    _sfxPlayer.play(_pitchedButtonSoundSource);
  }

  static void setSfxVolume(double volume) {
    _sfxVolume = volume;
    _sfxPlayer.setVolume(volume);
    _saveSfxVolume();
  }

  static void setMusicVolume(double volume) {
    _musicVolume = volume;
    _backgroundMusicPlayer.setVolume(_musicVolume);
    _saveMusicVolume();
  }

  static double getSfxVolume() {
    return _sfxVolume;
  }

  static double getMusicVolume() {
    return _musicVolume;
  }
}