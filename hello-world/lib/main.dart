import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';

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

class _AppTreeState extends State<AppTree> {
  final VideoPlayerController vpc = VideoPlayerController.asset("assets/video.mp4");

  @override
  void initState() {
    super.initState();
    vpc.initialize();
    vpc.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(aspectRatio: 1280 / 720, child: VideoPlayer(vpc)),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if(vpc.value.isPlaying) {
                  vpc.pause();
                }
                else {
                  vpc.play();
                }
              });
            },
            child: vpc.value.isPlaying ? Text("pause") : Text("play")),
      ],
    );
  }
}
