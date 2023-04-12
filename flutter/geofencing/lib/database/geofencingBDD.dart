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
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(await getDatabasesPath(), 'geofencingDB.db'),
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE etat(
          idEtat INTEGER PRIMARY KEY, 
          lastUpdate STRING NOT NULL
        );
      ''');
        db.execute('''
        CREATE TABLE parcours(
          idParcours INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          duree STRING NOT NULL,
          etape STRING NOT NULL
        );
      ''');
        db.execute('''
        CREATE TABLE parcoursPoints(
        idParcoursPoints INTEGER PRIMARY KEY AUTOINCREMENT,
        idPoint STRING, 
        idParcour INTEGER,
        FOREIGN KEY (idPoint) REFERENCES points (idPoint),
        FOREIGN KEY (idParcour) REFERENCES parcours (idParcours)
        );
      ''');
        db.execute('''
        CREATE TABLE points(
          idPoint STRING PRIMARY KEY, 
          titre STRING NOT NULL, 
          contenu STRING , 
          posX double, 
          posY double,
          actualGoal boolean
          );
      ''');
        db.execute('''
        CREATE TABLE pointsFiles(
          idPointsFiles INTEGER PRIMARY KEY, 
          idPoint STRING, 
          idDirectus STRING NOT NULL,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      ''');
        db.execute('''
        CREATE TABLE pointsVideos(
          idPointsVideos INTEGER PRIMARY KEY , 
          idPoint STRING, 
          urlVideo STRING NOT NULL,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      ''');
        db.execute('''
        CREATE TABLE zones(
          idZone INTEGER PRIMARY KEY, 
          titre STRING NOT NULL, 
          idPoint STRING,
          FOREIGN KEY (idPoint) REFERENCES points (idPoint)
        );
      ''');
        db.execute('''
        CREATE TABLE coordonnees(
          idCoo INTEGER PRIMARY KEY, 
          idZone INTEGER, 
          posX double, 
          posY double,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      ''');
        return db.execute('''
        CREATE TABLE zonesPoint(
          idZonePoint INTEGER PRIMARY KEY, 
          idZone INTEGER, 
          item STRING, 
          collection STRING NOT NULL,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      ''');
      },
      version: 1,
    );

    if (await Etat.getEtat(await database) == null) {
      var point1 = Points(
          idPoint: "a9cf4eab-ee9a-40a0-8a32-bdd4c7027075",
          titre: "Château d'eau",
          contenu:
              "La château d'eau est une construction placée sur un sommet géographique. Il permet de stocker de l'eau et de fournir le réseau de distribution en eau sous pression.",
          posX: 6.108300434237549,
          posY: 48.632316868572445);
      await Points.insertPoints(point1, await database);

      var points2 = Points(
          idPoint: "ed1469f4-77ac-4a9d-bc8d-a2e1acb8bfb7",
          titre: 'Entrée',
          contenu:
              "L'entrée de la mine a été rénové depuis son existence. Néanmoins cette dernière est la même depuis le début. Les mineurs y passaient pour entrer dans la mine et aller travailler.",
          posX: 6.108984540809615,
          posY: 48.63241025622807);

      await Points.insertPoints(points2, await database);

      var etat = const Etat(
          idEtat: 1,
          lastUpdate:
              "Tue Apr 11 2023 12:29:56 GMT+0000 (Coordinated Universal Time)");
      await Etat.insertEtat(etat, await database);

      const parcours = Parcours(
          idParcours: 1, titre: "parcours1", duree: "00:30:00", etape: ["1"]);
      await Parcours.insertParcours(parcours, await database);

      const videos = PointsVideos(
          idPointsVideos: 1,
          idPoint: "ed1469f4-77ac-4a9d-bc8d-a2e1acb8bfb7",
          urlVideo:
              "https://www.youtube.com/watch?v=431G8qVeslM&ab_channel=VincentFerry");
      await PointsVideos.insertPointsVideos(videos, await database);

      const files = PointsFiles(
          idPointsFiles: 1,
          idPoint: "ed1469f4-77ac-4a9d-bc8d-a2e1acb8bfb7",
          idDirectus: "7e6476cf-73a2-4a6f-9653-a61e08520651");
      await PointsFiles.insertPointsFiles(files, await database);

      const zones = Zones(
          idZone: 1,
          titre: "Colline",
          idPoint: "ed1469f4-77ac-4a9d-bc8d-a2e1acb8bfb7");
      await Zones.insertZones(zones, await database);

      const coordonnees1 = Coordonnees(
          idCoo: 1, idZone: 1, posX: 6.10871480295512, posY: 48.63246285404148);
      const coordonnees2 = Coordonnees(
          idCoo: 2,
          idZone: 1,
          posX: 6.108598872116033,
          posY: 48.63223300204797);
      const coordonnees3 = Coordonnees(
          idCoo: 3,
          idZone: 1,
          posX: 6.10909283830145,
          posY: 48.632213014868825);

      await Coordonnees.insertCoordonnees(coordonnees1, await database);
      await Coordonnees.insertCoordonnees(coordonnees2, await database);
      await Coordonnees.insertCoordonnees(coordonnees3, await database);
    }
  }

  static initGlobalVariable() async {
    try {
      final database = await openDatabase(
        join(await getDatabasesPath(), 'geofencingDB.db'),
      );
      final points = await Points.listPoints(database);
      final parcours = await Parcours.listParcours(database);
      final coordonnees = await Coordonnees.listCoordonnees(database);
      final zonesPoints = await ZonesPoint.listZonesPoint(database);
      final zones = await Zones.listZones(database);

      final pointsFiles = await PointsFiles.listPointsFiles(database);
      final pointVideos = await PointsVideos.listPointsVideos(database);

      Global.pointsList = points;
      Global.parcoursList = parcours;

      Global.pointsFiles = pointsFiles;
      Global.pointVideos = pointVideos;
      Global.coordonneesList = coordonnees;
      Global.zonesList = zones;
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
    for (var parcours in ancienParcours) {
      await Parcours.deleteParcours(parcours.idParcours, database);
    }

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

    final ancienPointsFiles = await PointsFiles.listPointsFiles(database);
    for (var pointsFiles in ancienPointsFiles) {
      await PointsFiles.deletePointsFiles(pointsFiles.idPointsFiles, database);
    }

    final ancienPointsVideos = await PointsVideos.listPointsVideos(database);
    for (var pointsVideos in ancienPointsVideos) {
      await PointsVideos.deletePointsVideos(
          pointsVideos.idPointsVideos, database);
    }
  }

  static void UpdateDatabase(Database database) async {
    deleteData(database);

    const url = 'https://iut.netlor.fr/items/';

    //ETAT
    var response = await http.get(Uri.parse("${url}Etat"));
    var json = jsonDecode(response.body);
    var results = json['data'][0];
    final etat = Etat(idEtat: results['id'], lastUpdate: results['LastUpdate']);
    final etattest = Etat(idEtat: results['id'], lastUpdate: "nik");
    await Etat.insertEtat(etattest, database);

    print(await Etat.listEtats(database));

    //POINT
    response = await http.get(Uri.parse("${url}Point"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final points = results.map((elem) {
      return Points(
          idPoint: elem['uid'],
          titre: elem['Titre'],
          contenu: elem['Description'],
          posX: elem['Position']['coordinates'][0],
          posY: elem['Position']['coordinates'][1]);
    }).toList();

    for (var point in points) {
      await Points.insertPoints(point, database);
    }

    print(await Points.listPoints(database));

    //POINT_FILES
    response = await http.get(Uri.parse("${url}Point_files"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final points_files = results.map((elem) {
      if (elem['Point_uid'] == null) {
        elem['Point_uid'] = "null";
      }
      return PointsFiles(
          idPointsFiles: elem['id'],
          idPoint: elem['Point_uid'],
          idDirectus: elem['directus_files_id']);
    }).toList();

    for (var file in points_files) {
      await PointsFiles.insertPointsFiles(file, database);
    }
    print(await PointsFiles.listPointsFiles(database));

    //POINT_VIDEO
    response = await http.get(Uri.parse("${url}Point"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    var listVid = await PointsVideos.listPointsVideos(database);
    int index = listVid.length;
    var listvideo = [];
    print('point vidéo');

    results.forEach((element) {
      if (element['Url_video'] != null) {
        element['Url_video'].forEach((elem) {
          print(elem);
          listvideo.add(PointsVideos(
              idPointsVideos: index,
              idPoint: element['uid'],
              urlVideo: elem['Lien']));
          index++;
        });
      }
    });

    for (var video in listvideo) {
      if (video != null) await PointsVideos.insertPointsVideos(video, database);
    }

    print(await PointsVideos.listPointsVideos(database));

    //ZONES
    response = await http.get(Uri.parse("${url}Zone"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final zones = results.map((elem) {
      return Zones(
        idZone: elem['id'],
        titre: elem['Titre'],
        idPoint: elem['point_associe'][0],
      );
    }).toList();

    for (var zone in zones) {
      await Zones.insertZones(zone, database);
    }

    print(await Zones.listZones(database));

    //COORDONNEES
    response = await http.get(Uri.parse("${url}Zone"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    var listco = await Coordonnees.listCoordonnees(database);
    index = listco.length;
    var listcoo = [];

    results.forEach((element) {
      element['Position']["coordinates"][0].forEach((elem) {
        index++;
        print(elem);
        listcoo.add(Coordonnees(
            idCoo: index, idZone: element['id'], posX: elem[0], posY: elem[1]));
      });
    });

    print(listcoo);
    for (var coordonnee in listcoo) {
      if (coordonnee != null) {
        print("ici");
        await Coordonnees.insertCoordonnees(coordonnee, database);
      }
    }
    //PARCOURS
    response = await http.get(Uri.parse("${url}Parcours"));
    json = jsonDecode(response.body);
    results = json['data'] as List<dynamic>;
    final parcours = results.map((elem) {
      print(elem['Etape']);
      return Parcours(
        idParcours: elem['id'],
        titre: elem['Titre'],
        duree: elem['Duree'],
        etape: jsonDecode(jsonEncode(elem['Etape'])).cast<String>().toList(),
      );
    }).toList();

    for (var parcour in parcours) {
      await Parcours.insertParcours(parcour, database);
    }

    print(await Parcours.listParcours(database));

    Global.pointsList = await Points.listPoints(database);
    Global.parcoursList = await Parcours.listParcours(database);

    Global.pointsFiles = await PointsFiles.listPointsFiles(database);
    Global.pointVideos = await PointsVideos.listPointsVideos(database);
    Global.coordonneesList = await Coordonnees.listCoordonnees(database);
    Global.zonesList = await Zones.listZones(database);
  }
}
