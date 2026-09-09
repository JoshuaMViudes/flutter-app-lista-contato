import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;

  //Abre(ou cria, se não existe) o arquivo banco de dados
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

  // Getter que devolve o banco de dados já aberto, ou abre se ainda não existe
  static Future<Database> get database async {
    _db ??= await abrirBanco();

    return _db!;
  }

  // READ: Buscar todos as contatos salvos no banco
  static Future<List<Map<String, dynamic>>> buscarContatos() async {
    final db = await DatabaseHelper.database;
    return db.query('contatos'); //SELECT * FROM contatos
  }

  //CREATE: Inserir um novo contato no banco de dados
  static Future<void> inserirContato(
    String inicial,
    String nome,
    String numero,
  ) async {
    final db = await DatabaseHelper.database;
    await db.insert('contatos', {
      'inicial': inicial,
      'nome': nome,
      'numero': numero,
      'situacao': 0,
    });
  }
}
