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

class _AppTreeState extends State<AppTree> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RouteMap(Icons.directions_walk, "A-B"),
        RouteMap(Icons.directions_bike, "A-C"),
      ],
    );
  }
}

class RouteMap extends StatelessWidget {
  final IconData _icon;
  final String _text;

  RouteMap(this._icon, this._text);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this._text),
      background: Container(color: Colors.red),
      child: Card(
          child: Column(
              children: [
                ListTile(
                  leading: Icon(_icon),
                  title: Text(_text),
                ),
                ButtonBar(
                  children: [
                    TextButton(
                      child: Text("Bekijk route"),
                      onPressed: () {},
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text("Hoogtepunten")
                    )
                  ],
                )
              ]
          )
      ),
    );
  }
}

