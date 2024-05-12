import 'package:mydota/model/list_team_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database.isOpen) {
      return _database;
    } else {
      return await initDatabase();
    }
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          await db.execute('''
          CREATE TABLE teams(
            team_id INTEGER PRIMARY KEY,
            rating REAL,
            wins INTEGER,
            losses INTEGER,
            last_match_time INTEGER,
            name TEXT,
            tag TEXT,
            logo_url TEXT
          )
        ''');
        } catch (e) {
          print('Error creating tables: $e');
        }
      },
    );
    return _database;
  }

  Future<bool> isTeamFavorite(int teamId) async {
    final db = await database;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM teams WHERE id = ?', [teamId]));
    return count! > 0;
  }

  Future<void> insertTeam(
    ListTeamModel team,
  ) async {
    final db = await database;
    try {
      print(team.toMap());
      await db.insert('teams', team.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting team: $e');
    }
  }

  Future<void> removeTeam(int teamId) async {
    final db = await database;
    await db.delete('teams', where: 'id = ?', whereArgs: [teamId]);
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
