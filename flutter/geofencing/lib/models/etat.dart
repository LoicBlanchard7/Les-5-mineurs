import 'package:sqflite/sqflite.dart';

class Etat {
  final int idEtat;
  final String lastUpdate;

  const Etat({
    required this.idEtat,
    required this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEtat': idEtat,
      'lastUpdate': lastUpdate,
    };
  }

  @override
  String toString() {
    return 'Etat{idEtat: $idEtat, lastUpdate: $lastUpdate}';
  }

  static Future<void> insertEtat(Etat etat, Database database) async {
    final db = database;

    await db.insert(
      'etat',
      etat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteEtat(int id, Database database) async {
    final db = database;

    await db.delete(
      'etat',
      where: 'idEtat = ?',
      whereArgs: [id],
    );
  }

  static Future<void> updateEtat(Etat etat, Database database) async {
    final db = database;

    await db.update(
      'etat',
      etat.toMap(),
      where: 'idEtat = ?',
      whereArgs: [etat.idEtat],
    );
  }

  static Future<List<Etat>> listEtats(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('etat');

    return List.generate(maps.length, (i) {
      return Etat(
        idEtat: maps[i]['idEtat'],
        lastUpdate: maps[i]['lastUpdate'],
      );
    });
  }
}
