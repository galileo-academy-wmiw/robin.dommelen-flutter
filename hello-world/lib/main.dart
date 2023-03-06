import 'package:flutter/material.dart';

void main() => runApp(const AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(title: const Text("Hello World App!")),
          body: TabBarView(
            children: [
              ScreenRed(), ScreenGreen(), ScreenBlue()
            ],
          ),
          bottomNavigationBar: TabBar(
            labelColor: Colors.black,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Red",),
              Tab(icon: Icon(Icons.abc), text: "Green"),
              Tab(icon: Icon(Icons.access_alarm), text: "Blue")
            ]
          ),
        ),
      ),
    );
  }

}

class ScreenRed extends StatelessWidget {
  const ScreenRed({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red,);
  }

}

class ScreenBlue extends StatelessWidget {
  const ScreenBlue({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue,);
  }

}

class ScreenGreen extends StatelessWidget {
  const ScreenGreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green,);
  }

}
