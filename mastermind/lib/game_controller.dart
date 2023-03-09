import 'dart:math';

import 'game_instance.dart';
import 'game_data.dart' as data;

enum GameState {
  uninitialized, playing, gameOver, success
}

class GameController {

  static final GameInstance _gameInstance = GameInstance();
  static GameState _gameState = GameState.uninitialized;

  static void newGame() {
    _gameInstance.createNewCode();
    _gameInstance.clearInput();
    _gameInstance.clearResults();

    _gameState = GameState.playing;
  }

  static void cycleInput(int index) {
    _gameInstance.cycleInput(index);
  }

  static void submitInput() {
    // Compare the input and the control, and add the results to the game
    List<data.PinColor> results = _gameInstance.compareCode();
    _gameInstance.addInputAsResult(results);

    // Evaluate if the input is correct and handle accordingly
    bool correct = _gameInstance.evaluateResult(results);
    if(correct) {
      _gameState = GameState.success;
    }
    else {
      _gameInstance.clearInput();
    }
  }

  static int getColorCodeForInputPin(int index) {
    data.PinColor pinColor = _gameInstance.getInputPinColor(index);
    return data.pinColorCodes[pinColor.index];
  }

  static int getColorCodeForControlPin(int index) {
    if(_gameState == GameState.playing) {
      return data.pinColorCodes[0];
    }
    data.PinColor pinColor = _gameInstance.getControlPinColor(index);
    return data.pinColorCodes[pinColor.index];
  }

  static int getNumberOfPins() {
    return _gameInstance.pinCount;
  }

  static get gameState => _gameState;

  static int getNumberOfResults() {
    return _gameInstance.getResultEntryCount();
  }

  static int getColorCodeForResultCodePin(int resultIndex, int pinIndex) {
    data.PinColor pinColor =  _gameInstance.getResultEntry(resultIndex)
        .inputColors[pinIndex];
    print(pinColor);
    return data.pinColorCodes[pinColor.index];
  }

  static int getColorCodeForResultPin(int resultIndex, int pinIndex) {
    data.PinColor pinColor =  _gameInstance.getResultEntry(resultIndex)
        .resultColors[pinIndex];
    return data.pinColorCodes[pinColor.index];
  }
}
