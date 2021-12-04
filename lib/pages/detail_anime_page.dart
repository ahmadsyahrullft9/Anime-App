import 'package:anime_news/datasource/anime_datasource.dart';
import 'package:anime_news/localdb/favorite_db.dart';
import 'package:anime_news/models/anime.dart';
import 'package:anime_news/models/top.dart';
import 'package:anime_news/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailAnimePage extends StatefulWidget {
  final Top top;

  const DetailAnimePage({required this.top, Key? key}) : super(key: key);

  @override
  _DetailAnimePageState createState() => _DetailAnimePageState();
}

class _DetailAnimePageState extends State<DetailAnimePage> {
  final FavoriteDb _favoriteDb = FavoriteDb();
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    Widget _buildIconFavorite() => Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, _) => IconButton(
            onPressed: () {
              if (favoriteProvider.isFavorite) {
                _favoriteDb.deleteFavorite(widget.top.malId).then((value) {
                  if (value != 0) {
                    favoriteProvider.isFavorite = false;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("success to remove from favorite list")));
                  }
                });
              } else {
                _favoriteDb.addToFavorite(widget.top).then((value) {
                  if (value != 0) {
                    favoriteProvider.isFavorite = true;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("success to save in favorite list")));
                  }
                });
              }
            },
            icon: favoriteProvider.isFavorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border)));

    return ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(isFavorite: _isFavorite),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text("Detail Anime"),
          backgroundColor: Colors.blue,
          actions: [
            FutureBuilder(
              future: _favoriteDb.fetchFavorite(widget.top.malId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    _isFavorite = true;
                  }
                  return _buildIconFavorite();
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        body: FutureBuilder(
          future: AnimeDatasource.getDetailAnime(widget.top.malId),
          builder: (context, snapshot) {
            Widget? childWidget;
            if (snapshot.hasData) {
              Anime anime = snapshot.data as Anime;
              String genresString = "";
              for (var element in anime.genres) {
                genresString += "$element, ";
              }
              childWidget = ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                            child: Image.network(anime.imageUrl, width: 120, height: 160),
                            borderRadius: BorderRadius.circular(8)),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(anime.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                              Text("Status : ${anime.status}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                              const SizedBox(height: 20),
                              Text("Score : ${anime.score}",
                                  style: const TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w800)),
                              Text("Type : ${anime.type}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              Text("Episodes : ${anime.episodes}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Genre", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        Text(genresString, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Synopsis", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        Text(anime.synopsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: MaterialButton(
                        onPressed: () {},
                        child: const Text(
                          "View in MyAnimeList",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              childWidget = Center(child: Text(snapshot.error.toString()));
            } else {
              childWidget = const Center(child: CircularProgressIndicator());
            }
            return childWidget;
          },
        ),
      ),
    );
  }
}
