import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import 'package:pruebas/keys/keys.dart';
import 'package:pruebas/models/youtube_video.dart';
import 'package:pruebas/theme/colors.dart';
import '../utils/extras.dart';
import '../utils/responsive.dart';

class YouTubeVideoItem extends StatelessWidget {
  final YouTubeVideo item;

  const YouTubeVideoItem({Key key, @required this.item})
      : assert(item != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return ZoomIn(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          
          FlutterYoutube.playYoutubeVideoById(backgroundColor: Colors.white,apiKey: YT_API_KEY, videoId: item.videoId, fullScreen: false);
          /*FlutterYoutube.playYoutubeVideoByUrl(
            apiKey: YT_API_KEY,
            videoUrl: "https://www.youtube.com/watch?v=${item.videoId}",
            autoPlay: true, //default falase
            fullScreen: false,
          );*/
        },
        child: AspectRatio(
          aspectRatio: 7 / 3,
          child: Card(
            elevation: 3,
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      imageUrl: item.banner,
                      fit: BoxFit.fill,
                      height: responsive.height,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        SizedBox(height: 5),
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: Text(
                              item.description,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  fontSize: 11, color: Colors.blueGrey),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          Extras.fromNow(item.publishedAt),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 11, color: LightColors.kgrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
