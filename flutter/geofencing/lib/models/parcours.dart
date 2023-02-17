import 'package:sqflite/sqflite.dart';

class Parcours {
  final int idParcours;
  final String titre;
  final String duree;

  const Parcours({
    required this.idParcours,
    required this.titre,
    required this.duree,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcours': idParcours,
      'titre': titre,
      'duree': duree,
    };
  }

  @override
  String toString() {
    return 'Parcours{id: $idParcours, name: $titre, age: $duree}';
  }

  static Future<void> insertParcours(
      Parcours parcours, Database database) async {
    final db = database;

    await db.insert(
      'parcours',
      parcours.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateParcours(
      Parcours parcours, Database database) async {
    final db = database;

    await db.update(
      'parcours',
      parcours.toMap(),
      where: 'idParcours = ?',
      whereArgs: [parcours.idParcours],
    );
  }

  static Future<void> deleteParcours(int id, Database database) async {
    final db = database;

    await db.delete(
      'parcours',
      where: 'idParcours = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Parcours>> listParcours(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('parcours');

    return List.generate(maps.length, (i) {
      return Parcours(
          idParcours: maps[i]['idParcours'],
          titre: maps[i]['titre'],
          duree: maps[i]['duree']);
    });
  }
}
