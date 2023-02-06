// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:show_map/map.dart';
import 'global.dart';

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
        margin: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 50.0, right: 50.0, top: 50.0, bottom: 50.0),
              child: const Text(
                'Bienvenue dans la visite extérieur de la mine de Neuve-Maison',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
            ),
            const Tableau(),
          ],
        ),
      ),
    );
  }
}

choixParcours(context, choix) {
  Global.choixParcours = choix;
  if (kDebugMode) {
    print("Global.choixParcours ---> *${Global.choixParcours}*");
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MapPage()),
  );
}

class Tableau extends StatelessWidget {
  const Tableau({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: <TableRow>[
        TableRow(
          children: [
            Container(
              color: Colors.blue,
              child: Text(
                ' Choisissez votre parcours',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            GestureDetector(
              onTap: () {
                choixParcours(context, 1);
              },
              child: Text(
                ' Parcours 15-20 min',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            GestureDetector(
              onTap: () {
                choixParcours(context, 2);
              },
              child: Text(
                ' Parcours 30-45 min',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            GestureDetector(
              onTap: () {
                choixParcours(context, 3);
              },
              child: Text(
                ' Parcours 1h30-2h',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            )
          ],
        ),
        TableRow(
          children: [
            GestureDetector(
              onTap: () {
                choixParcours(context, 0);
              },
              child: Text(
                ' Parcours libre',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0),
              ),
            )
          ],
        ),
      ],
    );
  }
}
