import 'package:flutter/material.dart';

import '../common/ui_controller.dart';
import 'ui_data.dart';
import 'ui_widgets.dart';

class ScreenRules extends StatelessWidget {

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
