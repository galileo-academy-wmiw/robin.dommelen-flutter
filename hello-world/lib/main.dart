import 'dart:async';
import "library.dart" as lib;

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  int _ivalue = 0;
  
  @override
  void initState() {
    super.initState();
    //load("name").then((value) => _ivalue = value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: load("name"),
      builder: (context, snapshot) {
        _ivalue = snapshot.data ?? 0;
        if(snapshot.connectionState == ConnectionState.waiting) return Container(child: Text("Waiting..."),);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(_ivalue.toString()),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _ivalue++;
                    save("name", _ivalue);
                  });
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        );
      }
    );
  }

  Future<void> save(String name, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(name, value);
  }

  Future<int> load(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getInt(name);
    return val ?? 0;
  }
}
