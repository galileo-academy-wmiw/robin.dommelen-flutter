import 'package:flutter/material.dart';
import 'package:mastermind/common/audio_controller.dart';
import 'package:mastermind/common/game_controller.dart';

import '../common/ui_controller.dart';
import 'ui_data.dart';
import 'ui_widgets.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({Key? key}) : super(key: key);

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {

  @override
  void initState() {
    super.initState();
  }

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
        Container(
          margin: EdgeInsets.all(40),
          child: Column(
            children: [
              Center(
                child: Text("Settings", style: TextStyle(fontSize: 24),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Music Volume"),
                  Slider(
                      value: AudioController.getMusicVolume(),
                      onChanged: (newValue) => {
                        setState(() {
                          AudioController.setMusicVolume(newValue);
                        })
                      }
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("SFX Volume"),
                  Slider(
                      value: AudioController.getSfxVolume(),
                      onChanged: (newValue) => {
                        setState(() {
                          AudioController.setSfxVolume(newValue);
                        })
                      }
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Max Turns"),
                  Row(
                    children: [
                      WidgetSquareButton(Icons.arrow_left, 40, () => {
                        setState(() => {
                          GameController.addMaxTurns(-1)
                        })
                      }),
                      Container(
                        width: 100,
                        child: Center(
                          child: Text(GameController.getMaxTurns().toString()),
                        ),
                      ),
                      WidgetSquareButton(Icons.arrow_right, 40, () => {
                        setState(() => {
                          GameController.addMaxTurns(1)
                        })
                      }),
                    ],
                  )
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Accessibility mode"),
                  WidgetCheckbox(40, GameController.isAccessibilityMode, (checked) => {
                    GameController.setAccessibility(checked)
                  })
                ],
              )
            ],
          )
        ),
      ],
    );
  }
}
