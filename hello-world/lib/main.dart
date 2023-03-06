import 'package:flutter/material.dart';

void main() => runApp(const AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Hello World App!")),
        body: Center(child: AppTree())
      ),
    );
  }

}

class AppTree extends StatelessWidget {
  const AppTree({super.key});


  @override
  Widget build(BuildContext context) {
    return Text("Content");
  }

}
