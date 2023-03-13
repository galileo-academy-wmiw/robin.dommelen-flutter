import 'package:flutter/material.dart';
import 'package:mastermind/common/game_controller.dart';
import 'package:mastermind/ui/ui_data.dart';
import 'package:mastermind/ui/ui_widgets.dart';
import '../common/ui_controller.dart';

class ScreenResult extends StatelessWidget {
  const ScreenResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> widgets = [];
    switch(GameController.getGameState()) {
      case GameState.playing: case GameState.uninitialized:
        widgets.add(Text("An unexpected error has occured!"));
        break;
      case GameState.gameOver:
        widgets.add(Text("Game over!", style: TextStyle(fontSize: 32),));
        widgets.add(Text("Would you like to try again?"));
        break;

      case GameState.success:
        widgets.add(Text("You won!", style: TextStyle(fontSize: 32),));
        widgets.add(Text("You took a total of ${GameController.getNumberOfResults()} turns"));
        widgets.add(Text("Would you like to go again?"));
        break;
    }

    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: WidgetSquareButton(Icons.check, 60, () => {
            GameController.newGame(),
            UiController.setScreenState(context, EnumUiState.gameScreen)
          }),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: WidgetSquareButton(Icons.close, 60, () => {
            UiController.setScreenState(context, EnumUiState.homeScreen)
          }),
        ),
      ],
    ));

    return Stack(
      children: [
        Positioned(
            top: MediaQuery.of(context).size.height - 70,
            left: MediaQuery.of(context).size.width - 70,
            child: WidgetSquareButton(Icons.check, 60, () => {
              UiController.setScreenState(context, EnumUiState.homeScreen)
            })
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets,
          ),
        )
      ],
    );
  }
}
