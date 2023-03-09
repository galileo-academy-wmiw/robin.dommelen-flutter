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
    return true;
  }

}

class WidgetResultPin extends StatefulWidget {

  final double _pinSize;
  final int _resultIndex;
  final int _resultPinIndex;

  WidgetResultPin(this._pinSize, this._resultIndex, this._resultPinIndex);

  @override
  State<WidgetResultPin> createState() => _WidgetResultPinState();
}

class _WidgetResultPinState extends State<WidgetResultPin> {

  @override
  Widget build(BuildContext context) {

    int color = GameController.getColorCodeForResultPin(widget._resultIndex,
        widget._resultPinIndex);

    return SizedBox(
      width: widget._pinSize,
      height: widget._pinSize,
      child: CustomPaint(
        painter: CodePinPainter(color),
        size: Size(widget._pinSize, widget._pinSize),
      )
    );
  }
}


class WidgetResultCodePin extends StatefulWidget {

  final int _resultIndex;
  final int _pinIndex;

  WidgetResultCodePin(this._resultIndex, this._pinIndex);

  @override
  State<WidgetResultCodePin> createState() => _WidgetResultCodePinState();
}

class _WidgetResultCodePinState extends State<WidgetResultCodePin> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;
    int colorCode = GameController.getColorCodeForResultCodePin(
        widget._resultIndex, widget._pinIndex);

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


// ----- Game Widgets -----

class WidgetResultRow extends StatefulWidget {

  final int _resultIndex;

  WidgetResultRow(this._resultIndex);

  @override
  State<WidgetResultRow> createState() => _WidgetResultRowState();
}

class _WidgetResultRowState extends State<WidgetResultRow> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;

    return Row(
      children: [
        for(int i = 0; i < GameController.getNumberOfPins(); i++)
          WidgetResultCodePin(widget._resultIndex, i),
        Column(
          children: [
            Row(
              children: [
                WidgetResultPin(effectiveWidth * 0.5, widget._resultIndex, 0),
                WidgetResultPin(effectiveWidth * 0.5, widget._resultIndex, 1),
              ],
            ),
            Row(
              children: [
                WidgetResultPin(effectiveWidth * 0.5, widget._resultIndex, 2),
                WidgetResultPin(effectiveWidth * 0.5, widget._resultIndex, 3),
              ]
            )
          ],
        )
      ],
    );
  }
}


class WidgetControlCodePin extends StatefulWidget {

  final int _pinIndex;

  WidgetControlCodePin(this._pinIndex);

  @override
  State<WidgetControlCodePin> createState() => _WidgetControlCodePinState();
}

class _WidgetControlCodePinState extends State<WidgetControlCodePin> {

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;
    int colorCode = GameController.getColorCodeForControlPin(widget._pinIndex);

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
