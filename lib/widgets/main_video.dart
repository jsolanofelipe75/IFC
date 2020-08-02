import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:flutter/material.dart';
import 'package:pruebas/keys/keys.dart';
import 'package:pruebas/utils/responsive.dart';
import 'package:video_player/video_player.dart';

class MainVideo extends StatefulWidget {

  @override
  _MainVideoState createState() => _MainVideoState();
}

class _MainVideoState extends State<MainVideo> {

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://www.youtube.com/watch?v=iAlaILBMsN8&list=PLa5DZi2Rvd4cganL90-2tbI6kjGCX4cjN&index=8')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      body: Center(
        child: _controller.value.initialized
            ? Container(
          height: responsive.ip(30.0),
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
