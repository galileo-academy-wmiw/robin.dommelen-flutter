import '../game/game_instance.dart';
import '../game/game_data.dart' as data;

import 'package:shared_preferences/shared_preferences.dart';

enum GameState {
  uninitialized, playing, gameOver, success
}

abstract class IScoreData {
  Map<int,int> getScoreData();
  int getSize();
}

class ScoreData implements IScoreData {
  Map<int,int> scoreMap = Map.identity();
  int size = 0;

  @override
  Map<int, int> getScoreData() {
    return scoreMap;
  }

  @override
  int getSize() {
    return size;
  }
}

class GameController {

  static const String _keyScoreList = "scores";
  static const String _keyAccessibility = "accessibility";
  static const String _keyMaxTurns = "max_turns";

  static late final GameInstance _gameInstance;
  static GameState _gameState = GameState.uninitialized;
  static int _maxTurns = 8;
  static bool _accessibilityMode = false;
  static late Function() _funcStartReveal;

  static void initialize() {
    _gameInstance = GameInstance();
    _loadPrefs();
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
      submitScore(getNumberOfResults());
    }
    else if(getNumberOfResults() >= getMaxTurns()){
      _gameState = GameState.gameOver;
    }

    if(_gameState != GameState.playing) {
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
    _updateMaxTurnsPref();
  }

  static int getMaxTurns() {
    return _maxTurns;
  }

  static void setAccessibility(bool val) {
    _accessibilityMode = val;
    _updateAccessibilityPref();
  }

  static void _loadPrefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _maxTurns = pref.getInt(_keyMaxTurns) ?? 8;
    _accessibilityMode = pref.getBool(_keyAccessibility) ?? false;
  }

  static void _updateAccessibilityPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(_keyAccessibility, _accessibilityMode);
  }

  static void _updateMaxTurnsPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(_keyMaxTurns, _maxTurns);
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

  static void resetScore() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_keyScoreList);
  }

  static void submitScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scores = prefs.getStringList(_keyScoreList) ?? [];

    bool found = false;
    for(int i = 0; i < scores.length; i++) {
      if(scores[i].startsWith("$score=")) {
        List<String> scorePair = scores[i].split("=");
        int scoreIndex = int.parse(scorePair[0]);
        int scoreValue = int.parse(scorePair[1]) + 1;
        scores[i] = "$scoreIndex=$scoreValue";
        found = true;
        break;
      }
    }

    if(!found) {
      int initialValue = 1;
      scores.add("$score=$initialValue");
    }

    prefs.setStringList(_keyScoreList, scores);
  }

  static Future<IScoreData> getScoreData() async {
    ScoreData data = ScoreData();

    final prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList(_keyScoreList);
    int scoreLength = 0;
    try {
      scoreLength = scores!.length;
    }
    catch(error) {
      print(error.toString());
    }

    for(int i = 0; i < scoreLength; i++) {
      String s = scores![i];
      List<String> results = s.split('=');
      if(results.length == 2) {
        int scoreIndex = int.parse(results[0]);
        int scoreValue = int.parse(results[1]);
        data.scoreMap[scoreIndex] = scoreValue;
        data.size++;
      }
    }

    return Future.value(data);
  }

}
