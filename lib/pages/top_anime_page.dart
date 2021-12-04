import 'package:anime_news/datasource/anime_datasource.dart';
import 'package:anime_news/models/top_content.dart';
import 'package:anime_news/models/top_anime.dart';
import 'package:anime_news/pages/detail_anime_page.dart';
import 'package:anime_news/pages/favorite_anime_page.dart';
import 'package:anime_news/providers/top_content_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopAnimePage extends StatefulWidget {
  final String tittle;

  const TopAnimePage({required this.tittle, Key? key}) : super(key: key);

  @override
  _TopAnimePageState createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> {
  TopAnime? topAnime;

  final List<TopContent> topContentList = TopContent.topContentList;

  final List<DropdownMenuItem<TopContent>> itemsDropdown = TopContent.topContentList
      .map((topContent) => DropdownMenuItem<TopContent>(
          value: topContent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(topContent.provideTitle()),
          )))
      .toList();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return TopContentProvider(topContent: topContentList[0]);
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(widget.tittle),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoriteAnimePage()));
                },
                icon: const Icon(Icons.favorite_rounded))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<TopContentProvider>(
              builder: (context, topContentProvider, _) => Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black12, width: 0.2),
                    borderRadius: BorderRadius.circular(8.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: itemsDropdown,
                    onChanged: (newValue) {
                      _scrollController.animateTo(0,
                          duration: const Duration(microseconds: 400), curve: Curves.fastOutSlowIn);
                      topContentProvider.topContent = newValue as TopContent;
                    },
                    value: topContentProvider.topContent,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<TopContentProvider>(
                builder: (context, topContentProvider, _) => FutureBuilder(
                  future: AnimeDatasource.getTopAnime(topContent: topContentProvider.topContent),
                  builder: (context, snapshot) {
                    Widget? childWidget;
                    if (snapshot.hasData) {
                      topAnime = (snapshot.data as TopAnime);
                      var topAnimeList = topAnime!.top;
                      childWidget = ListView.builder(
                        controller: _scrollController,
                        itemBuilder: (context, i) {
                          var _top = topAnimeList[i];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => DetailAnimePage(top: _top)));
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
                        itemCount: topAnimeList.length,
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
            ),
          ],
        ),
      ),
    );
  }
}
