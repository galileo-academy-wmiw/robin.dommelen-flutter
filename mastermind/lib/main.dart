import 'package:flutter/cupertino.dart';

import 'common/game_controller.dart';
import 'common/ui_controller.dart';
import 'common/audio_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GameController.initialize();
  UiController.initialize();
}
