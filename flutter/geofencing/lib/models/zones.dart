import 'package:sqflite/sqflite.dart';

class Zones {
  final int idZone;
  final String titre;
  final String idPoint;

  const Zones({
    required this.idZone,
    required this.titre,
    required this.idPoint,
  });

  Map<String, dynamic> toMap() {
    return {
      'idZone': idZone,
      'titre': titre,
      'idPoint': idPoint,
    };
  }

  @override
  String toString() {
    return 'Zones{idZone: $idZone, titre: $titre, idPoint: $idPoint}';
  }

  static Future<void> insertZones(Zones zones, Database database) async {
    final db = database;

    await db.insert(
      'zones',
      zones.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateZones(Zones zones, Database database) async {
    final db = database;

    await db.update(
      'zones',
      zones.toMap(),
      where: 'idZone = ?',
      whereArgs: [zones.idZone],
    );
  }

  static Future<void> deleteZones(int id, Database database) async {
    final db = database;

    await db.delete(
      'zones',
      where: 'idZone = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Zones>> listZones(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('zones');

    return List.generate(maps.length, (i) {
      return Zones(
          idZone: maps[i]['idZone'],
          titre: maps[i]['titre'],
          idPoint: maps[i]['idPoint']);
    });
  }
}
