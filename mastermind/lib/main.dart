import 'common/game_controller.dart';
import 'common/ui_controller.dart';
import 'common/app_controller.dart';
import 'common/audio_controller.dart';

void main() {
  GameController.initialize();
  AppController.initialize();
  UiController.initialize();
  AudioController.initialize();
}
