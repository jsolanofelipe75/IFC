import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_radio_player/flutter_radio_player.dart';

class StreamState with ChangeNotifier {
  static const streamUrl = 'https://estructuraweb.com.co:9138/live';
  FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  bool _playing = false;

  StreamState() {
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

  Future<bool> audioStop() async {
    try {
      await _flutterRadioPlayer.stop();
      _playing = false;

      print('=============== STOPP');
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  void streamState() async {
    try {
      bool playing = await _flutterRadioPlayer.isPlaying();
      print('==============00$playing');
      if (playing) {
      _playing = true;
      print('=============== VERDADERO');
      notifyListeners();
    } else {
      //audioStart();
      _playing = false;
      print('=============== FALSEEE');
      notifyListeners();
    }
    } catch (e) {
      print(e.toString());
    }
  }
}
