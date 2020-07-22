import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class Example extends StatefulWidget {
  Example({Key key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {

FlutterRadioPlayer _flutterRadioPlayer = new FlutterRadioPlayer();

var playerState = FlutterRadioPlayer.flutter_radio_paused;

  double volume = 0.8;

  @override
  void initState() {
    super.initState();
    initRadioService();
  }

  Future<void> initRadioService() async {
    try {
      await _flutterRadioPlayer.init(
          "IFC Radio", "En vivo", 'https://estructuraweb.com.co:9138/live', "true");
    } on PlatformException {
      print("Ha ocurrido un error");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: _flutterRadioPlayer.isPlayingStream,
                  initialData: playerState,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    String returnData = snapshot.data;
                    print("object data: " + returnData);
                    switch (returnData) {
                      case FlutterRadioPlayer.flutter_radio_stopped:
                        return RaisedButton(
                            child: Text("Start listening now"),
                            onPressed: () async {
                              await initRadioService();
                            });
                        break;
                      case FlutterRadioPlayer.flutter_radio_loading:
                        return Text("Loading stream...");
                      case FlutterRadioPlayer.flutter_radio_error:
                        return RaisedButton(
                            child: Text("Retry ?"),
                            onPressed: () async {
                              await initRadioService();
                            });
                        break;
                      default:
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                  onPressed: () async {
                                    print("button press data: " +
                                        snapshot.data.toString());
                                    await _flutterRadioPlayer.playOrPause();
                                  },
                                  icon: snapshot.data ==
                                          FlutterRadioPlayer
                                              .flutter_radio_playing
                                      ? Icon(Icons.pause)
                                      : Icon(Icons.play_arrow)),
                              IconButton(
                                  onPressed: () async {
                                    await _flutterRadioPlayer.stop();
                                  },
                                  icon: Icon(Icons.stop))
                            ]);
                        break;
                    }
                  }),
              Slider(
                  value: volume,
                  min: 0,
                  max: 1.0,
                  onChanged: (value) => setState(() {
                        volume = value;
                        _flutterRadioPlayer.setVolume(volume);
                      })),
              Text("Volume: " + (volume * 100).toStringAsFixed(0))
            ],
          ),
      )
    );
  }
}
