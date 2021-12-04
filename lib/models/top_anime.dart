import 'package:anime_news/models/top.dart';

class TopAnime {
  String requestHash;
  bool requestCached;
  int requestCacheExpiry;
  List<Top> top;

  TopAnime(
      {required this.requestHash,
      required this.requestCached,
      required this.requestCacheExpiry,
      required this.top});

  factory TopAnime.fromJson(Map<String, dynamic> json) {
    List<Top> top = [];
    String requestHash = json['request_hash'];
    bool requestCached = json['request_cached'];
    int requestCacheExpiry = json['request_cache_expiry'];
    if (json['top'] != null) {
      json['top'].forEach((v) {
        top.add(Top.fromJson(v));
      });
    }
    return TopAnime(
        requestHash: requestHash,
        requestCached: requestCached,
        requestCacheExpiry: requestCacheExpiry,
        top: top);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_hash'] = requestHash;
    data['request_cached'] = requestCached;
    data['request_cache_expiry'] = requestCacheExpiry;
    data['top'] = top.map((v) => v.toJson()).toList();
    return data;
  }
}
