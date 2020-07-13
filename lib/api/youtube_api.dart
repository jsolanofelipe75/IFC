import 'dart:convert';

import 'package:meta/meta.dart' show required;
import 'package:http/http.dart' as http;
import 'package:pruebas/models/play_list.dart';
import 'package:pruebas/models/youtube_video.dart';

class YoutubeAPI {
  final String apiKey;

  YoutubeAPI({@required this.apiKey}) : assert(apiKey != null);

  String _getUrl(String endPoint, Map<String, String> queryParameters) {
    final uri = Uri(
        host: 'www.googleapis.com',
        scheme: 'https',
        path: '/youtube/v3/$endPoint',
        queryParameters: queryParameters);

    return uri.toString();
  }

  Future<List<PlayList>> getPlayList(String channelId) async {
    try {
      final String url = _getUrl('playlists', {
        'part': ' snippet, contentDetails',
        'channelId': channelId,
        'key': this.apiKey,
        'maxResults': '20'
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        final List<PlayList> items = (parsed['items'] as List)
            .map<PlayList>((item) => PlayList.fromJson(item))
            .toList();

        return items;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<List<YouTubeVideo>> getNewVideos(String channelId) async {
    try {
      final String url = _getUrl('activities', {
        'part': ' snippet, contentDetails',
        'channelId': channelId,
        'key': this.apiKey,
        'maxResults': '20'
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);

        final List<YouTubeVideo> items = (parsed['items'] as List)
            .map<YouTubeVideo>((item) => YouTubeVideo.fromJson(item))
            .toList();

        return items;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
