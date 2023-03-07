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

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );

    _animation = Tween<double>(begin: 0, end: 6).animate(_animationController);
    _animation.addListener(() {
      setState(() {});
    });

    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed)
        _animationController.reverse();
      else if(status == AnimationStatus.dismissed)
        _animationController.forward();
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Color v_color = Colors.yellow;
  double v_width = 200;
  double v_height = 100;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if(v_width == 200) {
              v_color = Colors.amber;
              v_width = 100;
              v_height = 200;
            }
            else {
              v_color = Colors.yellow;
              v_width = 200;
              v_height = 100;
            }

          });
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 1),
          width: v_width,
          height: v_height,
          color: v_color,
        ),
      )
    );
  }
}
