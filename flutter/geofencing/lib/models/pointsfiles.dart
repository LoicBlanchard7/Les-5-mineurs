import 'package:sqflite/sqflite.dart';

class PointsFiles {
  final int idPointsFiles;
  final int idPoint;
  final String idDirectus;

  const PointsFiles({
    required this.idPointsFiles,
    required this.idPoint,
    required this.idDirectus,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPointsFiles': idPointsFiles,
      'idPoint': idPoint,
      'idDirectus': idDirectus,
    };
  }

  @override
  String toString() {
    return 'PointsFiles{idPointsFiles: $idPointsFiles, idPoint: $idPoint, idDirectus: $idDirectus}';
  }

  static Future<void> insertPointsFiles(
      PointsFiles pointsFiles, Database database) async {
    final db = database;

    await db.insert(
      'pointsFiles',
      pointsFiles.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updatePointsFiles(
      PointsFiles pointsFiles, Database database) async {
    final db = database;

    await db.update(
      'pointsFiles',
      pointsFiles.toMap(),
      where: 'idPointsFiles = ?',
      whereArgs: [pointsFiles.idPointsFiles],
    );
  }

  static Future<void> deletePointsFiles(int id, Database database) async {
    final db = database;

    await db.delete(
      'pointsFiles',
      where: 'idPointsFiles = ?',
      whereArgs: [id],
    );
  }

  static Future<List<PointsFiles>> listPointsFiles(Database database) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('pointsFiles');

    return List.generate(maps.length, (i) {
      return PointsFiles(
          idPointsFiles: maps[i]['idPointsFiles'],
          idPoint: maps[i]['idPoint'],
          idDirectus: maps[i]['idDirectus']);
    });
  }
}
