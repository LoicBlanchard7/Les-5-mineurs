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
      // When the database is first created, create a table to store dogs.
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
        db.execute('''
        CREATE TABLE zonesPoint(
          idZonePoint INTEGER PRIMARY KEY, 
          idZone INTEGER, 
          item STRING NOT NULL, 
          collection STRING NOT NULL,
          FOREIGN KEY (idZone) REFERENCES zones (idZone)
        );
      '''); // Fait
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name STRING NOT NULL, age INTEGER);',
        ); // Fait
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Define a function that inserts dogs into the database
    Future<void> insertDog(Dog dog) async {
      // Get a reference to the database.
      final db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // A method that retrieves all the dogs from the dogs table.
    Future<List<Dog>> dogs() async {
      // Get a reference to the database.
      final db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('dogs');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

    Future<void> updateDog(Dog dog) async {
      // Get a reference to the database.
      final db = await database;

      // Update the given Dog.
      await db.update(
        'dogs',
        dog.toMap(),
        // Ensure that the Dog has a matching id.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [dog.id],
      );
    }

    Future<void> deleteDog(int id) async {
      // Get a reference to the database.
      final db = await database;

      // Remove the Dog from the database.
      await db.delete(
        'dogs',
        // Use a `where` clause to delete a specific dog.
        where: 'id = ?',
        // Pass the Dog's id as a whereArg to prevent SQL injection.
        whereArgs: [id],
      );
    }

    /////////

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
        'dogs',
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

    // Create a Dog and add it to the dogs table
    var fido = const Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    await insertDog(fido);

    // Now, use the method above to retrieve all the dogs.
    print(await dogs());
    print("truc");

    // Update Fido's age and save it to the database.
    fido = Dog(
      id: fido.id,
      name: fido.name,
      age: fido.age + 7,
    );
    await updateDog(fido);

    // Print the updated results.
    if (kDebugMode) {
      print(await dogs());
    } // Prints Fido with age 42.

    // Delete Fido from the database.
    await deleteDog(fido.id);

    // Print the list of dogs (empty).
    if (kDebugMode) {
      print(await dogs());
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

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}
