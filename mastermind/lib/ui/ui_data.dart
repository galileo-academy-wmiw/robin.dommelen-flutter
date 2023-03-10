import 'package:flutter/material.dart';

import "screen_start.dart";
import "screen_game.dart";
import "screen_rules.dart";
import "screen_score.dart";

enum EnumUiState {
  undefined, homeScreen, gameScreen, scoreScreen, rulesScreen
}

class UiState {

  static late List<UiState> values;

  late EnumUiState _state;
  late Widget _screenUi;

  bool _hasHomeScreenButton = false;
  String _homeScreenButtonText = "";

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

  UiState enableHomeScreenButton(String text) {
    _hasHomeScreenButton = true;
    _homeScreenButtonText = text;
    return this;
  }

  static UiState from(EnumUiState state) => values[state.index];

  static late UiState stateHomeScreen;
  static late UiState stateGameScreen;
  static late UiState stateScoreScreen;
  static late UiState stateRulesScreen;

}