import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

const TextStyle blueText = TextStyle(
  color: Colors.blue,
  fontFamily: "TiltWarp",
  letterSpacing: 1.2,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

const List<DropdownMenuItem<int>> listOptions = [
  DropdownMenuItem(child: Text("Large"), value: 200,),
  DropdownMenuItem(child: Text("Medium"), value: 100,),
  DropdownMenuItem(child: Text("Small"), value: 50,),
];

final AudioPlayer audioPlayer = AudioPlayer();

void main() => runApp(const AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Text("Hello World App!")), body: Center(child: AppTree())),
    );
  }
}

class AppTree extends StatefulWidget {

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {

  double _size = 100;
  int? _dropdownValue = 100;
  bool show = true;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Checkbox(
            value: show,
            onChanged: (value) {
              print(show);
              setState(() {
                show = !show;
              });
            }
        ),
        Switch(
            value: show,
            onChanged: (value) {
              print(show);
              setState(() {
                show = !show;
              });
            }
        ),
        Radio(
          value: false,
          groupValue: show,
          onChanged: (value) {
            setState(() {
              show = false;
            });
          },
        ),
        Radio(
          value: true,
          groupValue: show,
          onChanged: (value) {
            setState(() {
              show = true;
            });
          },
        ),
        Slider.adaptive(
            value: _size,
            min: 50,
            max: 200,
            onChanged: (value) {
              setState(() {
                _size = value;
              });
            },
          ),
        DropdownButton(
            items: listOptions,
            value: _dropdownValue,
            onChanged: (value) {
              setState(() {
                _size = value!.toDouble();
                _dropdownValue = value;
              });
            }
        ),
        Visibility(visible: show,
            child: FlutterLogo(size: _size)
        ),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.red,
            border: InputBorder.none,
            hintText: "Text input please"
          ),
          onChanged: (text) {
            print("Text: $text");
          },
        )
      ],
    );
  }
}
