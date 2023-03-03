import 'dart:math';

enum PinColor { none, white, black, red, blue, green, yellow }

const List<String> _pinColorNames = [
  "none", "black", "white", "red", "blue", "green", "yellow",
];

const List<PinColor> codePinValues = [
  PinColor.white, PinColor.black, PinColor.red, PinColor.blue, PinColor.green, PinColor.yellow
];

const List<PinColor> resultPinValues = [
  PinColor.none, PinColor.white, PinColor.black
];

abstract class PinBase {
  PinColor _color = PinColor.none;

  PinBase(int color) {
    _color = PinColor.values[color];
  }

  String get pinColorName {
    return _pinColorNames[_color.index];
  }
}

class CodePin extends PinBase {

  CodePin(int color) : super(color) {
    // Validate if code color is valid
    if (!codePinValues.contains(_color))
      throw Exception("Invalid code pin color!");
  }
}

class ResultPin extends PinBase {

  ResultPin(int color) : super(color) {
    // Validate if result color is valid
    if (!resultPinValues.contains(_color))
      throw Exception("Invalid result pin color!");
  }
}

void createNewCode(List<int> container) {
  List<int> possibilities = [1, 2, 3, 4, 5, 6];
  for (int i = 0; i < container.length; i++) {
    int curPin = Random().nextInt(possibilities.length);
    container[i] = possibilities[curPin];
    possibilities.removeAt(curPin);
  }
}

List<int> compareCode(List<int> controlCode, List<int> userCode) {
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

void main() {
  List<int> secretCode = [0, 0, 0, 0];
  createNewCode(secretCode);
  print(secretCode);
  print(compareCode(secretCode, [1, 2, 3, 4]));
}
