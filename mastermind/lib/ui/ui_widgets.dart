import 'package:flutter/material.dart';
import 'package:mastermind/common/game_controller.dart';

import '../common/audio_controller.dart';

class WidgetCheckbox extends StatefulWidget {

  final double _size;
  final bool Function() _getStateFunction;
  final Function(bool) _stateChangedFunction;

  WidgetCheckbox(this._size, this._getStateFunction, this._stateChangedFunction);

  @override
  State<WidgetCheckbox> createState() => _WidgetCheckboxState();
}

class _WidgetCheckboxState extends State<WidgetCheckbox> {

  @override
  Widget build(BuildContext context) {

    bool isChecked = widget._getStateFunction();
    String assetName = isChecked ? "assets/img/checkbox_1.png" : "assets/img/checkbox_0.png";

    return GestureDetector(
      onTapUp: (details) => {
        setState(() => {
          widget._stateChangedFunction(!isChecked)
        }),
        AudioController.playButtonSound()
      },
      child: Image(
        image: AssetImage(assetName),
        width: widget._size,
        height: widget._size,
      ),
    );
  }
}

class WidgetSquareButton extends StatefulWidget {

  final IconData _buttonIcon;
  final double _buttonSize;
  final Function() _buttonPressFunc;

  WidgetSquareButton(this._buttonIcon, this._buttonSize, this._buttonPressFunc);

  @override
  State<WidgetSquareButton> createState() => _WidgetSquareButtonState();
}

class _WidgetSquareButtonState extends State<WidgetSquareButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (details) {
        widget._buttonPressFunc();
        AudioController.playButtonSound();
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/img/square_button.png"))
        ),
        child: Container(
          width: widget._buttonSize,
          height: widget._buttonSize,
          child: Center(
              child:
              Icon(widget._buttonIcon, size: 40.0,)
          ),
        ),
      ),
    );
  }
}
