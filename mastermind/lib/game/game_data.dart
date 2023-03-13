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

const List<PinColor> prevCodePin = [
  PinColor.black,  PinColor.yellow, PinColor.white, PinColor.black, PinColor.red, PinColor.blue,
  PinColor.green
];

const List<String> accessibilityImages = [
  "assets/img/shape_0.png", "assets/img/shape_1.png", "assets/img/shape_2.png", "assets/img/shape_3.png",
  "assets/img/shape_4.png", "assets/img/shape_5.png", "assets/img/shape_6.png",
];

const List<int> accessibilityColorCodes = [
  0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000
];

const List<double> accessibilitySizeModifier = [
  0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
];

// Index values of the results pin colors corresponding with the
// data.resultPinValues array
const int iResultColorCorrect = 2;
const int iResultColorPartialCorrect = 1;
const int iResultColorWrong = 0;

const List<PinColor> resultPinValues = [
  PinColor.none, PinColor.white, PinColor.black
];
