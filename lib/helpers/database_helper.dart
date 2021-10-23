import 'dart:async';
import 'dart:io';
import 'package:contatos/models/contato.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

//definicion de las columnas de la
  String contatoTable = 'contato';
  String colId = 'id';
  String colUsergh = 'usergh';
  String colEmail = 'email';
  String colAvatar = 'avatar';

  //construtor nomeado para criar instância da classe (padrão Singleton)
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contatos.db';

    var contatosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return contatosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $contatoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colUsergh TEXT, $colEmail TEXT, $colAvatar TEXT)');
  }

//Incluir um objeto contato no banco de dados
  Future<int> insertContato(Contato contato) async {
    Database db = await database;

    var resultado = await db.insert(contatoTable, contato.toMap());

    return resultado;
  }

//retorna um contato pelo id
  Future<Contato?> getContato(int id) async {
    Database db = await database;

    if ((await db.query(contatoTable,
            columns: [colId, colUsergh, colEmail, colAvatar],
            where: "$colId = ?",
            whereArgs: [id]))
        .isNotEmpty) {
      return Contato.fromMap((await db.query(contatoTable,
              columns: [colId, colUsergh, colEmail, colAvatar],
              where: "$colId = ?",
              whereArgs: [id]))
          .first);
    } else {
      return null;
    }
  }

  Future<List<Contato>> getContatos() async {
    Database db = await database;

    var resultado = await db.query(contatoTable);

    List<Contato> lista = resultado.isNotEmpty
        ? resultado.map((c) => Contato.fromMap(c)).toList()
        : [];

    return lista;
  }

  //Atualizar o objeto Contato e salva no banco de dados
  Future<int> updateContato(Contato contato) async {
    var db = await database;

    var resultado = await db.update(contatoTable, contato.toMap(),
        where: '$colId = ?', whereArgs: [contato.id]);

    return resultado;
  }

  //Deletar um objeto Contato do banco de dados
  Future<int> deleteContato(int id) async {
    var db = await database;

    int resultado =
        await db.delete(contatoTable, where: "$colId = ?", whereArgs: [id]);

    return resultado;
  }

//Obtem o número de objetos contato no banco de dados
  Future<int?> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $contatoTable');

    int? resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
