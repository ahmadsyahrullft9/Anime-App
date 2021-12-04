import 'package:anime_news/models/genres.dart';

class Anime {
  Anime({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.trailerUrl,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.type,
    required this.source,
    required this.episodes,
    required this.status,
    required this.airing,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.genres,
  });
  late final int malId;
  late final String url;
  late final String imageUrl;
  late final String? trailerUrl;
  late final String title;
  late final String? titleEnglish;
  late final String? titleJapanese;
  late final List<String> titleSynonyms;
  late final String type;
  late final String source;
  late final int episodes;
  late final String status;
  late final bool airing;
  late final String duration;
  late final String rating;
  late final double score;
  late final int scoredBy;
  late final int rank;
  late final int popularity;
  late final int members;
  late final int favorites;
  late final String synopsis;
  late final List<Genres> genres;

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    url = json['url'];
    imageUrl = json['image_url'];
    trailerUrl = json['trailer_url'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];
    titleSynonyms = List.castFrom<dynamic, String>(json['title_synonyms']);
    type = json['type'];
    source = json['source'];
    episodes = (json['episodes'] != null) ? json['episodes'] : 0;
    status = json['status'];
    airing = json['airing'];
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'];
    scoredBy = json['scored_by'];
    rank = json['rank'];
    popularity = json['popularity'];
    members = json['members'];
    favorites = json['favorites'];
    synopsis = (json['synopsis'] != null) ? json['synopsis'] : "--";
    genres = List.from(json['genres']).map((e) => Genres.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['url'] = url;
    _data['image_url'] = imageUrl;
    _data['trailer_url'] = trailerUrl;
    _data['title'] = title;
    _data['title_english'] = titleEnglish;
    _data['title_japanese'] = titleJapanese;
    _data['title_synonyms'] = titleSynonyms;
    _data['type'] = type;
    _data['source'] = source;
    _data['episodes'] = episodes;
    _data['status'] = status;
    _data['airing'] = airing;
    _data['duration'] = duration;
    _data['rating'] = rating;
    _data['score'] = score;
    _data['scored_by'] = scoredBy;
    _data['rank'] = rank;
    _data['popularity'] = popularity;
    _data['members'] = members;
    _data['favorites'] = favorites;
    _data['synopsis'] = synopsis;
    _data['genres'] = genres.map((e) => e.toJson()).toList();
    return _data;
  }
}
