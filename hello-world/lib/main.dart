import 'dart:async';
import "library.dart" as lib;

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

const List<DropdownMenuItem<int>> listOptions = [
  DropdownMenuItem(child: Text("Large"), value: 200,),
  DropdownMenuItem(child: Text("Medium"), value: 100,),
  DropdownMenuItem(child: Text("Small"), value: 50,),
];

final AudioPlayer audioPlayer = AudioPlayer();

void main() => runApp(MyInherited(child: const AppRoot()));

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    lib.textStream.add("This is the first text!");
    Timer(Duration(seconds: 2), () {
      lib.textStream.add("This is the second text!");
    });

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

class _AppTreeState extends State<AppTree> with SingleTickerProviderStateMixin {

  String _textOnScreen = "";

  @override
  void initState() {
    super.initState();

    lib.textStream.stream.listen((text) {
      setState(() {
        _textOnScreen = text;
      });
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        MyInherited.of(context).blueText = TextStyle(
          color: Colors.red,
          fontSize: 40
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text("Hello World", style: MyInherited.of(context).blueText),
        ),
        Container(
          child: Text(_textOnScreen, style: lib.testStyle),
        ),
      ],
    );
  }
}

class MyInherited extends InheritedWidget {
  MyInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static MyInherited of(BuildContext context) {
    final MyInherited? result = context.dependOnInheritedWidgetOfExactType<MyInherited>();
    assert(result != null, 'No MyInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInherited old) {
    return true;
  }

  TextStyle blueText = TextStyle(
    color: Colors.blue,
    fontFamily: "TiltWarp",
    letterSpacing: 1.2,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

}
