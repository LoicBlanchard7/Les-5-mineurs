import 'package:sqflite/sqflite.dart';

class ZonesPoint {
  final int idZonePoint;
  final int idZone;
  final String item;
  final String collection;

  const ZonesPoint(
      {required this.idZonePoint,
      required this.idZone,
      required this.item,
      required this.collection});

  Map<String, dynamic> toMap() {
    return {
      'idZonePoint': idZonePoint,
      'idZone': idZone,
      'item': item,
      'collection': collection,
    };
  }

  @override
  String toString() {
    return 'ZonesPoint{idZonePoint: $idZonePoint, idZone: $idZone, item: $item, collection: $collection}';
  }

  static Future<void> insertZonesPoint(
      ZonesPoint zonesPoint, Database database) async {
    final db = database;

    await db.insert(
      'zonesPoint',
      zonesPoint.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateZonesPoint(
      ZonesPoint zonesPoint, Database database) async {
    final db = database;

    await db.update(
      'zonesPoint',
      zonesPoint.toMap(),
      where: 'idZonePoint = ?',
      whereArgs: [zonesPoint.idZonePoint],
    );
  }

  static Future<void> deleteZonesPoint(int id, Database database) async {
    final db = database;

    await db.delete(
      'zonesPoint',
      where: 'idZonePoint = ?',
      whereArgs: [id],
    );
  }

  static Future<List<ZonesPoint>> listZonesPoint(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('zonesPoint');

    return List.generate(maps.length, (i) {
      return ZonesPoint(
        idZonePoint: maps[i]['idZonePoint'],
        idZone: maps[i]['idZone'],
        item: maps[i]['item'].toString(),
        collection: maps[i]['collection'],
      );
    });
  }
}
