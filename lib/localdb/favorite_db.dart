import 'package:anime_news/localdb/main_db.dart';
import 'package:anime_news/models/top.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDb extends MainDb {
  final String _tbname = "favorite";

  Future<Database> init() async {
    var path = await provideDb();
    return await openDatabase(
        //open the database or create a database if there isn't any
        path,
        version: 1, onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE $_tbname(
            mal_id INTEGER PRIMARY KEY,
            rank INTEGER,
            title TEXT,
            url TEXT,
            image_url TEXT,
            type TEXT,
            episodes INTEGER,
            start_date TEXT,
            end_date TEXT,
            members INTEGER,
            score TEXT
          )""");
    });
  }

  Future<int> addToFavorite(Top top) async {
    //returns number of items inserted as an integer
    final db = await init(); //open database
    return db.insert(
      _tbname, top.toJson(), //toMap() function from MemoModel
      conflictAlgorithm: ConflictAlgorithm.ignore, //ignores conflicts due to duplicate entries
    );
  }

  Future<List<Top>> fetchFavorites(String search) async {
    final db = await init();
    //returns the memos as a list (array)
    List<Map<String, Object?>> maps;
    if (search.isEmpty) {
      maps = await db.query(_tbname); //query all the rows in a table as an array of maps
    } else {
      maps = await db.query(_tbname,
          where: "title LIKE ?", whereArgs: ['%$search%']); //query all the rows in a table as an array of maps
    }
    return List.generate(maps.length, (i) {
      //create a list of memos
      double score = maps[i]['score'].toString().isEmpty ? 0 : double.parse(maps[i]['score'].toString());
      return Top(
          malId: int.parse(maps[i]['mal_id'].toString()),
          rank: int.parse(maps[i]['rank'].toString()),
          title: maps[i]['title'].toString(),
          url: maps[i]['url'].toString(),
          imageUrl: maps[i]['image_url'].toString(),
          type: maps[i]['type'].toString(),
          episodes: (maps[i]['episodes'] != null) ? int.parse(maps[i]['episodes'].toString()) : 0,
          startDate: maps[i]['start_date'].toString(),
          endDate: maps[i]['end_date'].toString(),
          members: (maps[i]['members'] != null) ? int.parse(maps[i]['members'].toString()) : 0,
          score: score);
    });
  }

  Future<Top?> fetchFavorite(int malId) async {
    //returns the memos as a list (array)
    final db = await init();
    final maps = await db.query(_tbname,
        where: "mal_id = ?", whereArgs: [malId], limit: 1); //query all the rows in a table as an array of maps
    if (maps.isNotEmpty) {
      double score = maps[0]['score'].toString().isEmpty ? 0 : double.parse(maps[0]['score'].toString());
      return Top(
          malId: int.parse(maps[0]['mal_id'].toString()),
          rank: int.parse(maps[0]['rank'].toString()),
          title: maps[0]['title'].toString(),
          url: maps[0]['url'].toString(),
          imageUrl: maps[0]['image_url'].toString(),
          type: maps[0]['type'].toString(),
          episodes: (maps[0]['episodes'] != null) ? int.parse(maps[0]['episodes'].toString()) : 0,
          startDate: maps[0]['start_date'].toString(),
          endDate: maps[0]['end_date'].toString(),
          members: (maps[0]['members'] != null) ? int.parse(maps[0]['members'].toString()) : 0,
          score: score);
    }

    return null;
  }

  Future<int> deleteFavorite(int malId) async {
    //returns number of items deleted
    final db = await init();
    int result = await db.delete(
      _tbname, //table name
      where: "mal_id = ?",
      whereArgs: [malId], // use whereArgs to avoid SQL injection
    );

    return result;
  }

  Future<int> updateFavorite(int malId, Top top) async {
    // returns the number of rows updated
    final db = await init();
    int result = await db.update(_tbname, top.toJson(), where: "mal_id = ?", whereArgs: [malId]);
    return result;
  }
}
