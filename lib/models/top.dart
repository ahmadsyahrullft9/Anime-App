import 'dart:ffi';

class Top {
  int malId;
  int rank;
  String title;
  String url;
  String imageUrl;
  String? type;
  int? episodes;
  String? startDate;
  String? endDate;
  int members;
  double score;

  Top(
      {required this.malId,
      required this.rank,
      required this.title,
      required this.url,
      required this.imageUrl,
      required this.type,
      required this.episodes,
      required this.startDate,
      required this.endDate,
      required this.members,
      required this.score});

  factory Top.fromJson(Map<String, dynamic> json) {
    double score = json['score'] is double ? json['score'] : double.parse("${json['score']}");
    return Top(
        malId: json['mal_id'],
        rank: json['rank'],
        title: json['title'],
        url: json['url'],
        imageUrl: json['image_url'],
        type: json['type'],
        episodes: (json['episodes'] != null) ? json['episodes'] : 0,
        startDate: json['start_date'],
        endDate: json['end_date'],
        members: (json['members'] != null) ? json['members'] : 0,
        score: score);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal_id'] = malId;
    data['rank'] = rank;
    data['title'] = title;
    data['url'] = url;
    data['image_url'] = imageUrl;
    data['type'] = type;
    data['episodes'] = episodes;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['members'] = members;
    data['score'] = score;
    return data;
  }
}
