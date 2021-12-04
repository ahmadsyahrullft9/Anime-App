class TopContent {
  static const String isAnime = "anime";
  static const String isManga = "manga";

  static const animeAiring = "airing";
  static const animeUpcoming = "upcoming";
  static const animeTv = "tv";
  static const animeMovie = "movie";
  static const animeOva = "ova";
  static const animeSpecial = "special";

  static const mangaManga = "manga";
  static const mangaNovels = "novels";
  static const mangaOneshots = "oneshots";
  static const mangaDoujin = "doujin";
  static const mangaManhwa = "manhwa";
  static const mangaManhua = "manhua";

  final String type;
  final String subType;

  const TopContent({required this.type, required this.subType});

  String provideTitle() {
    return "$type $subType";
  }

  static const List<TopContent> topContentList = [
    TopContent(type: TopContent.isAnime, subType: TopContent.animeAiring),
    TopContent(type: TopContent.isAnime, subType: TopContent.animeUpcoming),
    TopContent(type: TopContent.isAnime, subType: TopContent.animeTv),
    TopContent(type: TopContent.isAnime, subType: TopContent.animeMovie),
    TopContent(type: TopContent.isAnime, subType: TopContent.animeOva),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaManga),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaNovels),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaOneshots),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaDoujin),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaManhwa),
    TopContent(type: TopContent.isManga, subType: TopContent.mangaManhua),
  ];
}
