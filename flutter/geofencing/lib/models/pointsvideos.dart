import 'package:sqflite/sqflite.dart';

class PointsVideos {
  final int idPointsVideos;
  final int idPoint;
  final String urlVideo;

  const PointsVideos({
    required this.idPointsVideos,
    required this.idPoint,
    required this.urlVideo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPointsVideos': idPointsVideos,
      'idPoint': idPoint,
      'urlVideo': urlVideo,
    };
  }

  @override
  String toString() {
    return 'PointsVideos{idPointsVideos: $idPointsVideos, idPoint: $idPoint, urlVideo: $urlVideo}';
  }

  static Future<void> insertPointsVideos(
      PointsVideos pointsVideos, Database database) async {
    final db = database;

    await db.insert(
      'pointsVideos',
      pointsVideos.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateZones(
      PointsVideos pointsVideos, Database database) async {
    final db = database;

    await db.update(
      'pointsVideos',
      pointsVideos.toMap(),
      where: 'idPointsVideos = ?',
      whereArgs: [pointsVideos.idPointsVideos],
    );
  }

  static Future<void> deletePointsVideos(int id, Database database) async {
    final db = database;

    await db.delete(
      'pointsVideos',
      where: 'idPointsVideos = ?',
      whereArgs: [id],
    );
  }

  static Future<List<PointsVideos>> listPointsVideos(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('pointsVideos');

    return List.generate(maps.length, (i) {
      return PointsVideos(
          idPointsVideos: maps[i]['idPointsVideos'],
          idPoint: maps[i]['idPoint'],
          urlVideo: maps[i]['urlVideo']);
    });
  }
}
