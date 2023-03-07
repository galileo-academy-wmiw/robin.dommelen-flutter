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

class AppTree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.red,
          padding: const EdgeInsets.all(8.0),
          child: Text("Hello world!", style: blueText, textScaleFactor: 1.5,),
        ),
        Container(
          child: RichText(
            textScaleFactor: 2,
            text: TextSpan(
              text: "green",
              style: TextStyle(color: Colors.green),
              children: <TextSpan>[
                TextSpan(text: "blue", style: TextStyle(color: Colors.blue)),
                TextSpan(text: "red", style: TextStyle(color: Colors.red))
            ]
            ),
          )
        ),
      ],
    );
  }
}
