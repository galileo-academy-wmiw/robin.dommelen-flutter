import 'package:flutter/material.dart';

void main() => runApp(const AppRoot());

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: AppTree(),
    );
  }
}

class AppTree extends StatelessWidget {
  const AppTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("My App"),
          backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: ElevatedButton(
          child: Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page2())
            );},
        )
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text("Another Page"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: ElevatedButton(
            child: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
    );
  }
}

