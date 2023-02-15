import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      db.execute(
        'CREATE TABLE etat(idEtat INTEGER PRIMARY KEY, lastUpdate Date);',
      ); // Fait
      db.execute(
        'CREATE TABLE parcours(idParcours INTEGER PRIMARY KEY, titre TEXT, duree TEXT);',
      ); // Fait
      db.execute(
        'CREATE TABLE parcoursPoints(idParcoursPoints INTEGER PRIMARY KEY, idPoint INTEGER FOREIGN KEY, idParcour INTEGER FOREIGN KEY);',
      ); // Fait
      db.execute(
        'CREATE TABLE points(idPoint INTEGER PRIMARY KEY, titre TEXT, contenu TEXT, posX TEXT, posY TEXT, images TEXT, URL_video TEXT);',
      ); // Fait
      db.execute(
        'CREATE TABLE pointsFiles(idPointsFiles INTEGER PRIMARY KEY, idPoint INTEGER FOREIGN KEY, idDirectus TEXT);',
      ); // Fait
      db.execute(
        'CREATE TABLE zones(idZone INTEGER PRIMARY KEY, titre TEXT, idPoint INTEGER FOREIGN KEY);',
      ); // Fait
      db.execute(
        'CREATE TABLE coordonnees(idCoo INTEGER PRIMARY KEY, idZone INTEGER FOREIGN KEY, PosX TEXT, PosY TEXT);',
      ); // Fait
      db.execute(
        'CREATE TABLE zonesPoint(idZonePoint INTEGER PRIMARY KEY, idZone INTEGER FOREIGN KEY, item TEXT, collection TEXT);',
      ); // Fait
      return db.execute(
        'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER);',
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
          urlVideo: maps[i]['urlVideo']);
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
  print(await dogs()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  fido = Dog(
    id: fido.id,
    name: fido.name,
    age: fido.age + 7,
  );
  await updateDog(fido);

  // Print the updated results.
  print(await dogs()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteDog(fido.id);

  // Print the list of dogs (empty).
  print(await dogs());

  var point1 = const Points(
    idPoint: 0,
    titre: 'Moyen-Âge',
    contenu: "Bahaha alors le moyene âge c'est un truc de dingue",
    posX: "2",
    posY: "2",
    images: "yapa.png",
    urlVideo: "https://www.youtube.com/watch?v=TWMEdqBYIxU",
  );
  await insertPoints(point1);
  if (kDebugMode) {
    print(await dogs());
  }

  var points2 = const Points(
    idPoint: 0,
    titre: 'points2',
    contenu: "CC c'est le contenu",
    posX: "2,14",
    posY: "2,190",
    images: " lien.png",
    urlVideo: " https://www.youtube.com/watch?v=TWMEdqBYIxU",
  );

  await insertPoints(points2);
  if (kDebugMode) {
    print(await dogs());
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

class Etat {
  final int idEtat;
  final DateTime lastUpdate;

  const Etat({
    required this.idEtat,
    required this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    return {
      'idEtat': idEtat,
      'lastUpdate': lastUpdate,
    };
  }

  @override
  String toString() {
    return 'Etat{idEtat: $idEtat, lastUpdate: $lastUpdate}';
  }
}

class Parcours {
  final int idParcours;
  final String titre;
  final int duree;

  const Parcours({
    required this.idParcours,
    required this.titre,
    required this.duree,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcours': idParcours,
      'titre': titre,
      'duree': duree,
    };
  }

  @override
  String toString() {
    return 'Parcours{id: $idParcours, name: $titre, age: $duree}';
  }
}

class ParcoursPoints {
  final int idParcoursPoints;
  final int idPoint;
  final int idParcour;

  const ParcoursPoints({
    required this.idParcoursPoints,
    required this.idPoint,
    required this.idParcour,
  });

  Map<String, dynamic> toMap() {
    return {
      'idParcoursPoints': idParcoursPoints,
      'idPoint': idPoint,
      'idParcour': idParcour,
    };
  }

  @override
  String toString() {
    return 'ParcoursPoints{idParcoursPoints: $idParcoursPoints, idPoint: $idPoint, idParcour: $idParcour}';
  }
}

class Points {
  final int idPoint;
  final String titre;
  final String contenu;
  final String posX;
  final String posY;
  final String images;
  final String urlVideo;

  const Points({
    required this.idPoint,
    required this.titre,
    required this.contenu,
    required this.posX,
    required this.posY,
    required this.images,
    required this.urlVideo,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPoint': idPoint,
      'titre': titre,
      'contenu': contenu,
      'posX': posX,
      'posY': posY,
      'images': images,
      'urlVideo': urlVideo,
    };
  }

  @override
  String toString() {
    return 'Points{idPoint: $idPoint, titre: $titre , contenu: $contenu , posX: $posX, posY: $posY , images: $images, urlVideo: $urlVideo   }';
  }
}

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
    return 'PointsFiles{idParcoursPoints: $idPointsFiles, idPoint: $idPoint, idDirectus: $idDirectus}';
  }
}

class Zones {
  final int idZone;
  final String titre;
  final int idPoint;

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
}

class Coordonnees {
  final int idCoo;
  final int idZone;
  final String posX;
  final String posY;

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
}

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
}
