import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart' show required;
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

  Future<List<YouTubeVideo>> getPlayList(String playListId) async {
    try {
      final String url = _getUrl('playlistItems', {
        'part': ' snippet',
        'playlistId': playListId,
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
