import 'package:flutter/material.dart';
import 'package:geofencing/pages/map.dart';
import 'package:geofencing/pages/credit.dart';

class ReglagePage extends StatefulWidget {
  const ReglagePage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<ReglagePage> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fond_reglages.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 300),
              child: const Text(
                'Paramètres',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 75,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                ),
              ),
            ),
            FloatingActionButton.extended(
              label: const Text(
                'Mettre a jour les données',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ), // <-- Text
              backgroundColor: Colors.blue,
              icon: const Icon(Icons.system_update, size: 40),
              onPressed: () {},
            ),
            const Text(''),
            FloatingActionButton.extended(
              label: const Text(
                'Retour à la carte',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ), // <-- Text
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapPage()),
                );
              },
            ),
            const Text(''),
            FloatingActionButton.extended(
              label: const Text(
                'Crédits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ), // <-- Text
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreditPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
