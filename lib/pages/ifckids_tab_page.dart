import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pruebas/api/youtube_api.dart';
import 'package:pruebas/keys/keys.dart';
import 'package:pruebas/models/youtube_video.dart';
import 'package:pruebas/pages/Ifc_tab_page.dart';
import 'package:pruebas/theme/colors.dart';

class IfcKidsTabPage extends StatefulWidget {
  IfcKidsTabPage({Key key}) : super(key: key);

  @override
  _IfcKidsTabPageState createState() => _IfcKidsTabPageState();
}

class _IfcKidsTabPageState extends State<IfcKidsTabPage> {
  YoutubeAPI _youtubeAPI = YoutubeAPI(apiKey: YT_API_KEY);

  List<YouTubeVideo> _videos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final List<YouTubeVideo> videoList =
        await _youtubeAPI.getPlayList('PLa5DZi2Rvd4dlZ8xACHuj86Ob7MH4ChkD');
    setState(() {
      _videos.addAll(videoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperOne(),
            child: Container(
              width: double.infinity,
              height: 230.0,
              decoration: BoxDecoration(
                color: LightColors.kLightYellow2,
              ),
            ),
          ),
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                color: LightColors.kgrey,
              ),
            ),
          ),
          (_videos.length == 0)
              ? Container(
                  height: 80,
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LisVideos(items: _videos),
              ),
        ],
      ),
    );
  }
}