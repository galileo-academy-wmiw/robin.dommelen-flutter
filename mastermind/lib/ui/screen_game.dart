import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mastermind/common/audio_controller.dart';
import 'package:mastermind/common/ui_controller.dart';
import 'package:mastermind/ui/ui_data.dart';

import '../game/game_data.dart' as game_data;

import '../common/game_controller.dart';
import 'ui_widgets.dart';

// ---- Utility Functions -----
Color colorFromRGBCode(int colorCode, double opacity) {
  int red = ((colorCode & 0xFF0000)) >> 16;
  int green = ((colorCode & 0x00FF00)) >> 8;
  int blue = ((colorCode & 0x0000FF));
  return Color.fromRGBO(red, green, blue, 1.0);
}

// ---- Game Painter -----
class CodePinPainter extends CustomPainter {

  final int pinColorCode;

  final double borderSize;
  final double paddingSize;

  CodePinPainter(this.pinColorCode, {double border = 5, double padding = 5}) :
        borderSize = border,
        paddingSize = padding
  ;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Offset center = Offset(size.width * 0.5, size.height * 0.5);

    paint.color = Colors.black;
    canvas.drawCircle(center, size.width * 0.5 - paddingSize, paint);

    paint.color = colorFromRGBCode(pinColorCode, 1.0);
    canvas.drawCircle(center, size.width * 0.5 - borderSize - paddingSize, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return (oldDelegate as CodePinPainter).pinColorCode != pinColorCode;
  }
}

// ----- Game Widgets -----

class WidgetCodePin extends StatelessWidget {

  final double _pinSize;
  final game_data.PinColor _pinColor;
  final bool _drawAccessibility;

  WidgetCodePin(this._pinSize, this._pinColor, { bool drawAccessibility = true }) :
    _drawAccessibility = drawAccessibility
  ;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    widgets.add(
      CustomPaint(
        painter: CodePinPainter(game_data.pinColorCodes[_pinColor.index]),
        size: Size(_pinSize, _pinSize),
      ),
    );

    if(GameController.isAccessibilityMode() && _drawAccessibility) {
      widgets.add(
          Center(
            child: Image(
              image: AssetImage(game_data.accessibilityImages[_pinColor.index]),
              color: colorFromRGBCode(game_data.accessibilityColorCodes[_pinColor.index], 1.0),
              width: _pinSize * game_data.accessibilitySizeModifier[_pinColor.index],
              height: _pinSize * game_data.accessibilitySizeModifier[_pinColor.index],
            ),
          )
      );
    }

    return SizedBox(
      width: _pinSize,
      height: _pinSize,
      child: Stack(
          children: widgets
      ),
    );
  }
}

class WidgetControlRow extends StatefulWidget {

  final double _pinSize;

  WidgetControlRow(this._pinSize);

  @override
  State<WidgetControlRow> createState() => _WidgetControlRowState();
}

class _WidgetControlRowState extends State<WidgetControlRow> with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4)
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(_fadeController);
    _fadeAnimation.addListener(() {
      setState(() { });
      if(_fadeAnimation.isCompleted) {
        UiController.setScreenState(context, EnumUiState.resultScreen);
      }
    });

    GameController.setStartRevealFunc(() => {
      _fadeController.forward(),
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for(int i = 0; i < GameController.getNumberOfPins(); i++)
              WidgetCodePin(widget._pinSize, GameController.getControlPinColor(i, true), drawAccessibility: false,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for(int i = 0; i < GameController.getNumberOfPins(); i++)
              Opacity(
                opacity: clampDouble(_fadeAnimation.value - i, 0.0, 1.0),
                child: WidgetCodePin(widget._pinSize, GameController.getControlPinColor(i, false), drawAccessibility: true,),
              )
          ],
        ),
      ],
    );
  }
}


class WidgetResultRow extends StatefulWidget {

  final int _resultIndex;

  WidgetResultRow(this._resultIndex);

  @override
  State<WidgetResultRow> createState() => _WidgetResultRowState();
}

class _WidgetResultRowState extends State<WidgetResultRow> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animation.addListener(() {
      setState(() {

      });
    });
    _animationController.forward();
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;

    return Opacity(
      opacity: _animation.value,
      child: Row(
        children: [
          for(int i = 0; i < GameController.getNumberOfPins(); i++)
            WidgetCodePin(effectiveWidth, GameController.getEntryInputPinColor(widget._resultIndex, i)),
          Column(
            children: [
              Row(
                children: [
                  WidgetCodePin(effectiveWidth * 0.5, GameController.getEntryResultPinColor(widget._resultIndex, 0)),
                  WidgetCodePin(effectiveWidth * 0.5, GameController.getEntryResultPinColor(widget._resultIndex, 1)),
                ],
              ),
              Row(
                children: [
                  WidgetCodePin(effectiveWidth * 0.5, GameController.getEntryResultPinColor(widget._resultIndex, 2)),
                  WidgetCodePin(effectiveWidth * 0.5, GameController.getEntryResultPinColor(widget._resultIndex, 3)),
                ]
              )
            ],
          )
        ],
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

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (GameController.isGameInProgress()) {
              setState(() {
                GameController.cycleInputNext(widget._pinIndex);
                AudioController.playButtonSound();
              });
            }
          },
          onDoubleTap: () {
            setState(() {
              if (GameController.isGameInProgress()) {
                GameController.cycleInputPrev(widget._pinIndex);
                AudioController.playButtonPitchedSound();
              }
            });
          },
          child: WidgetCodePin(effectiveWidth, GameController.getInputPinColor(widget._pinIndex)
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

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double effectiveWidth = screenWidth * 0.2;

    String titleString = "Turn: ${GameController.getNumberOfResults() + (GameController.isGameInProgress() ? 1 : 0)}";
    if(GameController.getMaxTurns() != 0) {
      titleString += " / ${GameController.getMaxTurns()}";
    }

    return Column(
        children: [
          //Control code row
          DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/img/wood.jpg"), fit: BoxFit.cover)
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetSquareButton(Icons.arrow_back, 60, () => {
                      if (GameController.isGameInProgress()) {
                        setState(() {
                          UiController.setScreenState(context, EnumUiState.homeScreen);
                        })
                      }
                    }),
                    Text(titleString, style: const TextStyle(fontSize: 24),),
                    WidgetSquareButton(Icons.refresh, 60, () => {
                      if (GameController.isGameInProgress()) {
                        setState(() {
                          GameController.newGame();
                        })
                      }
                    }),
                  ],
                ),
                WidgetControlRow(effectiveWidth),
              ],
            ),
          ),

          Image(
            image: const AssetImage("assets/img/border_wood.png"),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: 10,
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

          Image(
            image: const AssetImage("assets/img/border_wood.png"),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: 10,
          ),

          // Input row
          DecoratedBox(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/img/wood.jpg"), fit: BoxFit.cover)
            ),
            child: Row(
              children: [
                for(int i = 0; i < GameController.getNumberOfPins(); i++)
                  WidgetInputCodePin(i),
                GestureDetector(
                  onTap: () {
                    if (GameController.isGameInProgress()) {
                      setState(() {
                        GameController.submitInput();
                      });
                    }
                  },
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage("assets/img/square_button.png"))
                    ),
                    child: Container(
                      width: effectiveWidth,
                      height: effectiveWidth,
                      child: const Center(
                          child:
                          Icon(Icons.add, size: 40.0,)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
