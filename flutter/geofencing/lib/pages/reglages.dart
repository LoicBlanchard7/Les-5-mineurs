import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geofencing/pages/map.dart';
import 'package:geofencing/pages/credit.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:geofencing/database/geofencingBDD.dart';
import 'package:sqflite/sqflite.dart';

import 'package:geofencing/models/coordonnees.dart';
import 'package:geofencing/models/etat.dart';
import 'package:geofencing/models/parcours.dart';
import 'package:geofencing/models/parcourspoints.dart';
import 'package:geofencing/models/points.dart';
import 'package:geofencing/models/pointsfiles.dart';
import 'package:geofencing/models/pointsvideos.dart';
import 'package:geofencing/models/zones.dart';
import 'package:geofencing/models/zonespoint.dart';

class ReglagePage extends StatefulWidget {
  const ReglagePage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<ReglagePage> {
  void isUpDate(context) async {
    try {
      print('fetchData called');
      const url = 'http://docketu.iutnc.univ-lorraine.fr:51080/Items/Etat';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final results = json['data'];
      final updateApi = hash(results['LastUpdate']);
      print(results['LastUpdate']);

      final database = await openDatabase(
        join(await getDatabasesPath(), 'geofencingDB.db'),
      );

      List<Etat> etats = await Etat.listEtats(await database);
      final updateBDD = hash(etats[0].lastUpdate);
      print(etats[0].lastUpdate);

      if (updateApi != updateBDD) {
        print("FAUT METTRE A JOUR ENCULE");
        geofencingBDD.UpdateDatabase(database);
      } else {
        print("C'EST A JOUR FDP");
      }
    } catch (e) {
      _showMyDialog(context);
    }
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Problème de connexion'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                      'Nous avons rencontré un problème de connexion, veuillez vérifiez votre connexion internet.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Je comprends'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fond_reglages.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              child: SafeArea(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Paramètres',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        //overflow: TextOverflow.ellipsis,
                        //maxLines: 2,
                      )),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 40, top: 40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: FloatingActionButton.extended(
                                heroTag: "Update",
                                icon: const Icon(Icons.update, size: 30),
                                label: const Text(
                                  'Mettre à jour les données',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ), // <-- Text
                                backgroundColor: Colors.black,
                                // icon: const Icon(Icons.arrow_back_ios_sharp),
                                onPressed: () {
                                  isUpDate(context);
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: FloatingActionButton.extended(
                                heroTag: "Carte",
                                icon: const Icon(Icons.map, size: 30),
                                label: const Text(
                                  'Retour à la carte',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ), // <-- Text
                                backgroundColor: Colors.black,
                                // icon: const Icon(Icons.arrow_back_ios_sharp),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MapPage()),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 40),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: FloatingActionButton.extended(
                                heroTag: "credit",
                                icon: const Icon(Icons.settings, size: 30),
                                label: const Text(
                                  'Crédits',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ), // <-- Text
                                backgroundColor: Colors.black,
                                // icon: const Icon(Icons.arrow_back_ios_sharp),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreditPage()),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    backgroundColor: Colors.blue,
                    icon: const Icon(Icons.system_update),
                    onPressed: () {
                      isUpDate(context);
                    },
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}
