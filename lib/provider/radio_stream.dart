import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';

class StreamState with ChangeNotifier {
  static const streamUrl = 'https://estructuraweb.com.co:9138/live';


  bool _playing = false;

  StreamState() {
    streamState();
  }

  bool isPlaying() => _playing;

  Future audioStart() async {
    if (_playing == false) {
      try {
        await FlutterRadio.audioStart().whenComplete(() => audioPlay());
        print('Audio Start OK');
      } catch (e) {
        print(e.toString());
      }
      notifyListeners();
    } else {
      audioPlay();
      notifyListeners();
    }
  }

  Future audioPause() async {
    try {
      await FlutterRadio.pause(url: streamUrl);
    
      _playing = false;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future audioPlay() async {
    try {
      await FlutterRadio.play(url: streamUrl);
     
      _playing = true;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future<bool> audioStop() async{
    try {
       await FlutterRadio.stop();
      _playing = false;

      print('=============== se detuvo');
      notifyListeners();
      
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  void streamState() async {
   
    bool isplaying = await FlutterRadio.isPlaying();
    if (isplaying == true) {
      _playing = true;

      notifyListeners();
    } else {
      _playing = false;
      notifyListeners();
    }
  }
}
