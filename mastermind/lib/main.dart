import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import "screen_game.dart";
import "screen_start.dart";
import "screen_rules.dart";
import "screen_score.dart";

import "game_controller.dart";

void main() {
  GameController.newGame();

  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
            /*appBar: AppBar(
                title: const Text("Mastermind!")
            ),*/
            body: TabBarView(
              children: [
                ScreenStart(),
                ScreenGame(),
                ScreenScore(),
                ScreenRules(),
              ],
            ),
          bottomNavigationBar: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home",),
              Tab(icon: Icon(Icons.home), text: "Game",),
              Tab(icon: Icon(Icons.home), text: "Score",),
              Tab(icon: Icon(Icons.home), text: "Rules",),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTree extends StatefulWidget {

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {

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
    return Container(
      child: Text("Hello World!"),
    );
  }
}
