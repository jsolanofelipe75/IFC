import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class StreamState with ChangeNotifier {
  static const streamUrl = 'https://estructuraweb.com.co:9138/live';
  FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  bool _playing = false;

  StreamState()  {
    audioStart();
    streamState();
  }

  bool isPlaying() => _playing;

  Future audioStart() async {
    try {
      await _flutterRadioPlayer.init(
          "IFC Radio", "En vivo", streamUrl, "false");
      print('=============== INICIADO');
    } on PlatformException {
      print("Ha ocurrido un error");
    }
    notifyListeners();
  }
  
  Future audioPlay() async {
    try {
      await _flutterRadioPlayer.play();
      _playing = true;
      print('=============== PLAYYY');
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future audioPause() async {
    try {
      await _flutterRadioPlayer.pause();
      _playing = false;
      print('=============== PAUSEE');
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future audioStop() async {
    try {
      await _flutterRadioPlayer.stop();
      _playing = false;
      print('=============== STOPP');
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void streamState() async {
    try {
      bool playing = await _flutterRadioPlayer.isPlaying();
      if (playing) {
        _playing = true;
        notifyListeners();
        print('==============TRUE');
      } else {
        //audioStart();
        _playing = false;
        notifyListeners();
        print('==============FALSEE');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
