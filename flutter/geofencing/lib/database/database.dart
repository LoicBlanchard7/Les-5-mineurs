import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geofencing/models/coordonnees.dart';
import 'package:geofencing/models/etat.dart';
import 'package:geofencing/models/parcours.dart';
import 'package:geofencing/models/parcourspoints.dart';
import 'package:geofencing/models/points.dart';
import 'package:geofencing/models/pointsfiles.dart';
import 'package:geofencing/models/zones.dart';
import 'package:geofencing/models/zonespoint.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Database {
  void main() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();

    // Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'geofencingDB.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        db.execute('''
        CREATE TABLE etat(
          idEtat INTEGER PRIMARY KEY, 
          lastUpdate Date
        );
      '''); // Fait
        db.execute('''
        CREATE TABLE parcours(
          idParcours INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          duree STRING NOT NULL
        );
      '''); // Fait
        db.execute('''
        CREATE TABLE parcoursPoints(
        idParcoursPoints INTEGER PRIMARY KEY AUTOINCREMENT,
        idPoint INTEGER, 
        idParcour INTEGER,
        FOREIGN KEY (idPoint) REFERENCES points (idPoint),
        FOREIGN KEY (idParcour) REFERENCES parcours (idParcours)
        );
      '''); // Fait

        db.execute('''
        CREATE TABLE points(
          idPoint INTEGER PRIMARY KEY AUTOINCREMENT, 
          titre STRING NOT NULL, 
          contenu STRING NOT NULL, 
          posX double, 
          posY double, 
          images STRING NOT NULL, 
          url_video STRING NOT NULL
          );
      '''); // Fait

        db.execute('''
        CREATE TABLE pointsFiles(
          idPointsFiles INTEGER PRIMARY KEY, 
          idPoint INTEGER, 
          idDirectus STRING NOT NULL,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      '''); // Fait

        db.execute('''
        CREATE TABLE zones(
          idZone INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          idPoint INTEGER,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      '''); // Fait
        db.execute('''
        CREATE TABLE coordonnees(
          idCoo INTEGER PRIMARY KEY, 
          idZone INTEGER, 
          posX double, 
          posY double,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      '''); // Fait
        return db.execute('''
        CREATE TABLE zonesPoint(
          idZonePoint INTEGER PRIMARY KEY, 
          idZone INTEGER, 
          item STRING NOT NULL, 
          collection STRING NOT NULL,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      '''); // Fait
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    Future<void> insertEtat(Etat etat) async {
      final db = await database;

      await db.insert(
        'etat',
        etat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertParcours(Parcours parcours) async {
      final db = await database;

      await db.insert(
        'parcours',
        parcours.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertParcoursPoints(ParcoursPoints parcoursPoints) async {
      final db = await database;

      await db.insert(
        'parcoursPoints',
        parcoursPoints.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertPoints(Points points) async {
      final db = await database;

      await db.insert(
        'points',
        points.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertPointsFiles(PointsFiles pointsFiles) async {
      final db = await database;

      await db.insert(
        'pointsFiles',
        pointsFiles.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertZones(Zones zones) async {
      final db = await database;

      await db.insert(
        'zones',
        zones.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertCoordonnees(Coordonnees coordonnees) async {
      final db = await database;

      await db.insert(
        'coordonnees',
        coordonnees.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> insertZonesPoint(ZonesPoint zonesPoint) async {
      final db = await database;

      await db.insert(
        'zonesPoint',
        zonesPoint.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    Future<void> updateEtat(Etat etat) async {
      final db = await database;

      await db.update(
        'etat',
        etat.toMap(),
        where: 'id = ?',
        whereArgs: [etat.idEtat],
      );
    }

    Future<void> updateParcours(Parcours parcours) async {
      final db = await database;

      await db.update(
        'parcours',
        parcours.toMap(),
        where: 'id = ?',
        whereArgs: [parcours.idParcours],
      );
    }

    Future<void> updateParcoursPoints(ParcoursPoints parcoursPoints) async {
      final db = await database;

      await db.update(
        'parcoursPoints',
        parcoursPoints.toMap(),
        where: 'id = ?',
        whereArgs: [parcoursPoints.idParcoursPoints],
      );
    }

    Future<void> updatePoints(Points points) async {
      final db = await database;

      await db.update(
        'points',
        points.toMap(),
        where: 'id = ?',
        whereArgs: [points.idPoint],
      );
    }

    Future<void> updatePointsFiles(PointsFiles pointsFiles) async {
      final db = await database;

      await db.update(
        'pointsFiles',
        pointsFiles.toMap(),
        where: 'id = ?',
        whereArgs: [pointsFiles.idPointsFiles],
      );
    }

    Future<void> updateZones(Zones zones) async {
      final db = await database;

      await db.update(
        'zones',
        zones.toMap(),
        where: 'id = ?',
        whereArgs: [zones.idZone],
      );
    }

    Future<void> updateCoordonnees(Coordonnees coordonnees) async {
      final db = await database;

      await db.update(
        'coordonnees',
        coordonnees.toMap(),
        where: 'id = ?',
        whereArgs: [coordonnees.idCoo],
      );
    }

    Future<void> updateZonesPoint(ZonesPoint zonesPoint) async {
      final db = await database;

      await db.update(
        'zonesPoint',
        zonesPoint.toMap(),
        where: 'id = ?',
        whereArgs: [zonesPoint.idZonePoint],
      );
    }

    Future<void> deleteEtat(int id) async {
      final db = await database;

      await db.delete(
        'etat',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deleteParcours(int id) async {
      final db = await database;

      await db.delete(
        'parcours',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deleteParcoursPoints(int id) async {
      final db = await database;

      await db.delete(
        'parcoursPoints',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deletePoints(int id) async {
      final db = await database;

      await db.delete(
        'points',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deletePointsFiles(int id) async {
      final db = await database;

      await db.delete(
        'pointsFiles',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deleteZones(int id) async {
      final db = await database;

      await db.delete(
        'zones',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deleteCoordonnees(int id) async {
      final db = await database;

      await db.delete(
        'coordonnees',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<void> deleteZonesPoint(int id) async {
      final db = await database;

      await db.delete(
        'zonesPoint',
        where: 'id = ?',
        whereArgs: [id],
      );
    }

    Future<List<Etat>> listEtats() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('etat');

      return List.generate(maps.length, (i) {
        return Etat(
          idEtat: maps[i]['idEtat'],
          lastUpdate: maps[i]['lastUpdate'],
        );
      });
    }

    Future<List<Parcours>> listParcours() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('parcours');

      return List.generate(maps.length, (i) {
        return Parcours(
            idParcours: maps[i]['idParcours'],
            titre: maps[i]['titre'],
            duree: maps[i]['duree']);
      });
    }

    Future<List<ParcoursPoints>> listParcoursPoints() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('parcoursPoints');

      return List.generate(maps.length, (i) {
        return ParcoursPoints(
            idParcoursPoints: maps[i]['idParcoursPoints'],
            idPoint: maps[i]['idPoint'],
            idParcour: maps[i]['idParcour']);
      });
    }

    Future<List<Points>> listPoints() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('points');

      return List.generate(maps.length, (i) {
        return Points(
            idPoint: maps[i]['idPoint'],
            titre: maps[i]['titre'],
            contenu: maps[i]['contenu'],
            posX: maps[i]['posX'],
            posY: maps[i]['posY'],
            images: maps[i]['images'],
            url_video: maps[i]['url_video']);
      });
    }

    Future<List<PointsFiles>> listPointsFiles() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('pointsFiles');

      return List.generate(maps.length, (i) {
        return PointsFiles(
            idPointsFiles: maps[i]['idPointsFiles'],
            idPoint: maps[i]['idPoint'],
            idDirectus: maps[i]['idDirectus']);
      });
    }

    Future<List<Zones>> listZones() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('zones');

      return List.generate(maps.length, (i) {
        return Zones(
            idZone: maps[i]['idZone'],
            titre: maps[i]['titre'],
            idPoint: maps[i]['idPoint']);
      });
    }

    Future<List<Coordonnees>> listCoordonnees() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('coordonnees');

      return List.generate(maps.length, (i) {
        return Coordonnees(
            idCoo: maps[i]['idCoo'],
            idZone: maps[i]['idZone'],
            posY: maps[i]['posY'],
            posX: maps[i]['posX']);
      });
    }

    Future<List<ZonesPoint>> listZonesPoint() async {
      final db = await database;

      final List<Map<String, dynamic>> maps = await db.query('zonesPoint');

      return List.generate(maps.length, (i) {
        return ZonesPoint(
          idZonePoint: maps[i]['idZonePoint'],
          idZone: maps[i]['idZone'],
          item: maps[i]['item'],
          collection: maps[i]['collection'],
        );
      });
    }

    var point1 = const Points(
      idPoint: 0,
      titre: 'Moyen-Âge',
      contenu: "Bahaha alors le moyene âge c'est un truc de dingue",
      posX: 3.4,
      posY: 2.5,
      images: "yapa.png",
      url_video: "https://www.youtube.com/watch?v=TWMEdqBYIxU",
    );
    await insertPoints(point1);
    if (kDebugMode) {
      print(await listPoints());
    }

    var points2 = const Points(
      idPoint: 0,
      titre: 'points2',
      contenu: "CC c'est le contenu",
      posX: 2.14,
      posY: 2.190,
      images: " lien.png",
      url_video: " https://www.youtube.com/watch?v=TWMEdqBYIxU",
    );

    await insertPoints(points2);
    if (kDebugMode) {
      print(await listPoints());
    }
  }
}
