import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geofencing/models/coordonnees.dart';
import 'package:geofencing/models/etat.dart';
import 'package:geofencing/models/parcours.dart';
import 'package:geofencing/models/points.dart';
import 'package:geofencing/models/pointsfiles.dart';
import 'package:geofencing/models/pointsvideos.dart';
import 'package:geofencing/models/zones.dart';
import 'package:geofencing/models/zonespoint.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global.dart';

class geofencingBDD {
  static launchdatabase() async {
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
          lastUpdate STRING NOT NULL
        );
      '''); // Fait
        db.execute('''
        CREATE TABLE parcours(
          idParcours INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          duree STRING NOT NULL,
          etape STRING NOT NULL
        );
      '''); // Fait
        db.execute('''
        CREATE TABLE parcoursPoints(
        idParcoursPoints INTEGER PRIMARY KEY AUTOINCREMENT,
        idPoint STRING, 
        idParcour INTEGER,
        FOREIGN KEY (idPoint) REFERENCES points (idPoint),
        FOREIGN KEY (idParcour) REFERENCES parcours (idParcours)
        );
      '''); // Fait

        db.execute('''
        CREATE TABLE points(
          idPoint STRING PRIMARY KEY, 
          titre STRING NOT NULL, 
          contenu STRING , 
          posX double, 
          posY double,
          actualGoal boolean
          );
      '''); // Fait

        db.execute('''
        CREATE TABLE pointsFiles(
          idPointsFiles INTEGER PRIMARY KEY, 
          idPoint STRING, 
          idDirectus STRING NOT NULL,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      '''); // Fait

        db.execute('''
        CREATE TABLE pointsVideos(
          idPointsVideos INTEGER PRIMARY KEY, 
          idPoint STRING, 
          urlVideo STRING NOT NULL,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      '''); // Fait

        db.execute('''
        CREATE TABLE zones(
          idZone INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          idPoint STRING,
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
          item STRING, 
          collection STRING NOT NULL,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      '''); // Fait
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    var point1 = Points(
        idPoint: "0",
        titre: 'Moyen-Âge',
        contenu: "Bahaha alors le moyene âge c'est un truc de dingue",
        posX: 6.108300434237549,
        posY: 48.632316868572445);
    await Points.insertPoints(point1, await database);
    print(Points.listPoints(await database));

    var points2 = Points(
        idPoint: "1",
        titre: 'points2',
        contenu: "CC c'est le contenu",
        posX: 6.108984540809615,
        posY: 48.63241025622807);

    await Points.insertPoints(points2, await database);
    print(await Points.listPoints(await database));

    var etat = const Etat(idEtat: 1, lastUpdate: "2023-02-14T17:35:22");
    await Etat.insertEtat(etat, await database);
    print(await Etat.listEtats(await database));

    const parcours = Parcours(
        idParcours: 1, titre: "parcours1", duree: "00:30:00", etape: ["1"]);
    await Parcours.insertParcours(parcours, await database);
  }

  static initGlobalVariable() async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'geofencingDB.db'),
      );
      print("here");
      final points = await Points.listPoints(database);
      print("here3");
      final etats = await Etat.listEtats(database);
      final parcours = await Parcours.listParcours(database);
      print("here4-");
      final zones = await Zones.listZones(database);
      final coordonnees = await Coordonnees.listCoordonnees(database);
      final zonesPoints = await ZonesPoint.listZonesPoint(database);
      print("here2");
      Global.pointsList = points;
      print(points);
      Global.parcoursList = parcours;
    } catch (e) {}
  }

  insert(String s, Map<String, dynamic> map, {required conflictAlgorithm}) {}

  static void deleteData(Database database) async {
    final ancienPoints = await Points.listPoints(database);
    for (var point in ancienPoints) {
      await Points.deletePoints(point.idPoint, database);
    }

    final ancienEtats = await Etat.listEtats(database);
    for (var etat in ancienEtats) {
      await Etat.deleteEtat(etat.idEtat, database);
    }

    final ancienParcours = await Parcours.listParcours(database);

    final ancienZones = await Zones.listZones(database);
    for (var zone in ancienZones) {
      await Zones.deleteZones(zone.idZone, database);
    }

    final ancienCoordonnees = await Coordonnees.listCoordonnees(database);
    for (var coordonnee in ancienCoordonnees) {
      await Coordonnees.deleteCoordonnees(coordonnee.idCoo, database);
    }

    final ancienZonesPoint = await ZonesPoint.listZonesPoint(database);
    for (var zonesPoint in ancienZonesPoint) {
      await ZonesPoint.deleteZonesPoint(zonesPoint.idZonePoint, database);
    }
  }

  static void UpdateDatabase(Database database) async {
    //deleteData(database);

    const url = 'http://docketu.iutnc.univ-lorraine.fr:51080/Items/';

    //ETAT
    var response = await http.get(Uri.parse("${url}Etat"));
    var json = jsonDecode(response.body);
    var results = json['data'];
    final etat = Etat(idEtat: results['id'], lastUpdate: results['LastUpdate']);
    await Etat.insertEtat(etat, database);

    print(await Etat.listEtats(database));

    //POINT
    response = await http.get(Uri.parse("${url}Points"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final points = results.map((elem) {
      return Points(
          idPoint: elem['id'],
          titre: elem['Titre'],
          contenu: elem['Contenu'],
          posX: elem['Position']['coordinates'][0],
          posY: elem['Position']['coordinates'][1]);
    }).toList();

    for (var point in points) {
      await Points.insertPoints(point, database);
    }

    print(await Points.listPoints(database));

    //POINT_FILES
    response = await http.get(Uri.parse("${url}Points_files"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final points_files = results.map((elem) {
      return PointsFiles(
          idPointsFiles: elem['id'],
          idPoint: elem['Points_id'],
          idDirectus: elem['directus_files_id']);
    }).toList();

    for (var file in points_files) {
      await PointsFiles.insertPointsFiles(file, database);
    }

    print(await PointsFiles.listPointsFiles(database));

    //POINT_VIDEO
    response = await http.get(Uri.parse("${url}Points"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    int index = -1;
    final pointsVideos = results.map((elem) {
      if (elem["URL_video"] != null) {
        print(elem);
        for (var vid in elem["URL_video"]) {
          index++;
          return PointsVideos(
              idPointsVideos: index, idPoint: elem['id'], urlVideo: vid["Url"]);
        }
      }
    });

    print(pointsVideos);
    for (var video in pointsVideos) {
      if (video != null) await PointsVideos.insertPointsVideos(video, database);
    }

    print(await PointsVideos.listPointsVideos(database));

    //ZONES
    response = await http.get(Uri.parse("${url}Zones"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final zones = results.map((elem) {
      return Zones(
        idZone: elem['id'],
        titre: elem['Titre'],
        idPoint: elem['Point_associe'][0],
      );
    }).toList();

    for (var zone in zones) {
      await Zones.insertZones(zone, database);
    }

    print(await Zones.listZones(database));

    //ZONESPOINT
    response = await http.get(Uri.parse("${url}Zones_Point_associe"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final zonepoint = results.map((elem) {
      return ZonesPoint(
          idZonePoint: elem['id'],
          idZone: elem['Zones_id'],
          item: elem['item'],
          collection: elem['collection']);
    }).toList();

    for (var point in zonepoint) {
      await ZonesPoint.insertZonesPoint(point, database);
    }

    print(await ZonesPoint.listZonesPoint(database));

    //COORDONNEES
    response = await http.get(Uri.parse("${url}Zones"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    index = -1;
    final coords = results.map((elem) {
      for (var cord in elem['Position']["coordinates"][0]) {
        index++;
        return Coordonnees(
            idCoo: index, idZone: elem['id'], posX: cord[0], posY: cord[1]);
      }
    }).toList();

    for (var coordonnee in coords) {
      if (coordonnee != null) {
        await Coordonnees.insertCoordonnees(coordonnee, database);
      }
    }

    print(await Coordonnees.listCoordonnees(database));

    //PARCOURS
    response = await http.get(Uri.parse("${url}Parcours"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final parcours = results.map((elem) {
      return Parcours(
        idParcours: elem['id'],
        titre: elem['Titre'],
        duree: elem['Duree'],
        etape: elem['Etape'],
      );
    }).toList();

    for (var parcour in parcours) {
      await Parcours.insertParcours(parcour, database);
    }

    print(await Parcours.listParcours(database));
  }
}
