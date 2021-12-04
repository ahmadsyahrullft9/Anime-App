import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart'; //used to join paths

class MainDb {
  final String _dbName = "maindb.db";

  Future<String> provideDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName); //create path to database
    return path;
  }
}
