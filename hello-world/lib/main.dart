import 'dart:math';

import 'package:flutter/cupertino.dart';

class HomeWidget extends StatelessWidget {

  // Constructor
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class HomeStatelessWidget extends StatefulWidget {
  const HomeStatelessWidget({super.key});

  @override
  State<HomeStatelessWidget> createState() => _HomeStatelessWidgetState();
}

class _HomeStatelessWidgetState extends State<HomeStatelessWidget> {

  Color containerColor = const Color.fromARGB(255, 250, 200, 50);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeContainerColor() {
    setState(() {
      Random rand = Random();
      containerColor = Color.fromARGB(255, rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeContainerColor,

      child: Container (
        color: containerColor,
      ),
    );
  }
}

void main() => runApp(const HomeStatelessWidget());