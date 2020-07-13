import 'dart:convert';

import 'package:http/http.dart' as http;

class PostsProvider {
  final dominioUrl =
      'https://iglesiafamiliarcristiana.org/wp-json/wp/v2/posts?_embed';

  Future<List> blog() async {
    try {
      final response =
          await http.get(dominioUrl, headers: {'Accept': 'application/json'});
      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return [];
    }
  }
}
