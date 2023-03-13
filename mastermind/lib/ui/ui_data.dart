import 'package:flutter/material.dart';

enum EnumUiState {
  undefined, homeScreen, gameScreen, scoreScreen, rulesScreen, settingsScreen, resultScreen
}

class UiState {

  static late List<UiState> values;

  late EnumUiState _state;
  late Widget _screenUi;

  bool _hasHomeScreenButton = false;
  String _homeScreenButtonText = "";

  bool _hasCallbackFunc = false;
  late Function() _callbackFunction;

  UiState.undefined() {
    _state = EnumUiState.undefined;
    _screenUi = const Placeholder();
  }

  UiState(this._state, this._screenUi) {
    values[_state.index] = this;
  }

  EnumUiState get state => _state;
  Widget get screenRoot => _screenUi;
  bool get hasHomeScreenButton => _hasHomeScreenButton;
  String get homeScreenButtonText => _homeScreenButtonText;
  bool get hasCallbackFunction => _hasCallbackFunc;
  Function() get callbackFunction => _callbackFunction;

  UiState enableHomeScreenButton(String text) {
    _hasHomeScreenButton = true;
    _homeScreenButtonText = text;
    return this;
  }

  UiState setCallbackFunction(Function() func) {
    _hasCallbackFunc = true;
    _callbackFunction = func;
    return this;
  }

  static UiState from(EnumUiState state) => values[state.index];

  static late UiState stateHomeScreen;
  static late UiState stateGameScreen;
  static late UiState stateScoreScreen;
  static late UiState stateRulesScreen;
  static late UiState stateSettingsScreen;
  static late UiState stateGameRulesScreen;

}