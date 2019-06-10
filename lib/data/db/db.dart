import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:blockpass/data/models/user.dart';

class DB {
  
  static final DB _singleton = new DB._internal();
  Database _dbConn;

  factory DB() {
    return _singleton;
  }

  DB._internal() {
    _open();
  }

  Future<void> _open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    _dbConn = await openDatabase(
        path, 
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table users ( 
              id integer primary key autoincrement, 
              name text not null,
              password integer not null)
          ''');
        },
      );
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
    final Map<String, dynamic> mUser = maps.last;
    return User(
      id: mUser['id'],
      name: mUser['name'],
      password: mUser['password'],
    );
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

  Future<void> close() async => await _dbConn.close();

}
