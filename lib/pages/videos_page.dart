import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:pruebas/api/youtube_api.dart';

import 'package:pruebas/keys/keys.dart';

import 'package:pruebas/models/youtube_video.dart';
import 'package:pruebas/theme/colors.dart';
import '../widgets/youtube_video_item.dart';

class VideosListPage extends StatefulWidget {
  VideosListPage({Key key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosListPage> {
  YoutubeAPI _youtubeAPI = YoutubeAPI(apiKey: YT_API_KEY);

  List<YouTubeVideo> _videos = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    final List<YouTubeVideo> videoList =
        await _youtubeAPI.getNewVideos('UC31EA4cMrAavsIcafmuebnA');
    setState(() {
      _videos.addAll(videoList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: LightColors.kDarkYellow,
            expandedHeight: 200,
            pinned: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
                child: Image.asset('assets/ifc_en_casa.png'),
              ),
            ),
            title: Text(''),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Stack(
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
                          color: LightColors.kDarkYellow,
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
                        : LisVideos(items: _videos),
                  ],
                ),
              ],
            ),
          )
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
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        final YouTubeVideo item = items[index];
        return YouTubeVideoItem(item: item);
      },
    );
  }
}
