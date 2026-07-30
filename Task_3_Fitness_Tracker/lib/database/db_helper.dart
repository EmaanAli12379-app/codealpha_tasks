import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/workout_model.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'fitness_tracker.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE workouts(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            durationMinutes INTEGER,
            calories INTEGER,
            steps INTEGER,
            date TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertWorkout(Workout workout) async {
    final db = await database;
    try {
      return await db.insert('workouts', workout.toMap());
    } catch (e) {
      return await db.rawInsert(
        '''
        INSERT INTO workouts(title, durationMinutes, calories, date)
        VALUES(?, ?, ?, ?)
      ''',
        [
          workout.title,
          workout.durationMinutes,
          workout.calories,
          workout.date,
        ],
      );
    }
  }

  static Future<List<Workout>> getWorkouts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'workouts',
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (i) => Workout.fromMap(maps[i]));
  }
}
