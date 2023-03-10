import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


import '../ui/screen_score.dart';
import '../ui/screen_rules.dart';
import '../ui/screen_game.dart';
import '../ui/screen_start.dart';
import '../ui/ui_data.dart';

class AppRoot extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                body: UiController.screenSelector
            )
        )
    );
  }
}

class ScreenSelector extends StatefulWidget {

  @override
  State<ScreenSelector> createState() => _ScreenSelectorState();

  // TODO: find a more more elegant way of doing this
  void updateScreen(BuildContext context) {
    context.findAncestorStateOfType<_ScreenSelectorState>()!.setState(() {});
  }
}

class _ScreenSelectorState extends State<ScreenSelector> {

  @override
  Widget build(BuildContext context) {
    UiState stateObj = UiState.from(UiController.uiState);
    Widget screenRoot = stateObj.screenRoot;
    print(stateObj);

    return screenRoot;
  }
}


class UiController {

  static EnumUiState uiState = EnumUiState.undefined;
  static final ScreenSelector screenSelector = ScreenSelector();
  
  static void initialize() {
    UiState.values = List.generate(EnumUiState.values.length, (index) => UiState.undefined());

    UiState.stateHomeScreen = UiState(EnumUiState.homeScreen, ScreenStart());
    UiState.stateGameScreen = UiState(EnumUiState.gameScreen, ScreenGame()).enableHomeScreenButton("Play");
    UiState.stateScoreScreen = UiState(EnumUiState.scoreScreen, ScreenScore()).enableHomeScreenButton("Score");
    UiState.stateRulesScreen = UiState(EnumUiState.rulesScreen, ScreenRules()).enableHomeScreenButton("Rules");

    uiState = EnumUiState.homeScreen;
    runApp(AppRoot());
  }

  static void setScreenState(BuildContext context, EnumUiState state) {
    uiState = state;
    screenSelector.updateScreen(context);
  }

}