import 'package:sqflite/sqflite.dart';

class Coordonnees {
  final int idCoo;
  final int idZone;
  final double posX;
  final double posY;

  const Coordonnees({
    required this.idCoo,
    required this.idZone,
    required this.posX,
    required this.posY,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCoo': idCoo,
      'idZone': idZone,
      'posX': posX,
      'posY': posY,
    };
  }

  @override
  String toString() {
    return 'Coordonnees{idCoo: $idCoo, idZone: $idZone, posX: $posX, posY: $posY}';
  }

  static Future<void> insertCoordonnees(
      Coordonnees coordonnees, Database database) async {
    final db = database;

    await db.insert(
      'coordonnees',
      coordonnees.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateCoordonnees(
      Coordonnees coordonnees, Database database) async {
    final db = database;

    await db.update(
      'coordonnees',
      coordonnees.toMap(),
      where: 'idCoo = ?',
      whereArgs: [coordonnees.idCoo],
    );
  }

  static Future<List<Coordonnees>> listCoordonnees(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('coordonnees');

    return List.generate(maps.length, (i) {
      return Coordonnees(
          idCoo: maps[i]['idCoo'],
          idZone: maps[i]['idZone'],
          posY: maps[i]['posY'],
          posX: maps[i]['posX']);
    });
  }

  static Future<void> deleteCoordonnees(int id, Database database) async {
    final db = database;

    await db.delete(
      'coordonnees',
      where: 'idCoo = ?',
      whereArgs: [id],
    );
  }
}
