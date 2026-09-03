import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  static Future<Database> abrirBanco() async {
    final caminho = join(await getDatabasesPath(), 'contatos.db');

    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, versao) {
        return db.execute(
          'CREATE TABLE contatos ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'inicial TEXT,'
          'nome TEXT,'
          'numero TEXT,'
          'situacao INTEGER' //0 - False, 1 - True
          ')',
        );
      },
    );
  }

  static Future<Database> get database async {
    _db ??= await abrirBanco();

    return _db!;
  }
}
