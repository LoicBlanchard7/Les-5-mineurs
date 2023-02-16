import 'package:flutter/foundation.dart';
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
              margin: const EdgeInsets.only(top: 50, bottom: 300),
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
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: FloatingActionButton.extended(
                    label: const Text(
                      'Mettre a jour les données',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.blue,
                    icon: const Icon(Icons.system_update),
                    onPressed: () {
                      if (kDebugMode) {
                        print('reload data');
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: FloatingActionButton.extended(
                    label: const Text(
                      'Retour à la carte',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ), // <-- Text
                    backgroundColor: Colors.blue,
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
              margin: const EdgeInsets.only(left: 40, right: 40),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: FloatingActionButton.extended(
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
                        MaterialPageRoute(
                            builder: (context) => const CreditPage()),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
