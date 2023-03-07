import 'dart:math';

enum PinColor { none, white, black, red, blue, green, yellow }

const List<String> _pinColorNames = [
  "none", "white", "black", "red", "blue", "green", "yellow",
];

const List<PinColor> _codePinValues = [
  PinColor.white, PinColor.black, PinColor.red, PinColor.blue, PinColor.green,
  PinColor.yellow
];

const List<PinColor> _nextCodePin = [
  PinColor.black, PinColor.red, PinColor.blue, PinColor.green, PinColor.yellow,
  PinColor.white
];

const List<PinColor> resultPinValues = [
  PinColor.none, PinColor.white, PinColor.black
];

abstract class PinBase {
  PinColor _color = PinColor.none;

  PinBase(PinColor color) {
    _color = color;
  }

  String get pinColorName {
    return _pinColorNames[_color.index];
  }

  set pinColor(PinColor color) {
    _color = color;
  }
}

class CodePin extends PinBase {

  CodePin(PinColor color) : super(color) {
    // Validate if code color is valid
    if (!codePinValues.contains(_color))
      throw Exception("Invalid code pin color!");
  }
}

class ResultPin extends PinBase {

  ResultPin(PinColor color) : super(color) {
    // Validate if result color is valid
    if (!resultPinValues.contains(_color))
      throw Exception("Invalid result pin color!");
  }
}

class InputResult {

}

class GameInstance {
  late List<PinColor> _controlCode;
  late List<InputResult> _results;
  late List<PinColor> _input;

  GameInstance() {
    _controlCode = _createNewCode(4);
    _input = List.generate(4, (index) => PinColor.none);
  }

  List<PinColor> _createNewCode(int size) {
    List<PinColor> result = List.generate(size, (index) => PinColor.none);
    List<PinColor> possibilities = List.from(_codePinValues);

    if(result.length > possibilities.length) throw Error();

    for (int i = 0; i < result.length; i++) {
      int curPin = Random().nextInt(possibilities.length);
      result[i] = possibilities[curPin];
      possibilities.removeAt(curPin);
    }

    return result;
  }

  List<int> _compareCode(List<int> controlCode, List<int> userCode) {
    List<int> result = [0, 0, 0, 0];

    for (int i = 0; i < controlCode.length; i++) {
      int target = controlCode[i];

      for (int j = 0; j < userCode.length; j++) {
        if (target == userCode[j]) {
          if (i == j) {
            result[i] = 2;
          } else {
            result[i] = 1;
          }
        }
      }
    }

    result.sort((a, b) => (a > b ? -1 : 1));
    return result;
  }
}

class GameController {

  static void newGame() {

  }

}
