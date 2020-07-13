import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:pruebas/utils/responsive.dart';

class VideoPlayerIFC extends StatefulWidget {
  VideoPlayerIFC({Key key}) : super(key: key);

  @override
  _VideoPlayerIFCState createState() => _VideoPlayerIFCState();
}

class _VideoPlayerIFCState extends State<VideoPlayerIFC> {
  VideoPlayerController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/IFC.mp4')
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
