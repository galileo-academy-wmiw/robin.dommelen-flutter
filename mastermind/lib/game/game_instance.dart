import 'dart:math';

import 'game_data.dart' as data;

class EntryInputResult {
  final List<data.PinColor> inputColors;
  final List<data.PinColor> resultColors;

  const EntryInputResult({required this.inputColors, required this.resultColors});
}

class GameInstance {

  final int _pinCount = 4;

  late List<data.PinColor> _controlCode;
  late List<data.PinColor> _input;
  late List<EntryInputResult> _results;

  GameInstance() {
    clearControl();
    clearInput();
    clearResults();
  }

  void createNewCode() {
    List<data.PinColor> possibilities = List.from(data.codePinValues);

    if(_controlCode.length > possibilities.length) throw Error();

    for (int i = 0; i < _controlCode.length; i++) {
      int curPin = Random().nextInt(possibilities.length);
      _controlCode[i] = possibilities[curPin];
      possibilities.removeAt(curPin);
    }
  }

  List<data.PinColor> compareCode() {
    List<data.PinColor> result = List.generate(_pinCount, (index) =>
      data.resultPinValues[data.iResultColorWrong]);

    for (int i = 0; i < _controlCode.length; i++) {
      data.PinColor target = _controlCode[i];

      for (int j = 0; j < _input.length; j++) {
        if (target == _input[j]) {
          if (i == j) {
            result[i] = data.resultPinValues[data.iResultColorCorrect];
            break;
          } else {
            result[i] = data.resultPinValues[data.iResultColorPartialCorrect];
          }
        }
      }
    }

    result.sort((a, b) => ((a.index > b.index) ? -1 : 1));
    return result;
  }

  void cycleInputNext(int index) {
    _input[index] = data.nextCodePin[_input[index].index];
  }

  void cycleInputPrev(int index) {
    _input[index] = data.prevCodePin[_input[index].index];
  }

  bool evaluateResult(List<data.PinColor> result) {
    return result.fold(0, (value, element) => value + element.index) == 8;
  }

  void addInputAsResult(List<data.PinColor> result) {
    _results.add(EntryInputResult(inputColors: List.from(_input), resultColors: result));
  }

  void clearControl() {
    _controlCode = List.generate(_pinCount, (index) => data.PinColor.none);
  }

  void clearInput() {
    _input = List.generate(_pinCount, (index) => data.PinColor.black);
  }

  void clearResults() {
    _results = [];
  }

  int get pinCount => _pinCount;

  data.PinColor getInputPinColor(int index) => _input[index];
  data.PinColor getControlPinColor(int index) => _controlCode[index];

  int getResultEntryCount() {
    return _results.length;
  }

  EntryInputResult getResultEntry(int index) {
    return _results[index];
  }
}
