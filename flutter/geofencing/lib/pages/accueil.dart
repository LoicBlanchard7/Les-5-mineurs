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
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fond_accueil.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    '\n\nBienvenue à la mines\nde Neuves Maison\npour sa découverte\nen extérieur\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                    ),
                  ),
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
      ),
    );
  }
}
