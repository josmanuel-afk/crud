import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/note_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'alumnoDB.db');

    

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''

        CREATE TABLE alumnos(
          id INTEGER PRIMARY KEY,
          nombre TEXT,
          edad TEXT
        )

''');
      },
    );
  }

  Future<int> newAlumnoRaw(Alumno note) async {
    final int? id = note.id;
    final String nombre = note.nombre;
    final String edad = note.edad;

    final db =
        await database; 

    final int res = await db.rawInsert('''

      INSERT INTO alumnos (id, nombre, edad) VALUES ($id, "$nombre", "$edad")

''');
    print(res);
    return res;
  }

  Future<int> newAlumno(Alumno alumno) async {
    final db = await database;

    final int res = await db.insert("alumnos", alumno.toJson());

    return res;
  }

  Future<Alumno?> getAlumnoById(int id) async {
    final Database db = await database;

    final res = await db.query('alumnos', where: 'id = ?', whereArgs: [id]);
    print(res);
    //Preguntamos si trae algun dato. Si lo hace
    return res.isNotEmpty ? Alumno.fromJson(res.first) : null;
  }

  Future<List<Alumno>> getAllAlumno() async {
    final Database? db = await database;
    final res = await db!.query('alumnos');
    return res.isNotEmpty ? res.map((n) => Alumno.fromJson(n)).toList() : [];
  }

  Future<int> updateAlumno(Alumno alumno) async {
    final Database db = await database;
    final res = await db
        .update('alumnos', alumno.toJson(), where: 'id = ?', whereArgs: [alumno.id]);
    return res;
  }

  Future<int> deleteAlumno(int id) async {
    final Database db = await database;
    final int res = await db.delete('alumnos', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllAlumno() async {
    final Database db = await database;
    final res = await db.rawDelete('''
      DELETE FROM alumnos    
    ''');
    return res;
  }
}
