import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pruebas/api/youtube_api.dart';
import 'package:pruebas/keys/keys.dart';
import 'package:pruebas/models/youtube_video.dart';
import 'package:pruebas/theme/colors.dart';
import 'package:pruebas/widgets/youtube_video_item.dart';

class IfcTabPage extends StatefulWidget {
  IfcTabPage({Key key}) : super(key: key);

  @override
  _IfcTabPageState createState() => _IfcTabPageState();
}

class _IfcTabPageState extends State<IfcTabPage> {
  YoutubeAPI _youtubeAPI = YoutubeAPI(apiKey: YT_API_KEY);

  List<YouTubeVideo> _videos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final List<YouTubeVideo> videoList =
        await _youtubeAPI.getPlayList('PLa5DZi2Rvd4eMxjlCCAjOnxpc09BQkITd');
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

class LisVideos extends StatelessWidget {
  final List<YouTubeVideo> items;

  const LisVideos({Key key, @required this.items})
      : assert(items != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      itemCount: items.length,
      
      itemBuilder: (BuildContext context, int index) {
        final YouTubeVideo item = items[index];
        return YouTubeVideoItem(item: item);
      },
    );
  }
}
