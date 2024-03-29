import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geofencing/pages/map.dart';
import 'package:geofencing/pages/credit.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:geofencing/database/geofencingBDD.dart';
import 'package:sqflite/sqflite.dart';

import 'package:geofencing/models/etat.dart';

class ReglagePage extends StatefulWidget {
  const ReglagePage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<ReglagePage> {
  bool isLoading = false;

  void _onButtonClicked() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      isLoading = false;
    });
  }

  void isUpDate(context) async {
    try {
      print('fetchData called');
      const url = 'https://iut.netlor.fr/items/Etat';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      final results = json['data'][0];
      final updateApi = hash(results['LastUpdate']);

      final database = await openDatabase(
        join(await getDatabasesPath(), 'geofencingDB.db'),
      );

      List<Etat> etats = await Etat.listEtats(await database);
      final updateBDD = hash(etats[0].lastUpdate);
      if (updateApi != updateBDD) {
        print("Mise à jour de la BDD");
        geofencingBDD.UpdateDatabase(database);
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
                      )),
                  isLoading ? const LoadingScreen() : const SizedBox(),
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
                                ),
                                backgroundColor: !isLoading
                                    ? Colors.black
                                    : const Color.fromARGB(255, 158, 156, 156),
                                onPressed: !isLoading
                                    ? () {
                                        _onButtonClicked();
                                        isUpDate(context);
                                      }
                                    : null,
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
                                ),
                                backgroundColor: !isLoading
                                    ? Colors.black
                                    : const Color.fromARGB(255, 158, 156, 156),
                                onPressed: !isLoading
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MapPage()),
                                        );
                                      }
                                    : null,
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
                                backgroundColor: !isLoading
                                    ? Colors.black
                                    : const Color.fromARGB(255, 158, 156, 156),
                                onPressed: !isLoading
                                    ? () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreditPage()),
                                        );
                                      }
                                    : null,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Téléchargement des données...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 16.0),
        CircularProgressIndicator(),
      ],
    );
  }
}
