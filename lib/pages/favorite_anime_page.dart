import 'package:anime_news/localdb/favorite_db.dart';
import 'package:anime_news/models/top.dart';
import 'package:anime_news/pages/detail_anime_page.dart';
import 'package:flutter/material.dart';

class FavoriteAnimePage extends StatefulWidget {
  const FavoriteAnimePage({Key? key}) : super(key: key);

  @override
  _FavoriteAnimePageState createState() => _FavoriteAnimePageState();
}

class _FavoriteAnimePageState extends State<FavoriteAnimePage> {
  final FavoriteDb _favoriteDb = FavoriteDb();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: const Text("My Favorite Anime")),
      body: FutureBuilder(
        future: _favoriteDb.fetchFavorites(""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Top> _topList = snapshot.data as List<Top>;
              return ListView.builder(
                itemCount: _topList.length,
                itemBuilder: (context, index) {
                  Top _top = _topList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailAnimePage(top: _top)))
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 0.2),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Row(
                        children: [
                          ClipRRect(
                            child: Image.network(
                              _top.imageUrl,
                              height: 80,
                              width: 60,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_top.title, style: const TextStyle(fontSize: 18, color: Colors.black87)),
                                Text("Score  : ${_top.score}",
                                    style: const TextStyle(fontSize: 18, color: Colors.black45)),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No data result"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
