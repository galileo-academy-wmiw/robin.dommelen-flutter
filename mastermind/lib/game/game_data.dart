enum PinColor { none, white, black, red, blue, green, yellow }

const List<int> pinColorCodes = [
  0x888888, 0xFFFFFF, 0x222222, 0xFF0000, 0x0000FF, 0x00FF00, 0xFFFF00
];

const List<String> pinColorNames = [
  "none", "white", "black", "red", "blue", "green", "yellow",
];

const List<PinColor> codePinValues = [
  PinColor.white, PinColor.black, PinColor.red, PinColor.blue, PinColor.green,
  PinColor.yellow
];

const List<PinColor> nextCodePin = [
  PinColor.black,  PinColor.black, PinColor.red, PinColor.blue, PinColor.green, PinColor.yellow,
  PinColor.white
];

const List<PinColor> resultPinValues = [
  PinColor.none, PinColor.white, PinColor.black
];

/*
abstract class PinBase {
  PinColor _color = PinColor.none;

  PinBase(PinColor color) {
    _color = color;
  }

  String get pinColorName {
    return pinColorNames[_color.index];
  }

  set pinColor(PinColor color) {
    _color = color;
  }
}

class CodePin extends PinBase {

  CodePin(PinColor color) : super(color) {
    // Validate if code color is valid
    if (!_codePinValues.contains(_color))
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
*/
