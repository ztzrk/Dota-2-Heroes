import 'package:mydota/model/list_team_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal() {
    initDatabase();
  }

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      _database = await initDatabase();
      return _database;
    }
  }

  Future<Database> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE teams(
              team_id INTEGER, 
              rating DOUBLE, 
              wins INTEGER, 
              losses INTEGER, 
              last_match_time INTEGER, 
              name TEXT, 
              tag TEXT, 
              logo_url TEXT)
              ''');
      },
      version: 1,
    );
    return _database;
  }

  Future<bool> isTeamFavorite(int teamId) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db
        .rawQuery('SELECT COUNT(*) FROM teams WHERE team_id = $teamId'));
    return count! > 0;
  }

  Future<void> insertTeam(
    ListTeamModel team,
  ) async {
    final db = await database;
    try {
      await db.insert('teams', team.toMap());
    } catch (e) {
      print('Error inserting team: $e');
    }
  }

  Future<void> removeTeam(int teamId) async {
    final db = await database;
    await db.delete('teams', where: 'team_id = ?', whereArgs: [teamId]);
  }

  Future<List<ListTeamModel>> getTeams() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('teams');
    return List.generate(maps.length, (i) {
      return ListTeamModel(
        teamId: maps[i]['team_id'],
        name: maps[i]['name'],
        logoUrl: maps[i]['logo_url'],
        wins: maps[i]['wins'],
        losses: maps[i]['losses'],
      );
    });
  }
}
