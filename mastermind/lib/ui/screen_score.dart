import 'package:flutter/material.dart';
import 'package:mastermind/common/game_controller.dart';

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

    double totalWidth = MediaQuery.of(context).size.width;

    FutureBuilder<IScoreData> scoreTable = FutureBuilder<IScoreData>(
      future: GameController.getScoreData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("retrieving score values...");
          }
          else {
            List<Widget> scores = [];
            IScoreData data = snapshot.data ?? ScoreData();
            scores.add(Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: totalWidth * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Turns", style: TextStyle(fontSize: 20),),
                    Text("Successes", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ));
            data.getScoreData().forEach((key, value) { 
              scores.add(
                  Container(
                    width: totalWidth * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("$key"),
                        Text("$value")
                      ]
                    ),
                  )
                );
            });
            
            return Center(
              child: Column(
                children: scores
              ),
            );
          }
      }
    );

    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              Text("Scores", style: TextStyle(fontSize: 32),),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      scoreTable
                    ],
                  )
              )
            ],
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height - 70,
            left: MediaQuery.of(context).size.width - 70,
            child: WidgetSquareButton(Icons.check, 60, () => {
              UiController.setScreenState(context, EnumUiState.homeScreen)
            })
        ),
        Positioned(
            top: MediaQuery.of(context).size.height - 70,
            left: 10,
            child: WidgetSquareButton(Icons.refresh, 60, () => {
              setState(() {
                GameController.resetScore();
              })
            })
        ),
      ],
    );
  }
}
