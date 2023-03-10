import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mastermind/core/ui_controller.dart';

import "ui_data.dart";

class ScreenStart extends StatefulWidget {

  @override
  State<ScreenStart> createState() => _ScreenStartState();
}

class _ScreenStartState extends State<ScreenStart> with TickerProviderStateMixin {

  static const double animationMax = pi * 6;

  late AnimationController _animationController;
  late Animation<double> _animation;

  double _buttonOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 4)
    );
    _animationController.repeat();
    _animation = Tween<double>(begin: 0, end: animationMax).animate(_animationController);
    _animation.addListener(() {setState(() {});});
    _animationController.forward();

    Timer timer = Timer(const Duration(seconds: 3), () => {
      _buttonOpacity = 1.0
    });
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Matrix4 identity = Matrix4.identity()..setEntry(3, 2, 0.001);

    List<Widget> buttons = [];

    for(int i = 0; i < UiState.values.length; i++) {
      UiState state = UiState.values[i]!;
      if(state.hasHomeScreenButton) {
        Widget buttonWidget = GestureDetector(
          onTapDown: (details) {
            setState(() {
              UiController.setScreenState(context, state.state);
            });
          },
          child: AnimatedOpacity(
            duration: Duration(seconds: 2),
            opacity: _buttonOpacity,
            child: Container(
              margin: EdgeInsets.all(10),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/img/button.png"), fit: BoxFit.fill)
                  ),
                  child: Container(
                    width: 150,
                    height: 50,
                    child: Center(child: Text(state.homeScreenButtonText)),
                  )
              ),
            ),
          ),
        );
        buttons.add(buttonWidget);
      }
    }

    Column buttonColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttons,
    );

    return DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/img/sky.jpg"), fit: BoxFit.cover)
        ),
      child: Column(
        children: [
          Center(
            child: Transform(
              alignment: FractionalOffset.topCenter,
              transform: identity * Matrix4.rotationX(sin(_animation.value) * (animationMax - _animation.value) * 0.065),
              child: Stack(
                children: [
                  Image(
                    width: 200,
                    height: 200,
                    image: AssetImage("assets/img/sign.png"),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    left: 32,
                    top: 150,
                    child: Text("Mastermind",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: buttonColumn
          )
        ],
      )
    );
  }
}
