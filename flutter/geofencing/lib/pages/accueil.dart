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
            image: AssetImage('assets/fond_accueil.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Text(
              '\n\nBienvenue à la mines de neuves maison pour sa découverte en extérieur\n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 75,
                color: Colors.white,
                decoration: TextDecoration.none,
                shadows: [Shadow(blurRadius: 3, color: Colors.black)],
              ),
            ),
            FloatingActionButton.extended(
              label: const Text(
                'Ouvrir la carte',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ), // <-- Text
              backgroundColor: Colors.black,
              icon: const Icon(
                Icons.map,
                size: 50.0,
              ),
              onPressed: () {
                if (kDebugMode) {
                  print('map');
                }
                openPage(const MapPage(), context);
              },
            ),
            const Text(''),
            FloatingActionButton.extended(
              label: const Text(
                'Choix de parcours',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ), // <-- Text
              backgroundColor: Colors.black,
              icon: const Icon(
                Icons.route_outlined,
                size: 50.0,
              ),
              onPressed: () {
                openPage(const ChoixParcours(), context);
              },
            ),
            const Text(''),
            FloatingActionButton.extended(
              label: const Text(
                'Paramètres',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ), // <-- Text
              backgroundColor: Colors.black,
              icon: const Icon(
                Icons.settings,
                size: 50.0,
              ),
              onPressed: () {
                openPage(const ReglagePage(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
