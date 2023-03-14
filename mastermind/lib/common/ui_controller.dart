import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mastermind/common/audio_controller.dart';
import 'package:mastermind/common/game_controller.dart';

import '../ui/screen_score.dart';
import '../ui/screen_rules.dart';
import '../ui/screen_game.dart';
import '../ui/screen_start.dart';
import '../ui/screen_result.dart';
import '../ui/screen_settings.dart';
import '../ui/ui_data.dart';

class AppRoot extends StatefulWidget {

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {

  @override
  void initState() {
    super.initState();
    AudioController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    AudioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
        theme: ThemeData(fontFamily: 'Righteous'),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                body: DecoratedBox(
                    decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/img/sky.jpg"), fit: BoxFit.cover)
                  ),
                child: ScreenSelector()
                )
            )
        )
    );
  }
}

class ScreenSelector extends StatefulWidget {

  @override
  State<ScreenSelector> createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> with TickerProviderStateMixin {

  final Duration _fadeDuration = const Duration(milliseconds: 500);

  late AnimationController _screenFadeAnimController;
  late Animation<double> _screenFadeAnim;

  EnumUiState _uiStateToSet = EnumUiState.undefined;

  @override
  void initState() {
    super.initState();

    _screenFadeAnimController = AnimationController(
        vsync: this,
        duration: _fadeDuration
    );

    _screenFadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(_screenFadeAnimController);
    _screenFadeAnim.addListener(() {
      setState(() {
        if(_screenFadeAnim.status == AnimationStatus.completed) {
          _screenFadeAnimController.reverse();
          UiController.uiState = _uiStateToSet;
          _uiStateToSet = EnumUiState.undefined;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _screenFadeAnimController.dispose();
  }

  void setScreenState(EnumUiState screenState) {
    _uiStateToSet = screenState;
    _screenFadeAnimController.forward();
  }


  @override
  Widget build(BuildContext context) {
    UiState stateObj = UiState.from(UiController.uiState);
    Widget screenRoot = stateObj.screenRoot;

    return Opacity(
        opacity: _screenFadeAnim.value,
        child: screenRoot
    );
  }
}


class UiController {

  static EnumUiState uiState = EnumUiState.undefined;
  //static final ScreenSelector screenSelector = ScreenSelector();
  
  static void initialize() {
    UiState.values = List.generate(EnumUiState.values.length, (index) => UiState.undefined());

    UiState.stateHomeScreen = UiState(EnumUiState.homeScreen, ScreenStart());
    UiState.stateGameScreen = UiState(EnumUiState.gameScreen, ScreenGame()).enableHomeScreenButton("Play")
        .setCallbackFunction(() => GameController.newGame());
    UiState.stateScoreScreen = UiState(EnumUiState.scoreScreen, ScreenScore()).enableHomeScreenButton("Score");
    UiState.stateRulesScreen = UiState(EnumUiState.rulesScreen, ScreenRules()).enableHomeScreenButton("Rules");
    UiState.stateSettingsScreen = UiState(EnumUiState.settingsScreen, ScreenSettings());
    UiState.stateGameRulesScreen = UiState(EnumUiState.resultScreen, ScreenResult());

    uiState = EnumUiState.homeScreen;

    runApp(AppRoot());
  }

  static void setScreenState(BuildContext context, EnumUiState state) {
    try {
      context.findAncestorStateOfType<_ScreenSelectorState>()!.setScreenState(state);
    }
    catch(error) {
      print(error);
    }
  }

}