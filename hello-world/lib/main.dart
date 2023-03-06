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
    return ListView(
      children: [
        Container(
          height: 2500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: 100, height: 100,
                  ),
                  Positioned(
                    left: 25,
                    top: 40,
                    child: Container(
                      color: Colors.white.withOpacity(0.5),
                      width: 50, height: 20,
                    ),
                  )
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text("1")
                      )
                  )
              ),
              Expanded(
                  child:
                  Container(
                    color: Colors.green,
                    child: Center(
                        child: Text("2")
                    ),
                  )
              ),
              Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            color: Colors.blue,
                            child: Center(
                                child: Text("3")
                            )
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: Colors.purple,
                            child: Center(
                                child: Text("4")
                            )
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }

}
