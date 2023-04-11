import 'package:sqflite/sqflite.dart';

class ParcoursPoints {
  final int idParcoursPoints;
  final String idPoint;
  final int idParcour;

  const ParcoursPoints({
    required this.idParcoursPoints,
    required this.idPoint,
    required this.idParcour,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcoursPoints': idParcoursPoints,
      'idPoint': idPoint,
      'idParcour': idParcour,
    };
  }

  @override
  String toString() {
    return 'ParcoursPoints{idParcoursPoints: $idParcoursPoints, idPoint: $idPoint, idParcour: $idParcour}';
  }

  static Future<void> insertParcoursPoints(
      ParcoursPoints parcoursPoints, Database database) async {
    final db = database;

    await db.insert(
      'parcoursPoints',
      parcoursPoints.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateParcoursPoints(
      ParcoursPoints parcoursPoints, Database database) async {
    final db = database;

    await db.update(
      'parcoursPoints',
      parcoursPoints.toMap(),
      where: 'idParcoursPoints = ?',
      whereArgs: [parcoursPoints.idParcoursPoints],
    );
  }

  static Future<void> deleteParcoursPoints(int id, Database database) async {
    final db = database;

    await db.delete(
      'parcoursPoints',
      where: 'idParcoursPoints = ?',
      whereArgs: [id],
    );
  }

  static Future<List<ParcoursPoints>> listParcoursPoints(
      Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('parcoursPoints');

    return List.generate(maps.length, (i) {
      return ParcoursPoints(
          idParcoursPoints: maps[i]['idParcoursPoints'],
          idPoint: maps[i]['idPoint'],
          idParcour: maps[i]['idParcour']);
    });
  }
}
