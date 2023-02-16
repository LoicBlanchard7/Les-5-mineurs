import 'package:flutter/material.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, bottom: 70),
            child: const Text(
              'Crédits',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const Text(
            "Travail réalisé dans le cadre d'un projet tutoré incorporé dans la formation de LP CIASIE au sein de l'IUT Nancy-Charlemagne lors de l'année scolaire 2022-2023.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const Text(
            "Etudiants composants le groupe de travail :\n- Erwan Bourlon\nLoïc Blanchard\n- Léa Jarosz\n- Lilian Leblanc\n\nProfesseur référant au projet : Gérome Canals",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
