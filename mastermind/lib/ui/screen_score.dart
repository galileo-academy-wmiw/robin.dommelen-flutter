import 'package:flutter/material.dart';

import '../common/ui_controller.dart';
import 'ui_data.dart';
import 'ui_widgets.dart';

class ScreenScore extends StatefulWidget {

  @override
  State<ScreenScore> createState() => _ScreenScoreState();
}

class _ScreenScoreState extends State<ScreenScore> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: MediaQuery.of(context).size.height - 70,
            left: MediaQuery.of(context).size.width - 70,
            child: WidgetSquareButton(Icons.check, 60, () => {
              UiController.setScreenState(context, EnumUiState.homeScreen)
            })
        ),
      ],
    );
  }
}
