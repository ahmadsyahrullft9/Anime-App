class Genres {
  Genres({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });
  late final int malId;
  late final String type;
  late final String name;
  late final String url;

  Genres.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['type'] = type;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}
