import 'package:flutter/material.dart';

import 'game_controller.dart';

// ----- Game Widgets -----

class WidgetInputCodePin extends StatefulWidget {

  final int _pinIndex;

  WidgetInputCodePin(this._pinIndex);

  @override
  State<WidgetInputCodePin> createState() => _WidgetInputCodePinState();
}

class _WidgetInputCodePinState extends State<WidgetInputCodePin> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
    return const Placeholder();
  }
}
