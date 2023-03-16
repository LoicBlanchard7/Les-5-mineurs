import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geofencing/pages/ChoixParcours.dart';
import 'package:geofencing/pages/map.dart';
import 'package:geofencing/pages/reglages.dart';

class AccueilPage extends StatefulWidget {
  const AccueilPage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<AccueilPage> {
  void openPage(page, context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fond_accueil.jpg"),
            opacity: 0.9,
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
                      //color: Color.fromARGB(150, 59, 59, 59),
                      alignment: Alignment.center,
                      child: const Text(
                        'Bienvenue à la mines de Neuves Maison pour sa découverte en extérieur',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
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
                                heroTag: "Map",
                                icon: const Icon(Icons.map, size: 30),
                                label: const Text(
                                  'Ouvrir la carte',
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
                                heroTag: "Parc",
                                icon:
                                    const Icon(Icons.route_outlined, size: 30),
                                label: const Text(
                                  'Choix du parcours',
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
                                            const ChoixParcours()),
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
                                heroTag: "Param",
                                icon: const Icon(Icons.settings, size: 30),
                                label: const Text(
                                  'Paramètres',
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
                                            const ReglagePage()),
                                  );
                                },
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
