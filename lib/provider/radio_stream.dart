import 'package:flutter/material.dart';

import 'package:flutter_radio/flutter_radio.dart';


class StreamState with ChangeNotifier{

  static const streamUrl = 'https://estructuraweb.com.co:9138/live';


  bool _isPlaying = false;

  bool isPlaying() => _isPlaying;

  Future<void> audioStart() async {
    await FlutterRadio.audioStart().whenComplete(() => FlutterRadio.play(url: streamUrl));
    _isPlaying = true;
    print('Audio Start OK');
    notifyListeners();
  }

  Future audioPause() async{
    await FlutterRadio.pause(url: streamUrl).whenComplete(() => _isPlaying = false);
    notifyListeners();
  }
}
