import 'dart:math';

import 'package:flutter/material.dart';

class ScreenStart extends StatefulWidget {

  @override
  State<ScreenStart> createState() => _ScreenStartState();
}

class _ScreenStartState extends State<ScreenStart> with TickerProviderStateMixin {

  static const double animationMax = pi * 8;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late Matrix4 _perspectiveMatrix;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 8)
    );
    _animationController.repeat();
    _animation = Tween<double>(begin: 0, end: animationMax).animate(_animationController);
    _animation.addListener(() {setState(() {});});
    _animationController.forward();

    double fov = 65.0;
    double aspectRatio = 1;
    double nearClip = 0.1;
    double farClip = 1000.0;

    double tanHalfFov = tan(fov * 0.5 * pi / 180.0);
    double range = nearClip - farClip;

    _perspectiveMatrix = Matrix4.identity();
    _perspectiveMatrix.row0[0] = 1.0 / (tanHalfFov * aspectRatio);
    _perspectiveMatrix.row1[1] = 1.0 / tanHalfFov;
    _perspectiveMatrix.row2[2] = -(farClip + nearClip) / range;
    _perspectiveMatrix.row2[3] = -1.0;
    _perspectiveMatrix.row3[2] = -(2.0 * farClip * nearClip) / range;
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Matrix4 identity = Matrix4.identity();


    return DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/img/sky.jpg"), fit: BoxFit.cover)
        ),
      child: Container(
        child: Column(
          children: [
            Center(
              child: Transform(
                transform: _perspectiveMatrix * Matrix4.rotationX(sin(_animation.value) * (animationMax - _animation.value) * 0.085),
                child: Image(
                  width: 200,
                  height: 200,
                  image: AssetImage("assets/img/wood.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
