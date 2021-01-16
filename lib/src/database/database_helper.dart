import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:practica2/src/models/user_dao.dart';
import 'package:practica2/src/models/trending.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _nombreBD = "PATM2020";
  static final _versionBD = 1;

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);
    return await openDatabase(
      rutaBD,
      version: _versionBD,
      onCreate: _crearTablas,
    );
  }

  _crearTablas(Database db, int version) async {
    await db.execute(
        "CREATE TABLE tbl_perfil(id INTEGER PRIMARY KEY, nomUser varchar(30), lastUser varchar(70), telUser char(10), emailUser varchar(30), foto varchar (200), username varchar (30), pwduser varchar(30))");
    await db.execute(
        "CREATE TABLE tbl_favorites(id INTEGER PRIMARY KEY, poster_path varchar(90),idmovie INTEGER, backdrop_path varchar(90), title varchar(255), vote_average double, overview text, release_date varchar(70), user varchar(30))");
    //await db.execute("create...");
  }

  Future<int> insertar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient.insert(tabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String tabla) async {
    var dbClient = await database;
    return await dbClient
        .update(tabla, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> eliminar(int id, String tabla) async {
    var dbClient = await database;
    return await dbClient.delete(tabla, where: 'id = ?', whereArgs: [id]);
  }

  Future<UserDAO> getUsuario(String emailUser) async {
    var dbClient = await database;
    var result = await dbClient
        .query('tbl_perfil', where: 'emailUser = ?', whereArgs: [emailUser]);
    var lista = (result).map((item) => UserDAO.fromJSON(item)).toList();
    return lista.length > 0 ? lista[0] : null;
  }

  Future<Result> getMovie(int id, String user) async {
    var dbClient = await database;

    var result = await dbClient.query("tbl_favorites",
        where: "idmovie = ? and user = ?", whereArgs: [id, user]);

    var list = (result).map((e) => Result.fromJSONWithFavorite(e)).toList();
    return list.length > 0 ? list[0] : null;
  }

  Future<List<Result>> getMovies(usuario) async {
    var dbClient = await database;

    var result = await dbClient
        .query("tbl_favorites", where: "user = ?", whereArgs: [usuario]);

    var list = (result).map((e) => Result.fromJSONWithFavorite(e)).toList();
    return list.length > 0 ? list : null;
  }

  Future<int> eliminarMovie(int id, String tabla, String user) async {
    var dbClient = await database;
    return await dbClient.delete(tabla,
        where: 'idmovie = ? and user = ?', whereArgs: [id, user]);
  }
}
