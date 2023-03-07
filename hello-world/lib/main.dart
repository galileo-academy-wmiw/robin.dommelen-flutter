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

class PainterTest extends CustomPainter {

  final double _startAngle;

  PainterTest(this._startAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();

    var center = Offset(size.width / 2, size.height / 2);

    final Paint paint = Paint();

    paint.color = Colors.blue;
    canvas.drawArc(rect, _startAngle, 0.14, true, paint);

    //paint.color = Colors.yellow;
    //canvas.drawPath(path, paint);

    //paint.color = Colors.red;
    //canvas.drawCircle(center, 200, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}

class AppTree extends StatefulWidget {

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> with SingleTickerProviderStateMixin {

  Color v_color = Colors.yellow;
  double v_width = 200;
  double v_height = 100;

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween(begin: 0.0, end: 6.28).animate(_animationController);
    _animation.addListener(() { setState(() {}); });

    _animationController.forward();
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed) _animationController.repeat();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      painter: PainterTest(_animation.value),
      size: MediaQuery.of(context).size,
    );
  }
}
