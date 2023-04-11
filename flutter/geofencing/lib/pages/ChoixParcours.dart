import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geofencing/pages/map.dart';
import '../global.dart';

class ChoixParcours extends StatefulWidget {
  const ChoixParcours({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ChoixParcours> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fond_choix.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        '\n\nBienvenue dans la visite\nextérieur de la mine\nde Neuves-Maison.\n',
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
                  const Tableau(),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 50.0, right: 50.0, top: 30.0, bottom: 50.0),
                    child: const Text(
                      "Le prochain point conseillé s'affichera en rouge.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}

choixParcours(context, choix) {
  Global.selectParcours(choix);
  if (kDebugMode) {
    print("Global.choixParcours ----------------> *${Global.choixParcours}*");
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MapPage()),
  );
}

class Tableau extends StatelessWidget {
  const Tableau({super.key});

  List<TableRow> getParcours(context) {
    List<TableRow> parcours = [
      TableRow(
        children: [
          Container(
            color: const Color.fromARGB(255, 72, 68, 68),
            child: Center(
              child: Text(
                'Choisissez\nvotre parcours',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ];
    for (var element in Global.parcoursList) {
      parcours.add(
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0),
              color: const Color.fromARGB(150, 255, 255, 255),
              child: GestureDetector(
                onTap: () {
                  choixParcours(context, element.idParcours - 1);
                },
                child: Text(
                  element.duree,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 2.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
    parcours.add(
      TableRow(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0),
            color: const Color.fromARGB(150, 255, 255, 255),
            child: GestureDetector(
              onTap: () {
                choixParcours(context, -1);
              },
              child: Text(
                'Parcours libre',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            ),
          ),
        ],
      ),
    );

    return parcours;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: getParcours(context),
    );
  }
}
