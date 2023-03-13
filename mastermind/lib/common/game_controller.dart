import '../game/game_instance.dart';
import '../game/game_data.dart' as data;

enum GameState {
  uninitialized, playing, gameOver, success
}

class GameController {

  static late final GameInstance _gameInstance;
  static GameState _gameState = GameState.uninitialized;
  static int _maxTurns = 8;
  static bool _accessibilityMode = false;
  static late Function() _funcStartReveal;

  static void initialize() {
    _gameInstance = GameInstance();
  }

  static void newGame() {
    _gameInstance.createNewCode();
    _gameInstance.clearInput();
    _gameInstance.clearResults();

    _gameState = GameState.playing;
  }

  static void cycleInputNext(int index) {
    _gameInstance.cycleInputNext(index);
  }

  static void cycleInputPrev(int index) {
    _gameInstance.cycleInputPrev(index);
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
    else if(getNumberOfResults() >= getMaxTurns()){
      _gameState = GameState.gameOver;
    }

    if(_gameState != GameState.playing) {
      print("start reveal");
      _funcStartReveal();
    }
  }

  static int getNumberOfPins() {
    return _gameInstance.pinCount;
  }

  static get gameState => _gameState;

  static int getNumberOfResults() {
    return _gameInstance.getResultEntryCount();
  }

  static data.PinColor getInputPinColor(int index) {
    return _gameInstance.getInputPinColor(index);
  }

  static data.PinColor getControlPinColor(int index, bool hidden) {
    return hidden ? data.PinColor.values[0] : _gameInstance.getControlPinColor(index);
  }

  static data.PinColor getEntryInputPinColor(int entry, int index) {
    return _gameInstance.getResultEntry(entry).inputColors[index];
  }

  static data.PinColor getEntryResultPinColor(int entry, int index) {
    return _gameInstance.getResultEntry(entry).resultColors[index];
  }

  static bool isGameInProgress() {
    return _gameState == GameState.playing;
  }

  static void addMaxTurns(int delta) {
    _maxTurns += delta;
    if(_maxTurns < 0) _maxTurns = 0;
  }

  static int getMaxTurns() {
    return _maxTurns;
  }

  static void setAccessibility(bool val) {
    _accessibilityMode = val;
  }

  static bool isAccessibilityMode() {
    return _accessibilityMode;
  }

  static void setStartRevealFunc(Function() func) {
    _funcStartReveal = func;
  }

  static GameState getGameState() {
    return _gameState;
  }

}
