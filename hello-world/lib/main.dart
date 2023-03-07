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

class AppTree extends StatefulWidget {

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {

  double _size = 100;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: () {
          setState(() {
            _size += 10;
          });
        }, child: Icon(Icons.add_circle_outline, size: 50)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          width: _size,
          height: _size,
          color: Colors.teal,
        ),
        ElevatedButton(onPressed: () {
          setState(() {
            _size -= 10;
          });
        }, child: Icon(Icons.remove_circle_outline, size: 50)),
      ],
    );
  }
}
