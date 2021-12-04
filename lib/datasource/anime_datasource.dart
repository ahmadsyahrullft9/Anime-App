import 'dart:convert';

import 'package:anime_news/models/anime.dart';
import 'package:anime_news/models/top_anime.dart';
import 'package:anime_news/models/top_content.dart';
import 'package:http/http.dart' as http;

class AnimeDatasource {
  static Future<TopAnime> getTopAnime({int page = 1, TopContent? topContent}) async {
    final String url = topContent == null
        ? "https://api.jikan.moe/v3/top/anime/"
        : "https://api.jikan.moe/v3/top/${topContent.type}/$page/${topContent.subType}";
    var resultTopAnime = await http.get(Uri.parse(url));
    var jsonObj = jsonDecode(resultTopAnime.body);
    var result = TopAnime.fromJson(jsonObj);
    return result;
  }

  static Future<Anime> getDetailAnime(int malId) async {
    final String url = "https://api.jikan.moe/v3/anime/$malId";
    var resultDetailAnime = await http.get(Uri.parse(url));
    var jsonObj = jsonDecode(resultDetailAnime.body);
    var result = Anime.fromJson(jsonObj);
    return result;
  }
}
