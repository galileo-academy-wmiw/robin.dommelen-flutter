import 'dart:math';

import 'package:flutter/material.dart';

import 'game_controller.dart';

// ---- Game Painter -----
class CodePinPainter extends CustomPainter {

  final int pinColorCode;

  CodePinPainter(this.pinColorCode);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Offset center = Offset(size.width * 0.5, size.height * 0.5);

    paint.color = Colors.black;
    canvas.drawCircle(center, size.width * 0.5 - 5, paint);

    int red = ((pinColorCode & 0xFF0000)) >> 16;
    int green = ((pinColorCode & 0x00FF00)) >> 8;
    int blue = ((pinColorCode & 0x0000FF));

    paint.color = Color.fromRGBO(red, green, blue, 1.0);
    canvas.drawCircle(center, size.width * 0.5 - 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as CodePinPainter).pinColorCode != pinColorCode;
  }

}

// ----- Game Widgets -----

class WidgetResultPin extends StatelessWidget {

  final double _pinSize;
  final int _resultIndex;
  final int _resultPinIndex;

  WidgetResultPin(this._pinSize, this._resultIndex, this._resultPinIndex);

  @override
  Widget build(BuildContext context) {

    int color = GameController.getColorCodeForResultPin(_resultIndex,
        _resultPinIndex);

    return SizedBox(
      width: _pinSize,
      height: _pinSize,
      child: CustomPaint(
        painter: CodePinPainter(color),
        size: Size(_pinSize, _pinSize),
      )
    );
  }
}

class WidgetResultCodePin extends StatelessWidget {

  final int _resultIndex;
  final int _pinIndex;

  WidgetResultCodePin(this._resultIndex, this._pinIndex);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;
    int colorCode = GameController.getColorCodeForResultCodePin(
        _resultIndex, _pinIndex);

    return SizedBox(
      width: effectiveWidth,
      height: effectiveWidth,
      child: CustomPaint(
        painter: CodePinPainter(colorCode),
        size: Size(effectiveWidth, effectiveWidth),
      ),
    );
  }
}

class WidgetResultRow extends StatelessWidget {

  final int _resultIndex;

  WidgetResultRow(this._resultIndex);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;

    return Row(
      children: [
        for(int i = 0; i < GameController.getNumberOfPins(); i++)
          WidgetResultCodePin(_resultIndex, i),
        Column(
          children: [
            Row(
              children: [
                WidgetResultPin(effectiveWidth * 0.5, _resultIndex, 0),
                WidgetResultPin(effectiveWidth * 0.5, _resultIndex, 1),
              ],
            ),
            Row(
              children: [
                WidgetResultPin(effectiveWidth * 0.5, _resultIndex, 2),
                WidgetResultPin(effectiveWidth * 0.5, _resultIndex, 3),
              ]
            )
          ],
        )
      ],
    );
  }
}

class WidgetControlCodePin extends StatelessWidget {

  final int _pinIndex;

  WidgetControlCodePin(this._pinIndex);

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;
    int colorCode = GameController.getColorCodeForControlPin(_pinIndex);

    return SizedBox(
      width: effectiveWidth,
      height: effectiveWidth,
      child: CustomPaint(
        painter: CodePinPainter(colorCode),
        size: Size(effectiveWidth, effectiveWidth),
      ),
    );
  }
}

class WidgetInputCodePin extends StatefulWidget {

  final int _pinIndex;

  WidgetInputCodePin(this._pinIndex);

  @override
  State<WidgetInputCodePin> createState() => _WidgetInputCodePinState();
}

class _WidgetInputCodePinState extends State<WidgetInputCodePin> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;
    int colorCode = GameController.getColorCodeForInputPin(widget._pinIndex);

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              GameController.cycleInput(widget._pinIndex);
            });
          },
          child: CustomPaint(
            painter: CodePinPainter(colorCode),
            size: Size(effectiveWidth, effectiveWidth),
          ),
        )
      ],
    );
  }
}

// ---- Game Screen -----

class ScreenGame extends StatefulWidget {

  @override
  State<ScreenGame> createState() => _ScreenGameState();
}

class _ScreenGameState extends State<ScreenGame> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          //Control code row
          Row(
            children: [
              for(int i = 0; i < GameController.getNumberOfPins(); i++)
                WidgetControlCodePin(i),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    GameController.newGame();
                  });
                },
                child: Icon(Icons.refresh),
              ),
            ],
          ),

          // Results row
          Expanded(
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    for(int i = 0; i < GameController.getNumberOfResults(); i++)
                      WidgetResultRow(i),
                  ],
                )
              ],
            )
          ),

          // Input row
          Row(
            children: [
              for(int i = 0; i < GameController.getNumberOfPins(); i++)
                WidgetInputCodePin(i),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    GameController.submitInput();
                  });
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
    );
  }
}
