import 'package:flutter/material.dart';

import 'package:flutter_radio/flutter_radio.dart';

class RadioStream extends StatefulWidget {
  RadioStream({Key key}) : super(key: key);

  @override
  _RadioStreamState createState() => _RadioStreamState();
}

class _RadioStreamState extends State<RadioStream> {
  static const streamUrl = "https://estructuraweb.com.co:9138/live";

  bool isPlaying;

  @override
  void initState() {
    super.initState();
    audioStart();
    playingStatus();
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Audio Plugin Android'),
      ),
      body: new Center(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.play_circle_filled),
              onPressed: () {
                FlutterRadio.play(url: streamUrl);
                setState(() {
                  playingStatus();
                });
              },
            ),
            FlatButton(
              child: Icon(Icons.pause_circle_filled),
              onPressed: () {
                FlutterRadio.pause(url: streamUrl);
                setState(() {
                  playingStatus();
                });
              },
            ),
            FlatButton(
              child: Icon(Icons.stop),
              onPressed: () {
                FlutterRadio.stop();
                setState(() {
                  playingStatus();
                });
                
              },
            ),
            Text(
              'Check Playback Status: $isPlaying',
              style: TextStyle(fontSize: 25.0),
            )
          ],
        ),
      ),
    );
  }

  Future playingStatus() async {
    bool isP = await FlutterRadio.isPlaying();
    setState(() {
      isPlaying = isP;
      print('=================== $isPlaying');
    });
  }
}
