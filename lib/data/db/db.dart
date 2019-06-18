import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:blockpass/data/models/user.dart';

class DB {
  
  static final DB _singleton = new DB._internal();
  Database _dbConn;

  factory DB() {
    return _singleton;
  }

  DB._internal();

  Future<void> open() async {
    if (_dbConn == null || !_dbConn.isOpen) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');
      _dbConn = await openDatabase(
        path, 
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table users ( 
              id integer primary key autoincrement, 
              name text,
              chainID text not null,
              network text default 'eos',
              data text,
              syncTime integer,
              password integer,
              enableSync integer)
          ''');
        },
      );
    }
  }

  Future<void> insertUser(User user) async {
    await _dbConn.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User> selectUser() async {
    final List<Map<String, dynamic>> maps = await _dbConn.query('users');
    if (maps.length > 0) {
      final Map<String, dynamic> mUser = maps.last;
      return User.fromMap(mUser);
    }
    return null;
  }

  Future<User> selectUserID(int id) async {
    List<Map> maps = await _dbConn.query('users',
                                        where: 'id = ?',
                                        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return null;

  }

  Future<int> updateUser(User user) async => await _dbConn.update('users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
    
  Future<int> deleteUser(int id) async => await _dbConn.delete('users', where: 'id = ?', whereArgs: [id]);

  Future<int> deleteAllUsers() async => await _dbConn.delete('users');

  Future<void> close() async => await _dbConn.close();

}

final db = DB();