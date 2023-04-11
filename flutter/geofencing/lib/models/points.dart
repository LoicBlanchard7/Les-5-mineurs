import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'pointsvideos.dart';

class Points {
  final String idPoint;
  final String titre;
  final String contenu;
  final double posX;
  final double posY;
  bool actualGoal;
  Icon icon;

  Points({
    required this.idPoint,
    required this.titre,
    required this.contenu,
    required this.posX,
    required this.posY,
    this.actualGoal = false,
    this.icon = const Icon(Icons.my_location, color: Colors.green, size: 25),
  });

  Map<String, dynamic> toMap() {
    return {
      'idPoint': idPoint,
      'titre': titre,
      'contenu': contenu,
      'posX': posX,
      'posY': posY
    };
  }

  @override
  String toString() {
    return 'Points{idPoint: $idPoint, titre: $titre , contenu: $contenu , posX: $posX, posY: $posY}';
  }

  static Future<void> insertPoints(Points points, Database database) async {
    final db = database;

    await db.insert(
      'points',
      points.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updatePoints(Points points, Database database) async {
    final db = database;

    await db.update(
      'points',
      points.toMap(),
      where: 'idPoint = ?',
      whereArgs: [points.idPoint],
    );
  }

  static Future<void> deletePoints(String id, Database database) async {
    final db = database;

    await db.delete(
      'points',
      where: 'idPoint = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Points>> listPoints(Database database) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('points');

    return List.generate(maps.length, (i) {
      return Points(
          idPoint: maps[i]['idPoint'].toString(),
          titre: maps[i]['titre'],
          contenu: maps[i]['contenu'],
          posX: maps[i]['posX'],
          posY: maps[i]['posY']);
    });
  }
}
